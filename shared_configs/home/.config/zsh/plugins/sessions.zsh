_sessions="$XDG_STATE_HOME/zsh/sessions"
_active="$_sessions/active"

_select_session() {
  _act=$(cat "$_active")
  [ ! -f "$_sessions/$_act" ] && _act=''

  _sel=$(cd "$_sessions" && ls -1 | sort -rn | fzf +m --header "active: $_act" --header-first)
  [ "$_sel" ] && echo "$_sel" > "$_active"
}

_rm_session() {
  for _selected in $(cd "$_sessions" && ls -1 | sort -rn | fzf -m); do
    rm "$_sessions/$_selected"
  done
}

_save_path() {
  mkdir -p "$_sessions"
  _today=$(date +%Y%m%d)
  pwd >> "$_sessions/$_today"
  echo "$_today" > "$_active"
}

_save_path_quit() {
  _save_path
  exit
}

_read_session() {
  _file="$_sessions/$(cat "$_active")"
  [ ! -f "$_file" ] && { echo "select a valid session" >&2; return; }
  cat "$_file" | sort | uniq
}

_pop_path() {
  _file="$_sessions/$(cat "$_active")"
  [ ! -f "$_file" ] && { echo "select a valid session" >&2; return; }

  _all_paths=$(cat "$_file" | sort | uniq)
  _cur_path=$(echo "$_all_paths" | tail -n 1)
  if [ -d "$_cur_path" ]; then
    echo "opening $_cur_path" >&2
    cd "$_cur_path" && open -n "$TERMINALAPP"
  else
    echo "$_cur_path is no longer a valid directory" >&2
  fi

  _remaining_paths=$(echo "$_all_paths" | sed -n '$!p')
  [ ! "$_remaining_paths" ] && { echo "session empty" >&2; rm "$_file"; return }
  echo "$_remaining_paths" > "$_file"
}

_session_usage() {
  echo ":help - view session commands"
  echo ":e    - pop path from active session"
  echo ":cat  - read active session"
  echo ":ls   - change active session"
  echo ":rm   - delete a session"
  echo ":w    - save path to active session"
  echo ":q    - exit shell"
  echo ":wq   - save path then exit shell"
}

alias :help="_session_usage"
alias :e="_pop_path"
alias :cat="_read_session"
alias :ls="_select_session"
alias :rm="_rm_session"
alias :w="_save_path"
alias :q="exit"
alias :wq="_save_path_quit"
