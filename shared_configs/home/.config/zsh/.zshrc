# for profiling
# zmodload zsh/zprof

#### General #####################################
export KEYTIMEOUT=1
stty stop undef # Disable ctrl-s to freeze terminal
setopt autocd # Automatically cd into typed directory
setopt interactivecomments
setopt notify
zle_highlight+=(paste:none)

#### Prompt ######################################
autoload -U promptinit
promptinit
# PROMPT='%F{blue}>%f '
PROMPT='%F{blue}|>%f '
RPROMPT='%F{yellow}%3~%f'

#### Completion ##################################
autoload -U compinit
# autoload -Uz +X compinit
zstyle ':completion:*' matcher-list 'm:{a-z\-}={A-Z\_}'
zstyle ':completion:*' menu select
zmodload zsh/complist
# compinit

for file in $ZDOTDIR/.zcompdump(N.mh+24); do
  compinit && touch "$file"
done
compinit -C

_comp_options+=(globdots) # Include hidden files

#### History #####################################
HISTFILE="$HOME/.local/history/histfile"
HISTSIZE=10000000
SAVEHIST=10000000

setopt appendhistory
setopt extendedhistory
setopt incappendhistory
setopt histfindnodups
setopt sharehistory
setopt histignorespace

zmodload -F zsh/stat b:zstat

#### History searching ###########################
autoload -U up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

#### Dirstack ####################################
DIRSTACKSIZE=25
DIRSTACKFILE="$ZDOTDIR/.zdirstack"

if [[ -f $DIRSTACKFILE ]] && [[ $#dirstack -eq 0 ]]; then
    dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
    [[ $PWD = $HOME ]] && [[ -d $dirstack[1] ]] && cd $dirstack[1]
    # [[ -d $dirstack[1] ]] && cd $dirstack[1]
fi

chpwd() {
    print -l $PWD ${(u)dirstack} >$DIRSTACKFILE
}

setopt AUTO_PUSHD
setopt PUSHD_SILENT
setopt PUSHD_TO_HOME
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_MINUS

#### Vim #########################################
# j/k history search
bindkey -M vicmd "k" up-line-or-beginning-search
bindkey -M vicmd "j" down-line-or-beginning-search

# edit command in vim
autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd 'v' edit-command-line

# tab complete menu
# setopt menu_complete
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char
# bindkey -v 'ESC' backward-delete-char

# cursor shape for diff modes
function zle-keymap-select() {
	case $KEYMAP in
    vicmd) echo -ne '\e[1 q' ;; # block
    viins | main) echo -ne '\e[5 q' ;; # beam
	esac
}
zle -N zle-keymap-select

zle-line-init() {
    zle -K viins # Init `vi insert` as keymap (removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init

echo -ne '\e[5 q' # Use beam shape cursor on startup
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt

# surround
autoload -U select-quoted
zle -N select-quoted
for m in visual viopp; do
  for c in {a,i}{\',\",\`}; do
    bindkey -M $m $c select-quoted
  done
done

autoload -U select-bracketed
zle -N select-bracketed
for m in visual viopp; do
  for c in {a,i}${(s..)^:-'()[]{}<>'}; do
    bindkey -M $m $c select-bracketed
  done
done

# surround bindings
# autoload -U surround
# zle -N delete-surround surround
# zle -N add-surround surround
# zle -N change-surround surround
# bindkey -a cs change-surround
# bindkey -a ds delete-surround
# bindkey -a ys add-surround
# bindkey -M visual S add-surround

#### OS Specific #################################
case $OSTYPE in
  linux-gnu*) source "$ZDOTDIR/os/linux.zsh" ;;
  darwin*) source "$ZDOTDIR/os/mac.zsh" ;;
esac

#### Sources #####################################
source "$ZDOTDIR/alias.zsh"

for file in $ZDOTDIR/plugins/*.zsh; do
  source "$file"
done

#### Colors ######################################
which dircolors &>/dev/null &&
    eval $(dircolors "$ZDOTDIR/colors/dircolors.ansi-dark") ||
    echo "need 'dircolors' program to set terminal colors" >&2

# source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# see bug: https://github.com/zdharma-continuum/fast-syntax-highlighting/issues/27
source "$ZSH_HIGHLIGHT_DIR/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
export FAST_HIGHLIGHT[chroma-man]=

# for profiling
# zprof > "$ZDOTDIR/zprof.txt"
