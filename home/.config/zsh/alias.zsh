#### Default Options #############################
alias ls="ls -Hp"
alias bc="bc -q"

#### Shortcut ####################################
alias vim="$EDITOR"
alias vi="$EDITOR"
alias v="$EDITOR"
alias lf="lfcd"
alias l="lfcd"
alias lg="lazygit"
alias L="lazygit"
alias B="hub browse"
alias j="jump"
alias page="$PAGER --paging=always"
alias bat="bat --paging=never"
alias la="ls -HpA"
alias ll="ls -Hpl"
alias ldk="lazydocker"
alias yay="pacapt"
alias cl="clear"
alias cls="clear && ls"
alias cll="printf '\033\143'"
alias :q="exit"
alias loc="tokei -s code"
alias top="btm -ufgl --autohide_time --hide_table_gap --mem_as_value"

#### Configs #####################################
alias .zsh="$EDITOR $ZDOTDIR/.zshrc"
alias .alias="$EDITOR $ZDOTDIR/alias.zsh"
alias .env="$EDITOR $HOME/.zprofile"
alias .nvim="$EDITOR $XDG_CONFIG_HOME/nvim/init.vim"
alias .hist="$EDITOR $MYHIST"
alias .conf="cd $XDG_CONFIG_HOME"

#### Functions ###################################
up() { fc -e "sed -i \"\" -e \"s| | $* |\"" }
up2() { fc -e "sed -i \"\" -e \"s| | $* |2\"" }

ip() { ifconfig | grep "inet " | tail -1 | cut -d " " -f 2 }

glog() { git log --oneline --no-decorate "-${1:-5}" ${@:2} }

bak() { cp -r "$1" "$1.bak" }
unbak() { mv "$1" $(sed "s/.bak$//" <<< "$1") }

mksh() { echo "#!/bin/sh" >> "$1" && chmod +x "$1" && "$EDITOR" "$1" }

#### Quick Select ################################
# list quick-select commands
ghelp() {
    echo "gl  - goto latest dirs"
    echo "gr  - goto repo"
    echo "grr - goto repo (deeper search)"
    echo "or  - open repo in browser"
    echo "lr  - open repo(s) in lazygit"
    echo "gt  - goto/open from ~/temp"
    echo "gs  - goto/open from ~/save"
}

# go to one of the lastest dirs
gl() {
    goto=$(cat "$DIRSTACKFILE" | $SELECTOR)
    [ "$goto" ] && cd "$goto"
}

# go to a repo
gr() {
    repo="$(cd ~/repos && fd -d1 | $SELECTOR)"
    [ "$repo" ] && cd "$HOME/repos/$repo"
}

# go to a repo (recursive)
grr() {
    repo="$(cd ~/repos && fd -d3 -t d -I -H "^.git$" |
        rev | cut -c 6- | rev | $SELECTOR)"
    [ "$repo" ] && cd "$HOME/repos/$repo"
}

# open a repo in the browser
or() {
    prev_dir=$(pwd) && gr && hub browse; cd "$prev_dir"
}

# use lazygit on one or more repos
lr() {
    for repo in $(cd ~/repos && fd -d1 | $SELECTOR --multi); do
        lazygit -p "$HOME/repos/$repo"
    done
}

# go to a dir or open a file in temp
gt() {
    sel="$HOME/temp/$(cd ~/temp && fd | $SELECTOR)"
    [ -d "$sel" ] && cd "$sel"
    [ -f "$sel" ] && "$EDITOR" "$sel"
}

# go to a dir or open a file in save
gs() {
    sel="$HOME/save/$(cd ~/save && fd | $SELECTOR)"
    [ -d "$sel" ] && cd "$sel"
    [ -f "$sel" ] && "$EDITOR" "$sel"
}

#### Save lf Dir #################################
lfcd () {
    tmp="$(mktemp)"
    command lf -last-dir-path="$tmp" "$@"
    [ -f "$tmp" ] && {
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] &&
            [ "$dir" != "$(pwd)" ] &&
                cd "$dir"
    }
}

#### Jump ########################################
# marks: lists all marks
# jump: jump to a mark named FOO
# mark z: create mark called "z" for current dir
# unmark z: delete the mark called "z"

markfile="$XDG_DATA_HOME/lf/marks"

marks() { cat "$markfile" | tr ':' ' ' }

jump() {
    new_dir=$(marks | $SELECTOR | cut -f 2 -d ' ')
    [ -d "$new_dir" ] && cd "$new_dir"
}

mark() {
    [[ $# != 1 ]] &&
        echo "must provide 1 argument" &&
        return 1

    [ ${#1} != 1 ] &&
        echo "argument must be 1 char" &&
        return 1

    grep "^${1}:" "$markfile" &&
        echo "that char is already assigned" &&
        return 1

    echo "${1}:$PWD" >> "$markfile"
}

unmark() {
    [[ $(uname -s) == Darwin ]] &&
        sed -i '' -e "/^${1}:/d" "$markfile" &&
        return 0

    sed -i "/^${1}:/d" "$markfile"
}
