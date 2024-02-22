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
  histfile_ln=$(wc -l < "$HISTFILE")
  backup_ln=$(wc -l < "$backup")

  [ "$backup_ln" -gt "$histfile_ln" ] && { _history_fix; return 3; }

  for file in ${backup}(N.mh+24); do
    [ "$histfile_ln" -gt "$backup_ln" ] && cp "$HISTFILE" "$backup"
    return
  done
}

_history_backup
