alias dircolors=gdircolors

# export TERMINALAPP="/Applications/Alacritty.app"
export TERMINALAPP="/Applications/WezTerm.app"
# export BROWSER="/Applications/Brave\ Browser.app/Contents/MacOS/Brave\ Browser"
export BROWSER="/Applications/Chromium.app/Contents/MacOS/Chromium"

eval "$(brew shellenv)"

export FZF_COMP_DIR="$HOMEBREW_PREFIX/opt/fzf"
export ZSH_HIGHLIGHT_DIR="$HOMEBREW_PREFIX/opt/zsh-fast-syntax-highlighting/share"

alias beep="afplay /System/Library/Sounds/Glass.aiff"
