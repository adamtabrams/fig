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
        cut -c 3- | "$SELECTOR")"
    [ "$repo" ] && cd "$HOME/repos/$repo"
}

# go to a recent repo
grr() {
    repo="$(cd ~/repos && fd -d3 -t d -I -H --changed-within 4weeks "^.git$" -x dirname |
        cut -c 3- | "$SELECTOR")"
    [ "$repo" ] && cd "$HOME/repos/$repo"
}

# go to one of the lastest dirs
gl() {
    goto=$(cat "$DIRSTACKFILE" | "$SELECTOR")
    [ "$goto" ] && cd "$goto"
}

# go to one of the lastest dirs below current directory
gi() {
    goto=$(cat "$DIRSTACKFILE" | grep "^$PWD." | "$SELECTOR")
    [ "$goto" ] && cd "$goto"
}

# open a repo in the browser
or() {
    prev_dir=$PWD && gr && gopen; cd "$prev_dir"
}

# use lazygit on one or more repos
lr() {
    for repo in "$(cd "~/repos" && fd -d1 | "$SELECTOR" --multi)"; do
        lazygit -p "$HOME/repos/$repo"
    done
}

# helper funcion to go to dir or open file for a given path
_goto_or_open() {
    parent_path="$1"
    sel="$parent_path/$(cd "$parent_path" && fd "${@:2}" | "$SELECTOR")"
    [ -d "$sel" ] && cd "$sel"
    [ -f "$sel" ] && "$EDITOR" "$sel"
}

gt() { _goto_or_open "$HOME/temp" }
gs() { _goto_or_open "$HOME/save" }
g.c() { _goto_or_open "$XDG_CONFIG_HOME" --follow }
g.l() { _goto_or_open "$XDG_DATA_HOME" --follow }
