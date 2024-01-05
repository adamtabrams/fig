#### General #####################################
# eval $(gdircolors $ZDOTDIR/dircolors.ansi-dark)
export KEYTIMEOUT=1
setopt autocd notify interactivecomments

#### Prompt ######################################
autoload -Uz promptinit
promptinit
PROMPT='%F{blue}>%f '
RPROMPT='%F{yellow}%3~%f'

#### Completion ##################################
zstyle ':completion:*' menu select
zstyle ':completion:*' completer _expand _complete _ignored
zstyle ':completion:*' matcher-list 'm:{a-z\-}={A-Z\_}'
zstyle ':completion:*' substitute no
zstyle ':completion:*' glob no
zmodload zsh/complist
autoload -Uz compinit
compinit
# Include hidden files.
_comp_options+=(globdots)

#### History #####################################
HISTFILE="$MYHIST"
HISTSIZE=SAVEHIST=10000000
setopt appendhistory extendedhistory incappendhistory
setopt histfindnodups sharehistory histignorespace

#### History searching ###########################
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

#### Dirstack ####################################
DIRSTACKSIZE=16
DIRSTACKFILE="$XDG_CACHE_HOME/zsh/dirs"
[ ! -f "$DIRSTACKFILE" ] &&
    mkdir -p "$(dirname "$DIRSTACKFILE")" && touch "$DIRSTACKFILE"

if [[ -f $DIRSTACKFILE ]] && [[ $#dirstack -eq 0 ]]; then
    dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
    [[ -d $dirstack[1] ]] && cd $dirstack[1]
fi

chpwd() {
    print -l $PWD ${(u)dirstack} >$DIRSTACKFILE
}

setopt AUTO_PUSHD PUSHD_SILENT PUSHD_TO_HOME
setopt PUSHD_IGNORE_DUPS PUSHD_MINUS

#### Vim #########################################
# j/k history search
bindkey -M vicmd "k" up-line-or-beginning-search
bindkey -M vicmd "j" down-line-or-beginning-search

# edit command in vim
autoload edit-command-line; zle -N edit-command-line
bindkey -M vicmd 'v' edit-command-line

# tab complete menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# cursor shape for diff modes
function zle-keymap-select {
    [ $KEYMAP = vicmd ] || [ $1 = block ] &&
        echo -ne '\e[1 q'

    [ $KEYMAP = main ] || [ $KEYMAP = viins ] || [ $KEYMAP = "" ] || [ $1 = beam ] &&
        echo -ne '\e[5 q'
}
zle -N zle-keymap-select

#init `vi insert` keymap (is removed if `bindkey -V` has been set elsewhere)
zle-line-init() {
    zle -K viins
    echo -ne "\e[5 q"
}
zle -N zle-line-init

# Use beam shape cursor on startup.
echo -ne '\e[5 q'

# Use beam shape cursor for each new prompt.
preexec() { echo -ne '\e[5 q' ;}

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
autoload -Uz surround
zle -N delete-surround surround
zle -N add-surround surround
zle -N change-surround surround
# bindkey -a cs change-surround
# bindkey -a ds delete-surround
# bindkey -a ys add-surround
# bindkey -M visual S add-surround

#### OS Extras ###################################
[ $(uname) = Darwin ] && [ -f "$ZDOTDIR/mac.zsh" ] && source "$ZDOTDIR/mac.zsh"
[ $(uname) = Linux ] && [ -f "$ZDOTDIR/linux.zsh" ] && source "$ZDOTDIR/linux.zsh"

#### Plugins #####################################
[ -f "$ZDOTDIR/fzf.zsh" ] && source "$ZDOTDIR/fzf.zsh"
[ -f "$ZDOTDIR/alias.zsh" ] && source "$ZDOTDIR/alias.zsh"
[ -f "$ZDOTDIR/docker.zsh" ] && source "$ZDOTDIR/docker.zsh"
[ -f "$ZDOTDIR/rust.zsh" ] && source "$ZDOTDIR/rust.zsh"
[ -f "$ZDOTDIR/go.zsh" ] && source "$ZDOTDIR/go.zsh"
[ -f "$ZDOTDIR/gcloud.zsh" ] && source "$ZDOTDIR/gcloud.zsh"
[ -f "$ZDOTDIR/kubectl.zsh" ] && source "$ZDOTDIR/kubectl.zsh"
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
history_backup
