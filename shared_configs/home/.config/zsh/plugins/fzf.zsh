# Setup fzf
# ---------
export PATH="$FZF_COMP_DIR/bin:$PATH"

# Key bindings
# ------------
bindkey '^G' fzf-cd-widget
bindkey '^F' fzf-file-widget
bindkey '^R' fzf-history-widget

# Default commands
# ---------------
fzf_base_command="fd --hidden --exclude .git --follow --strip-cwd-prefix"
export FZF_DEFAULT_COMMAND="$fzf_base_command --type file"
export FZF_DEFAULT_OPTS="--preview='bat {} 2>/dev/null'"
# export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --reverse --select-1"
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --reverse"
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --preview-window='70%:wrap:hidden'"
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --bind=ctrl-u:preview-half-page-up"
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --bind=ctrl-d:preview-half-page-down"
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --bind=ctrl-a:jump"
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --bind=ctrl-l:jump"
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --bind=ctrl-t:toggle-preview"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$fzf_base_command --type directory --type symlink"

# export FZF_CTRL_T_OPTS="--scheme path"
# export FZF_ALT_C_OPTS="--scheme path"
# export FZF_CTRL_R_OPTS="--scheme history"

# FZF_COMPLETION_TRIGGER   (default: '**')
# export FZF_COMPLETION_TRIGGER=''
# FZF_COMPLETION_OPTS      (default: empty)
# FZF_COMPLETION_PATH_OPTS (default: empty)
# FZF_COMPLETION_DIR_OPTS  (default: empty)

source <(fzf --zsh)
