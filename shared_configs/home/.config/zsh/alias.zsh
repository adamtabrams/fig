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
alias pager="$PAGER --paging=always"
alias bat="bat --paging=never"
alias la="ls -HpA"
alias ll="ls -Hpl"
alias ca="calcurse"
alias ldk="lazydocker"
alias yay="pacapt"
alias cll="printf '\033\143'"
alias :q="exit"
alias loc="tokei -s code"
alias top="btm -ufgl --autohide_time --hide_table_gap --mem_as_value"
alias topgrade="topgrade --disable system node pip3 gcloud"

#### Configs #####################################
alias .zsh="$EDITOR $ZDOTDIR/.zshrc"
alias .alias="$EDITOR $ZDOTDIR/alias.zsh"
alias .env="$EDITOR $HOME/.zprofile"
alias .nvim="$EDITOR $XDG_CONFIG_HOME/nvim/init.vim"
alias .hist="$EDITOR $MYHIST"
alias .conf="cd $XDG_CONFIG_HOME"

#### Functions ###################################
ip() { ifconfig | grep "inet " | tail -1 | cut -d " " -f 2 }

mksh() { echo "#!/bin/sh" >> "$1" && chmod +x "$1" && "$EDITOR" "$1" }

bak() { cp -r "$1" "$1.bak" }
unbak() { mv "$1" $(sed "s/.bak$//" <<< "$1") }

glog() { git log --oneline --no-decorate "-${1:-5}" ${@:2} }
gclone() {
    dir=$(echo $1 | sed "s|^.*\.com/\(.*\)\.git$|\1|" )
    cd "$HOME/repos" || { echo "error moving to ~/repos" >&2; return 1; }
    [ -e $dir ] && { echo "already exists" >&2; return 2; }
    git clone $1 "$dir"
    cd "$dir" && echo "cd $dir"
}
gcurl() {
    url=$(echo "$1" | sed -e 's|://github\.com|://raw.githubusercontent.com|' -e 's|\(://github\..*\.com\)|\1/raw|' -e 's|/blob/|/|')
    file=${2:-$(basename "$url")}
    [ ! "$url" ] && { echo "no url provided"; return; }
    [ -e "$file" ] && { echo "already exists: $file"; return; }
    curl "$url" > "$file"
}

cl() {
    printf "\n\n"
    for i in $(seq "$(tput cols)"); do
        printf "%s" "${1:-#}"
    done
    clear
}

#### Quick Select ################################
# list quick-select commands
ghelp() {
    echo "gr  - goto repo"
    echo "gg  - goto root of repo"
    echo "gl  - goto latest dir"
    echo "gi  - goto latest dir inside current"
    echo "or  - open repo in browser"
    echo "lr  - open repo(s) in lazygit"
    echo "gt  - goto/open from ~/temp"
    echo "gs  - goto/open from ~/save"
    echo "g.c - goto/open from ~/.config"
    echo "g.l - goto/open from ~/.local"
}

# go to a repo
gr() {
    repo="$(cd ~/repos && fd -d3 -t d -I -H "^.git$" |
        rev | cut -c 6- | rev | $SELECTOR)"
    [ "$repo" ] && cd "$HOME/repos/$repo"
}

# goto root dir of current repo
gg() {
    dot_git_path="$(git rev-parse --git-dir 2>/dev/null)"
    [  "$dot_git_path" ] && cd "$(dirname "$dot_git_path")"
}

# go to one of the lastest dirs
gl() {
    goto=$(cat "$DIRSTACKFILE" | $SELECTOR)
    [ "$goto" ] && cd "$goto"
}

# go to one of the lastest dirs below current directory
gi() {
    goto=$(cat "$DIRSTACKFILE" | grep "^$(pwd)." | $SELECTOR)
    [ "$goto" ] && cd "$goto"
}

# open a repo in the browser
or() {
    prev_dir=$(pwd) && gr && hub browse; cd "$prev_dir"
}

# use lazygit on one or more repos
lr() {
    for repo in $(cd "~/repos" && fd -d1 | $SELECTOR --multi); do
        lazygit -p "$HOME/repos/$repo"
    done
}

# helper funcion to go to dir or open file for a given path
_goto_or_open() {
    parent_path="$1"
    sel="$parent_path/$(cd "$parent_path" && fd "${@:2}" | $SELECTOR)"
    [ -d "$sel" ] && cd "$sel"
    [ -f "$sel" ] && "$EDITOR" "$sel"
}

gt() { _goto_or_open "$HOME/temp" }
gs() { _goto_or_open "$HOME/save" }
g.c() { _goto_or_open "$XDG_CONFIG_HOME" --follow }
g.l() { _goto_or_open "$XDG_DATA_HOME" --follow }

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
