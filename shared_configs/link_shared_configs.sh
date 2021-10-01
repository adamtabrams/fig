#!/bin/sh

[ ! -f ../.script_utils.sh ] &&
    { echo "must call script from within '*_configs' directory" >&2; exit 4; }

. ../.script_utils.sh

set_debug_mode
. ../.script_utils.sh

fig_home=$(get_fig_home)
fig_swap=$(get_fig_swap)

link_dirs=$(get_link_dirs "$fig_home")
link_files=$(get_link_files "$fig_home")

echo "STARTING"

IFS="
"
for dir in $link_dirs; do
    link_files=$(echo "$link_files" | grep -v "$dir")
    create_link "$fig_home" "$fig_swap" "$dir"
done

for file in $link_files; do
    create_link "$fig_home" "$fig_swap" "$file"
done

echo "DONE"
