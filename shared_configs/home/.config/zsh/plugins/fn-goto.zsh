# list quick-select commands
ghelp() {
  echo "gr  - goto repo"
  echo "grr - goto recent repo"
  echo "gg  - goto root of repo"
  echo "gi  - goto latest dir inside current"
  echo "gl  - goto latest dir"
  echo "or  - open repo in browser"
  echo "lr  - open repo(s) in lazygit"
  echo "gt  - goto/open from ~/temp"
  echo "gs  - goto/open from ~/save"
  echo "g.c - goto/open from ~/.config"
  echo "g.l - goto/open from ~/.local"
}

# go to a repo
# NOTE: still testing this
gr() {
  [ "$1" ] && _filter_recent "$1" && return
  repo=$(FZF_DEFAULT_COMMAND=$(_fd_repos) fzf --query="$1")
  [ "$repo" ] && cd "$HOME/repos/$repo"
}

# go to a recent repo
# NOTE: still testing this
grr() {
  repo=$(FZF_DEFAULT_COMMAND=$(_fd_repos --changed-within 4weeks) fzf --no-clear)
  [ "$repo" ] && tput rmcup && cd "$HOME/repos/$repo" && return
  gr
}

# go to one of the lastest dirs
# TODO: trim and sort instead of just filter
gl() {
  goto=$(cat $DIRSTACKFILE | sed "s|^$HOME|~|" | grep -E "^[~]*(/[^/]*){1,4}$" | fzf |  sed "s|^~|$HOME|")
  [ "$goto" ] && cd "$goto"
}

# goto root dir of current repo
gg() {
  dot_git_path=$(git rev-parse --git-dir 2>/dev/null)
  [  "$dot_git_path" ] && cd "$(dirname "$dot_git_path")"
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

# use lazygit on one or more repos
# TODO: consider lf and gitui
lr() {
  for repo in $(FZF_DEFAULT_COMMAND=$(_fd_repos) fzf --query="$1" --multi); do
    lazygit -p "$HOME/repos/$repo"
  done
}

gt() { _goto_or_open "$HOME/temp" }
gs() { _goto_or_open "$HOME/save" }
g.c() { _goto_or_open "$XDG_CONFIG_HOME" --follow }
g.l() { _goto_or_open "$XDG_DATA_HOME" --follow }

# helper funcion to go to dir or open file for a given path
_goto_or_open() {
  parent=$1

  goto=$(cd "$parent" && fd -t d ${@:2} | fzf --no-clear)
  [ "$goto" ] && tput rmcup && cd "$parent/$goto" && return

  goto=$(cd "$parent" && fd -t f ${@:2} | fzf)
  [ "$goto" ] && cd $(dirname "$parent/$goto") && "$EDITOR" "$parent/$goto"
}

# helper funcion to go to recent dir if only one match exists
_filter_recent() {
  goto=$(sed "s|^$HOME|~|" $DIRSTACKFILE | grep -E "^[~]*(/[^/]*){1,4}$" | fzf --filter="$1" | sed "s|^~|$HOME|")
  [ $(echo "$goto" | wc -l) = 1 ] && cd "$goto" && return

  goto=$(FZF_DEFAULT_COMMAND=$(_fd_repos --changed-within 4weeks) fzf --filter="$1")
  [ $(echo "$goto" | wc -l) = 1 ] && cd "$HOME/repos/$goto" && return

  return 1
}

# helper funcion to find all git repos with fd
_fd_repos() {
  echo "fd -IH -d 3 -t d $@ --format '{//}' --base-directory ~/repos '^.git$'"
}
