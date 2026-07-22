source <(kubectl completion zsh)

# change context kubectl
cck() {
    ctx=$(kubectl config get-contexts | tr -s ' ' '\t' | cut -f1,2 | tail +2 | fzf | cut -f2)
    [ ! "$ctx" ] && return
    kubectl config use-context "$ctx"
}
