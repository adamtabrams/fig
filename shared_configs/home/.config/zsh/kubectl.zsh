source <(kubectl completion zsh)

swap-kubectl-context() {
    ctx=$(kubectl config get-contexts | tail -n +2 | fzf | sed -E 's|^[* ]*([^ ]*).*|\1|')
    [ ! "$ctx" ] && return
    kubectl config use-context "$ctx"
}
