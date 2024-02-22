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
