export BROWSER="/Applications/Brave\ Browser.app/Contents/MacOS/Brave\ Browser"

which gdircolors &>/dev/null && eval $(gdircolors $ZDOTDIR/dircolors.ansi-dark)

FontSmoothing=$(defaults read -g CGFontRenderingFontSmoothingDisabled) 2&>/dev/null
[ "$FontSmoothing" = 1 ] &&
    defaults write -g CGFontRenderingFontSmoothingDisabled -bool NO
