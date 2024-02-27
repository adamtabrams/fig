_history_fix() {
  backup="${HISTFILE}.bak"

  echo "START HISTORY FIX" >&2
  echo "History file lines: $(wc -l < "$HISTFILE")" >&2
  echo "Backup file lines:  $(wc -l < "$backup")" >&2

  echo "Would you like append current history to backup? (y/n)" >&2
  read -r answer
  [ "$answer" = "y" ] && cat "$HISTFILE" >> "$backup"

  echo "Would you like replace current history with backup? (y/n)" >&2
  read -r answer
  [ "$answer" = "y" ] && cp "$backup" "$HISTFILE"

  echo "DONE" >&2
  echo "History file lines: $(wc -l < "$HISTFILE")" >&2
  echo "Backup file lines:  $(wc -l < "$backup")" >&2
}

_history_backup() {
  [ ! "$HISTFILE" ] && { echo "No HISTFILE env var defined" >&2; return 1; }
  [ ! -e "$HISTFILE" ] && { echo "No file exists matching HISTFILE env var" >&2; return 2; }

  backup="${HISTFILE}.bak"
  zstat -A sizes +size -- "$HISTFILE" "$backup" ||
    { echo "zshrc should have: zmodload -F zsh/stat b:zstat" >&2; return 3; }
  histfile_size=$sizes[1]
  backup_size=$sizes[2]

  [ "$backup_size" -gt "$histfile_size" ] && { _history_fix; return 4; }

  for file in ${backup}(N.mh+24); do
    [ "$histfile_size" -gt "$backup_size" ] && cp "$HISTFILE" "$backup"
    return
  done
}

_history_backup
