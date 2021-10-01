export BROWSER="/Applications/Brave\ Browser.app/Contents/MacOS/Brave\ Browser"

FontSmoothing=$(defaults read -g CGFontRenderingFontSmoothingDisabled 2&>/dev/null)
[ "$FontSmoothing" = 1 ] &&
    defaults write -g CGFontRenderingFontSmoothingDisabled -bool NO

which gdircolors &>/dev/null &&
    eval $(gdircolors $ZDOTDIR/dircolors.ansi-dark) ||
    echo "need 'gdircolors' program to set terminal colors" >&2
