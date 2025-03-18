gd() {
  dir=$(command due go)
  [ ! "$dir" ] && return
  cd "$dir" || return
}
