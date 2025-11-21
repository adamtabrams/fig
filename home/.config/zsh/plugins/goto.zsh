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

# TODO: combine gg and gi

# go to a repo
gr() {
  [ "$1" ] && _filter_recent "$1" && return
  repo=$(FZF_DEFAULT_COMMAND=$(_fd_repos) fzf --query="$1")
  [ "$repo" ] && _cd_latest "$HOME/repos/$repo"
}

# go to a recent repo
# NOTE: still testing recent changes
grr() {
  repo=$(FZF_DEFAULT_COMMAND=$(_fd_repos --changed-within 1weeks) fzf --no-clear)
  [ "$repo" ] && tput rmcup && _cd_latest "$HOME/repos/$repo" && return
  gr
}

# go to one of the lastest dirs
# TODO: trim and sort instead of just filter
gl() {
  goto=$(grep -E "^[~]*(/[^/]*){1,4}$" $DIRSTACKFILE | sed "s|^$HOME|~|" | fzf | sed "s|^~|$HOME|")
  [ "$goto" ] && cd "$goto"
}

# goto root dir of current repo
gg() {
  dot_git_path=$(git rev-parse --git-dir 2>/dev/null)
  [  "$dot_git_path" ] && cd "$(dirname "$dot_git_path")"
}

# go to one of the lastest dirs below current directory
gi() {
  goto=$(grep "^$PWD/" $DIRSTACKFILE | sed "s,^$PWD/,," | fzf)
  [ "$goto" ] && cd "$goto"
}

# go to one of the lastest dirs in current repo
# NOTE: still testing this. this may not be needed
ga() {
  gg
  gi
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

gt() { _cd_dir_open_file "$HOME/temp" }
gs() { _cd_dir_open_file "$HOME/save" }
g.c() { _cd_dir_open_file "$XDG_CONFIG_HOME" --follow }
g.l() { _cd_dir_open_file "$XDG_DATA_HOME" --follow }

# helper function to go to dir or open file for a given path
_cd_dir_open_file() {
  parentdir=$1
  subdir=$(cd "$parentdir" && fd -t d ${@:2} | fzf --no-clear --header "cd to dir" --header-first)
  [ "$subdir" ] && parentdir="$parentdir/$subdir" && cd "$parentdir"
  file=$(cd "$parentdir" && fd -t f ${@:2} | fzf --header "open file" --header-first)
  [ "$file" ] && "$EDITOR" "$parentdir/$file"
}

# helper function to find all git repos with fd
_fd_repos() {
  echo "fd -IH -d 3 -t d $@ --format '{//}' --base-directory ~/repos '^.git$'"
}

# helper function to go to recent repo dir if only one match exists
_filter_recent() {
  query="$1"
  grep -E "^[~]*(/[^/]*){1,4}$" $DIRSTACKFILE | _cd_if_uniq "$1" && return
  eval $(_fd_repos --changed-within 4weeks) | _cd_if_uniq "$1" "$HOME/repos/" && return
  eval $(_fd_repos) | _cd_if_uniq "$1" "$HOME/repos/" && return
  return 1
}

_cd_if_uniq() {
  query=$1
  path_prefix=$2
  match=$(sed "s|^$HOME|~|" | grep "$query" | sed "s|^~|$HOME|")
  [ ! "$match" ] || [ $(echo "$match" | wc -l) != 1 ] && return 1
  _cd_latest "$path_prefix$match"
}

_cd_latest() {
  parentdir=$1
  latest=$(grep -E "^$parentdir$|^$parentdir/" $DIRSTACKFILE | head -n 1)
  [ "$latest" ] && cd "$latest" && return
  cd "$parentdir"
}
