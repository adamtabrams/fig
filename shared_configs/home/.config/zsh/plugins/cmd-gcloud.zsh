export BIGTABLE_EMULATOR_HOST=localhost:9035

# gcloudPathFile="/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
gcloudPathFile="/usr/local/share/google-cloud-sdk/path.zsh.inc"
[ -f $gcloudPathFile ] && source $gcloudPathFile

# TODO: disabled for testing
# gcloudCompFile="/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"
# gcloudCompFile="/usr/local/share/google-cloud-sdk/completion.zsh.inc"
# [ -f $gcloudCompFile ] && source $gcloudCompFile

ls-gcloud-projects() {
    proj=$(gcloud projects list | tail -n +2 | fzf | cut -d ' ' -f 1)
    [ ! "$proj" ] && return
    gcloud config set project "$proj"
    echo "project set to: $(gcloud config get project)"
}
