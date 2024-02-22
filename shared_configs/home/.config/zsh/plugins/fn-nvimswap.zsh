nvim_swap_rm() {
    swap_dir="$XDG_STATE_HOME/nvim/swap"
    rm_files=$(cd "$swap_dir" && find . -type f | fzf -m)

    for file in $rm_files; do
        rm "$swap_dir/$file"
    done
}
