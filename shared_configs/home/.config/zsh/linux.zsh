# export BROWSER="/bin/brave-browser"

which dircolors &>/dev/null &&
    eval $(dircolors $ZDOTDIR/dircolors.ansi-dark) ||
    echo "need 'dircolors' program to set terminal colors" >&2
