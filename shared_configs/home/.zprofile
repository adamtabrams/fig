#!/bin/zsh

#### Flatnvim ####################################
export EDITOR="$HOME/repos/flatnvim/bin/flatnvim"
export FLATNVIM_EDITOR="nvim"
export FLATNVIM_EXTRA_COMMAND="if exists(':AirlineRefresh') == 2 | AirlineRefresh | endif"

#### General #####################################
# export EDITOR="nvim"
export TERMINAL="alacritty"
export SELECTOR="fzf"

export LANG="en_US.UTF-8"
export SHELL="zsh"
# export SHELL="/usr/local/bin/zsh"
export OPENER="$EDITOR"
export VISUAL="$EDITOR"
export PAGER="bat"
export GIT_PAGER="delta"
export GIT_EDITOR="$EDITOR"
export MANPAGER="col -bx | $PAGER --language=man"

#### XDG #########################################
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

#### Files/Dirs ##################################
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export MYHIST="$HOME/.local/history/histfile"
export LESSHISTFILE="-"
export CALDIR="$HOME/temp/cal"

#### Path ########################################
export PATH="$HOME/.local/bin:$PATH"

#### Bat #########################################
export BAT_PAGER="less -R"
export BAT_CONFIG_PATH="$XDG_CONFIG_HOME/bat/bat.conf"

#### Fzf #########################################
fzf_base_command="fd --hidden --exclude .git --follow"
export FZF_DEFAULT_COMMAND="$fzf_base_command --type file"
export FZF_DEFAULT_OPTS="--preview='bat {} 2> /dev/null'"
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --reverse"
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --preview-window=':hidden'"
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --bind=ctrl-u:page-up"
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --bind=ctrl-d:page-down"
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --bind=ctrl-f:jump"
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --bind=ctrl-p:toggle-preview"

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$fzf_base_command --type directory --type symlink"
export FZF_ALT_C_OPTS="--preview-window=right:0:hidden"
export FZF_CTRL_R_OPTS="--preview-window=right:0:hidden"

#### Appearance ##################################
export CLICOLOR=1
export GREP_OPTIONS="--color=auto"
export LF_ICONS="di=:fi=:ln=:or=:ex=:*.c=:*.cc=:*.clj=:*.coffee=:*.cpp=:*.css=:*.d=:*.dart=:*.erl=:*.exs=:*.fs=:*.go=:*.h=:*.hh=:*.hpp=:*.hs=:*.html=:*.java=:*.jl=:*.js=:*.json=:*.lua=:*.md=:*.php=:*.pl=:*.pro=:*.py=:*.rb=:*.rs=:*.scala=:*.ts=:*.vim=:*.cmd=:*.ps1=:*.sh=:*.bash=:*.zsh=:*.fish=:*.tar=:*.tgz=:*.arc=:*.arj=:*.taz=:*.lha=:*.lz4=:*.lzh=:*.lzma=:*.tlz=:*.txz=:*.tzo=:*.t7z=:*.zip=:*.z=:*.dz=:*.gz=:*.lrz=:*.lz=:*.lzo=:*.xz=:*.zst=:*.tzst=:*.bz2=:*.bz=:*.tbz=:*.tbz2=:*.tz=:*.deb=:*.rpm=:*.jar=:*.war=:*.ear=:*.sar=:*.rar=:*.alz=:*.ace=:*.zoo=:*.cpio=:*.7z=:*.rz=:*.cab=:*.wim=:*.swm=:*.dwm=:*.esd=:*.jpg=:*.jpeg=:*.mjpg=:*.mjpeg=:*.gif=:*.bmp=:*.pbm=:*.pgm=:*.ppm=:*.tga=:*.xbm=:*.xpm=:*.tif=:*.tiff=:*.png=:*.svg=:*.svgz=:*.mng=:*.pcx=:*.mov=:*.mpg=:*.mpeg=:*.m2v=:*.mkv=:*.webm=:*.ogm=:*.mp4=:*.m4v=:*.mp4v=:*.vob=:*.qt=:*.nuv=:*.wmv=:*.asf=:*.rm=:*.rmvb=:*.flc=:*.avi=:*.fli=:*.flv=:*.gl=:*.dl=:*.xcf=:*.xwd=:*.yuv=:*.cgm=:*.emf=:*.ogv=:*.ogx=:*.aac=:*.au=:*.flac=:*.m4a=:*.mid=:*.midi=:*.mka=:*.mp3=:*.mpc=:*.ogg=:*.ra=:*.wav=:*.oga=:*.opus=:*.spx=:*.xspf=:*.pdf="
