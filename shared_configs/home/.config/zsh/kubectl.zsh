source <(kubectl completion zsh)

ls-kubectl-contexts() {
    ctx=$(kubectl config get-contexts | tail -n +2 | fzf | sed -E 's|^[* ]*([^ ]*).*|\1|')
    [ ! "$ctx" ] && return
    kubectl config use-context "$ctx"
}
