# print current local ip
ip() { ifconfig | grep "inet " | tail -1 | cut -d " " -f 2 }

# clear terminal view and leave visual marker
cl() {
  printf "\n\n"
  for i in $(seq "$(tput cols)"); do
    printf "%s" "${1:-#}"
  done
  clear
}

# start editing new shell script
mksh() {
  echo "#!/bin/sh" >> "$1" && chmod +x "$1" && "$EDITOR" "$1"
}

# copy original file/dir to a backup
bak() {
  bak=$(_get_bak_name $1)
  [ -e "$bak" ] && { echo "backup already exists" >&2; return 1; }
  cp -r "$1" "$bak"
}

# copy original file/dir to a backup (overwrites existing backup)
rebak() {
  bak=$(_get_bak_name $1)
  [ ! -e "$bak" ] && { echo "no existing backup found" >&2; return 1; }
  cp -r "$1" "$bak"
}

# remove the .bak extension from a given backup
unbak() {
  nonbak=$(sed -E "s|-bak([^/]*)$|\1|" <<< $1)
  [ -e "$nonbak" ] && { echo "non-backup still exists" >&2; return 1; }
  mv "$1" "$nonbak"
}

# helper function to add -bak to the filename before the extension
_get_bak_name() {
  dir=$(dirname $1)
  base=$(basename $1)
  name=${base%%.*}
  ext=${base#*$name}
  echo "$dir/$name-bak$ext"
}
