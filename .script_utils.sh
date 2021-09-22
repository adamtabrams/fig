debug_echo() {
    echo "> " "$@" >&2
}

set_debug_mode() {
    alias mkdir="debug_echo mkdir"
    alias mv="debug_echo mv"
    alias rm="debug_echo rm"
    alias ln="debug_echo ln"
}

get_fig_home() {
    fig_root=$(pwd)
    [ "${fig_root%%/*}" ] &&
        { echo "error getting path of fig dir" >&2; exit 1; }

    fig_home="$fig_root/home"
    [ ! -d "$fig_home" ] && mkdir -p "$fig_home"

    echo "$fig_home"
}

get_fig_swap() {
    xdg_data_home=${XDG_DATA_HOME:-$HOME/.local/share}

    fig_swap="$xdg_data_home/fig/$(date +%FT%H:%M:%S)"
    [ ! -d "$fig_swap" ] && mkdir -p "$fig_swap"

    echo "$fig_swap"
}

get_link_dirs() {
    fig_home=$1
    find "$fig_home" -mindepth 1 -type f -name ".figlink" -exec dirname {} \; | grep -v "^$"
}

get_link_files() {
    fig_home=$1
    find "$fig_home" -mindepth 1 -type f
}

get_existing_path() {
    fig_home=$1
    target=$2
    echo "$target" | sed "s|$fig_home|$HOME|"
}

get_backup_path() {
    fig_swap=$1
    existing=$2
    echo "$fig_swap/$(echo "$existing" | tr "/" "%")"
}

needs_backup() {
    existing=$1
    [ ! -L "$existing" ] && { [ -d "$existing" ] || [ -f "$existing" ]; } && return 0
    return 1
}

create_link() {
    fig_home=$1
    fig_swap=$2
    target=$3

    existing=$(get_existing_path "$fig_home" "$target")

    needs_backup "$existing" &&
        ! mv "$existing" "$(get_backup_path "$fig_swap" "$existing")" &&
        { echo "error backing up $existing" >&2; exit 2; }

    echo "moved existing $(basename "$existing") to $fig_swap"

    parent_dir=$(dirname "$existing")
    [ -L "$parent_dir" ] && rm "$parent_dir"
    [ ! -d "$parent_dir" ] && mkdir -p "$parent_dir"

    ln -sFh "$target" "$existing" && echo "created link for $existing"
}
