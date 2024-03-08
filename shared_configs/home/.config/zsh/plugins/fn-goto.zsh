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
    dot_git_path=$(git rev-parse --git-dir 2>/dev/null)
    [  "$dot_git_path" ] && cd "$(dirname "$dot_git_path")"
}

# TODO: swapped names for testing

# go to a repo
grr() {
    repo=$(cd ~/repos && FZF_DEFAULT_COMMAND=$(_fzf_repos_cmd) fzf)
    [ "$repo" ] && cd "$HOME/repos/$repo"
}

# go to a recent repo
gr() {
    repo=$(cd ~/repos && FZF_DEFAULT_COMMAND=$(_fzf_repos_cmd --changed-within 4weeks) fzf)
    [ "$repo" ] && cd "$HOME/repos/$repo"
}

# go to one of the lastest dirs
gl() {
    goto=$(cat $DIRSTACKFILE | sed "s|^$HOME|~|" | grep -E "^[~]*(/[^/]*){1,4}$" | fzf |  sed "s|^~|$HOME|")
    [ "$goto" ] && cd "$goto"
}

# go to one of the lastest dirs below current directory
gi() {
    goto=$(grep "^$PWD." "$DIRSTACKFILE" | fzf)
    [ "$goto" ] && cd "$goto"
}

# open a repo in the browser
or() {
    prev_dir=$PWD && gr && remote_url=$(git ls-remote --get-url) && open "$remote_url"
    [ $(pwd) != "$prev_dir" ] && cd "$prev_dir"
}

# TODO: consider lf and gitui

# use lazygit on one or more repos
lr() {
    for repo in $(cd ~/repos && FZF_DEFAULT_COMMAND=$(_fzf_repos_cmd) fzf --multi); do
        lazygit -p "$HOME/repos/$repo"
    done
}

gt() { _goto_or_open "$HOME/temp" }
gs() { _goto_or_open "$HOME/save" }
g.c() { _goto_or_open "$XDG_CONFIG_HOME" --follow }
g.l() { _goto_or_open "$XDG_DATA_HOME" --follow }

# helper funcion to go to dir or open file for a given path
_goto_or_open() {
    parent_dir=$1
    goto=$(cd $parent_dir && fd ${@:2} | fzf)
    [ ! "$goto" ] && return
    goto_full="$parent_dir/$goto"
    [ -d "$goto_full" ] && cd "$goto_full"
    [ -f "$goto_full" ] && cd $(dirname "$goto_full") && "$EDITOR" "$goto_full"
}

_fzf_repos_cmd() {
  echo "fd -d 3 -t d -I -H --strip-cwd-prefix $@ '^.git$' -x dirname"
}
