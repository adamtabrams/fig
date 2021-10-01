#!/bin/sh

# Generate list of installed progs: brew leaves
progs_list="\
bat
calcurse
clementtsang/bottom/bottom
coreutils
dash
fd
fzf
git-delta
gnu-sed
gnupg
grep
hub
jq
lazygit
lf
neovim
pacapt
qmk/qmk/qmk
ripgrep
sc-im
shellcheck
tokei
topgrade
tree
watch
yq
zsh
zsh-syntax-highlighting
go
golangci/tap/golangci-lint
delve
docker-completion
lazydocker
k9s
kubernetes-cli
dust
rm-improved
prm/pep/techctl
sops
awscli
cassandra"

echo "$progs_list" | xargs brew install

# Generate list of installed progs: brew list --cask
cask_list="\
amethyst
alacritty
brave-browser
caffeine
font-fira-code-nerd-font
google-cloud-sdk"
# homebrew/cask-fonts/font-fira-code-nerd-font

echo "$cask_list" | xargs brew install
