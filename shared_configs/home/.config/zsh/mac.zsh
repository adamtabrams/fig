export BROWSER="/Applications/Brave\ Browser.app/Contents/MacOS/Brave\ Browser"

# smooth_font1=$(defaults read -g CGFontRenderingFontSmoothingDisabled 2&>/dev/null)
# [ "$smooth_font1" != 0 ] &&
#     defaults write -g CGFontRenderingFontSmoothingDisabled -bool NO

# smooth_font2=$(defaults read -g AppleFontSmoothing 2&>/dev/null)
# [ "$smooth_font2" != 0 ] &&
#     defaults write -g AppleFontSmoothing -int 0

which gdircolors &>/dev/null &&
    eval $(gdircolors $ZDOTDIR/dircolors.ansi-dark) ||
    echo "need 'gdircolors' program to set terminal colors" >&2
