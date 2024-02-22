glog() { git log --oneline --no-decorate "-${1:-5}" ${@:2} }

gopen() { open $(git ls-remote --get-url) }

gclone() {
    dir=$(echo $1 | sed "s|^.*\.com/\(.*\)\.git$|\1|" )
    cd "$HOME/repos" || { echo "error moving to ~/repos" >&2; return 1; }
    [ -e $dir ] && { echo "already exists" >&2; return 2; }
    git clone $1 "$dir"
    cd "$dir" && echo "cd $dir"
}

gcurl() {
    url=$(echo "$1" | sed -e 's|://github\.com|://raw.githubusercontent.com|' -e 's|\(://github\..*\.com\)|\1/raw|' -e 's|/blob/|/|')
    file=${2:-$(basename "$url")}
    [ ! "$url" ] && { echo "no url provided"; return; }
    [ -e "$file" ] && { echo "already exists: $file"; return; }
    curl "$url" > "$file"
}
