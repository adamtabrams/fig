wezsave() {
  _sessions="$XDG_STATE_HOME/zsh/sessions"
  _today="$_sessions/$(date +%Y%m%d)"
  [ -f "$_today" ] && echo 'session already exists' >&2 && return 1
  wezterm cli list --format json | jq -r '.[].cwd' | cut -c8- > "$_today"
}
