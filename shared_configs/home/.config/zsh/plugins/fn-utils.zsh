mksh() { echo "#!/bin/sh" >> "$1" && chmod +x "$1" && "$EDITOR" "$1" }

bak() { cp -r "$1" "$1.bak" }
unbak() { mv "$1" $(sed "s/.bak$//" <<< "$1") }

cl() {
    printf "\n\n"
    for i in $(seq "$(tput cols)"); do
        printf "%s" "${1:-#}"
    done
    clear
}

ip() { ifconfig | grep "inet " | tail -1 | cut -d " " -f 2 }
