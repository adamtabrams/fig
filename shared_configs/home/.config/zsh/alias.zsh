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
alias j="jump"
alias pager="$PAGER --paging=always"
alias bat="bat --paging=never"
alias hist="fc -l -ndfD"
alias la="ls -HpA"
alias ll="ls -Hpl"
alias ca="calcurse"
alias ldk="lazydocker"
alias yay="pacapt"
alias cll="printf '\033\143'"
alias loc="tokei -s code"
alias top="btm -ufgl --autohide_time --hide_table_gap --mem_as_value"
alias topgrade="topgrade --disable system node pip3 containers"

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

cl() {
    printf "\n\n"
    for i in $(seq "$(tput cols)"); do
        printf "%s" "${1:-#}"
    done
    clear
}

glog() { git log --oneline --no-decorate "-${1:-5}" ${@:2} }

gopen() { open $(git ls-remote --get-url) }

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

#### Quick Select ################################
# list quick-select commands
ghelp() {
    echo "gg  - goto root of repo"
    echo "gr  - goto repo"
    echo "grr - goto recent repo"
    echo "gl  - goto latest dir"
    echo "gi  - goto latest dir inside current"
    echo "or  - open repo in browser"
    echo "lr  - open repo(s) in lazygit"
    echo "gt  - goto/open from ~/temp"
    echo "gs  - goto/open from ~/save"
    echo "g.c - goto/open from ~/.config"
    echo "g.l - goto/open from ~/.local"
}

# goto root dir of current repo
gg() {
    dot_git_path="$(git rev-parse --git-dir 2>/dev/null)"
    [  "$dot_git_path" ] && cd "$(dirname "$dot_git_path")"
}

# go to a repo
gr() {
    repo="$(cd ~/repos && fd -d3 -t d -I -H "^.git$" -x dirname |
        cut -c 3- | $SELECTOR)"
    [ "$repo" ] && cd "$HOME/repos/$repo"
}

# go to a recent repo
grr() {
    repo="$(cd ~/repos && fd -d3 -t d -I -H --changed-within 4weeks "^.git$" -x dirname |
        cut -c 3- | $SELECTOR)"
    [ "$repo" ] && cd "$HOME/repos/$repo"
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
    prev_dir=$(pwd) && gr && gopen; cd "$prev_dir"
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

#### History #####################################
history_check_backup() {
    [ ! "$MYHIST" ] && { echo "No MYHIST env var defined" >&2; return 1; }
    backup="${MYHIST}.bak"

    echo "History file lines: $(wc -l < "$MYHIST")" >&2
    echo "Backup file lines:  $(wc -l < "$backup")" >&2
}

history_fix() {
    [ ! "$MYHIST" ] && { echo "No MYHIST env var defined" >&2; return 1; }
    backup="${MYHIST}.bak"

    history_check_backup
    echo "Would you like append current history to backup? (y/n)" >&2
    read -r answer
    [ "$answer" = "y" ] && cat "$MYHIST" >> "$backup"
    echo "Would you like replace current history with backup? (y/n)" >&2
    read -r answer
    [ "$answer" = "y" ] && cp "$backup" "$MYHIST"
    echo "DONE" >&2
    history_check_backup
}

history_backup() {
    [ ! "$MYHIST" ] && { echo "No MYHIST env var defined" >&2; return 1; }

    parent_dir=$(dirname "$MYHIST")
    [ ! -d "$parent_dir" ] && mkdir -p "$parent_dir"
    [ ! -f "$MYHIST" ] && touch "$MYHIST"

    backup="${MYHIST}.bak"
    last_changed=$(stat -t "%Y%m%d" -qf "%Sc" "$backup")
    touch "$backup"

    today=$(date +%Y%m%d)
    histfile_ln=$(wc -l < "$MYHIST")
    backup_ln=$(wc -l < "$backup")

    [ "$last_changed" != "$today" ] && [ "$histfile_ln" -gt "$backup_ln" ] &&
        { cp "$MYHIST" "$backup"; return; }

    [ "$histfile_ln" -ge "$backup_ln" ] && return

    history_fix
}

#### Clipedit ####################################
clipedit() {
    editor_cmd=${EDITOR:-vim}
    copy_cmd=${COPYCMD:-pbcopy}
    paste_cmd=${PASTECMD:-pbpaste}
    temp_file=$(mktemp)

    "$paste_cmd" > "$temp_file"
    "$editor_cmd" "$temp_file"
    "$copy_cmd" < "$temp_file"
    rm "$temp_file"
}

#### Nvim Swap ###################################
nvim_swap_rm() {
    # swap_dir="$XDG_DATA_HOME/nvim/swap"
    swap_dir="$XDG_STATE_HOME/nvim/swap"
    rm_files=$(cd "$swap_dir" && find . -type f | fzf -m)

    for file in $rm_files; do
        rm "$swap_dir/$file"
    done
}

#### Save lf Dir #################################
lfcd() {
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

#### Session Save ################################
_savefile="$XDG_DATA_HOME/savepaths/paths"

clear_savepaths() { printf '' > "$_savefile" }
edit_savepaths() { "$EDITOR" "$_savefile" }
list_savepaths() { cat "$_savefile" }
save_path() { pwd >> "$_savefile" }

save_path_quit() {
    save_path
    exit
}

pop_savepath() {
    lines=$(cat "$_savefile")
    [ ! "$lines" ] && { echo "no saved paths" >&2; return; }
    last=$(echo "$lines" | tail -n 1)
    echo "opening $last" >&2
    cd "$last"
    open -n "$TERMINALAPP"
    echo "$lines" | sed -n '$!p' > "$_savefile"
}

alias :clear="clear_savepaths"
alias :edit="edit_savepaths"
alias :pop="pop_savepath"
alias :ls="list_savepaths"
alias :wq="save_path_quit"
alias :w="save_path"
alias :q="exit"
alias gW="save_path_quit"
alias gw="save_path"

#### Jump ########################################
# marks: lists all marks
# jump: jump to a mark named FOO
# mark z: create mark called "z" for current dir
# unmark z: delete the mark called "z"

_markfile="$XDG_DATA_HOME/lf/marks"

marks() { cat "$_markfile" | tr ':' ' ' }

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

    grep "^${1}:" "$_markfile" &&
        echo "that char is already assigned" &&
        return 1

    echo "${1}:$PWD" >> "$_markfile"
}

unmark() {
    [[ $(uname -s) == Darwin ]] &&
        sed -i '' -e "/^${1}:/d" "$_markfile" &&
        return 0

    sed -i "/^${1}:/d" "$_markfile"
}
