export BIGTABLE_EMULATOR_HOST=localhost:9035

# gcloudPathFile="/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
gcloudPathFile="/usr/local/share/google-cloud-sdk/path.zsh.inc"
[ -f $gcloudPathFile ] && source $gcloudPathFile

# TODO: disabled for testing
# gcloudCompFile="/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"
# gcloudCompFile="/usr/local/share/google-cloud-sdk/completion.zsh.inc"
# [ -f $gcloudCompFile ] && source $gcloudCompFile

ctxgcloud() {
    ctx=$(gcloud projects list | tr -s ' ' '\t' | cut -f1,2 | tail +2 | fzf | cut -f1)
    [ ! "$ctx" ] && return
    gcloud config set project "$ctx"
    echo "project set to: $(gcloud config get project)"
}
