#!/bin/sh

usage() {
  echo "usage: $0 [ --dry-run ] [ --confirm ]" >&2
}

set_dryrun() {
  echo 'dry-run: enabled' >&2
  alias mv='echo mv'
  alias rm='echo rm'
  alias ln='echo ln'
  alias mkdir='echo mkdir'
  mktemp() { echo '/fake/temp'; }
}

case $1 in
-h | --help | help) usage && exit ;;
--dry-run) set_dryrun ;;
--confirm) ;;
'') echo 'flag required' >&2 && exit 1 ;;
*) echo 'invalid argument' >&2 && exit 1 ;;
esac

backup() {
  name=$1
  temp=$2

  [ -L "$HOME/$name" ] && return
  [ ! -f "$HOME/$name" ] && [ ! -d "$HOME/$name" ] && return

  mv "$HOME/$name" "$temp/$name" && echo "WARNING: moved existing $name to $temp" >&2 || exit 2
}

create_link() {
  name=$1

  parent=$(dirname "$HOME/$name")
  [ -L "$parent" ] && rm "$parent"
  [ ! -d "$parent" ] && mkdir -p "$parent"

  ln -sFhv "$(pwd)/home/$name" "$HOME/$name" && echo "created link for $name" >&2
}

platform=$(uname | tr '[:upper:]' '[:lower:]')
[ ! "$platform" ] && echo 'could not determine platform' >&2 && exit 1
[ ! -d home ] && echo 'could not find ./home dir' >&2 && exit 1

echo "platform: $platform" >&2
echo 'starting' >&2

temp=$(mktemp -d)

files=$(grep -E "^all|^$platform" home/.fig | tr -s ' ' | cut -d ' ' -f 2)
for f in $files; do
  [ ! -f "$(pwd)/home/$f" ] && echo "file configured but not found: $f" >&2 && exit 1
  backup "$f" "$temp"
  create_link "$f"
done

dirs=$(cd home && find . -mindepth 3 -type f -name '.fig' | cut -c 3-)
for d in $dirs; do
  grep -qE "^all|^$platform" "home/$d" || continue
  backup "$(dirname "$d")" "$temp"
  create_link "$(dirname "$d")"
done

echo 'done' >&2
