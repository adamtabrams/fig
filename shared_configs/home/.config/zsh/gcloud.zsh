export BIGTABLE_EMULATOR_HOST=localhost:9035

gcloudPathFile="/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
[ -f $gcloudPathFile ] && source $gcloudPathFile

gcloadCompFile="/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"
[ -f $gcloadCompFile ] && source $gcloadCompFile
