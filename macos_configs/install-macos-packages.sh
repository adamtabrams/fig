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
docker
lazydocker
k9s
kubernetes-cli
dust
rm-improved"

echo "$progs_list" | xargs brew install

# Generate list of installed progs: brew list --cask
cask_list="\
homebrew/cask/alacritty
homebrew/cask/amethyst
homebrew/cask/brave-browser
homebrew/cask/caffeine
homebrew/cask/docker
homebrew/cask-fonts/font-fira-code-nerd-font"

echo "$cask_list" | xargs brew install
