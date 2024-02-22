#!/bin/zsh

#### Flatnvim ####################################
export EDITOR="$HOME/repos/flatnvim/bin/flatnvim"
export FLATNVIM_EDITOR="nvim"
export FLATNVIM_LOGFILE="$HOME/repos/flatnvim/log.txt"

#### General #####################################
export SELECTOR="fzf"
export TERMINAL="alacritty"

export LANG="en_US.UTF-8"
export SHELL="zsh"
# export SHELL="/usr/local/bin/zsh"
export OPENER="$EDITOR"
export VISUAL="$EDITOR"
export PAGER="bat"
export GIT_PAGER="delta"
export GIT_EDITOR="$EDITOR"
export MANPAGER="col -bx | $PAGER --language=man"

#### Files/Dirs ##################################
# export MYHIST="$HOME/.local/history/histfile"
export LESSHISTFILE="-"
export CALDIR="$HOME/temp/cal"

#### Path ########################################
export PATH="$XDG_DATA_HOME/nvim/mason/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

#### Bat #########################################
export BAT_PAGER="less -R"
export BAT_CONFIG_PATH="$XDG_CONFIG_HOME/bat/bat.conf"

#### Appearance ##################################
export CLICOLOR=1
export GREP_OPTIONS="--color=auto"
