# Setup fzf
# ---------
export PATH="$FZF_COMP_DIR/bin:$PATH"

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$FZF_COMP_DIR/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "$FZF_COMP_DIR/shell/key-bindings.zsh"

bindkey '^G' fzf-cd-widget
bindkey '^F' fzf-file-widget
bindkey '^R' fzf-history-widget

# Default commands
# ---------------
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
