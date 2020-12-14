#!/bin/sh

# Generate list of installed progs: brew cask list
taps_list="\
homebrew/cask-fonts
clementtsang/bottom"

cask_list="\
amethyst
alacritty
brave-browser
font-fira-code-nerd-font
karabiner-elements"

# Generate list of installed progs: brew leaves
progs_list="\
neovim
zsh
zsh-syntax-highlighting
pacapt
lazygit
git-delta
hub
bat
fzf
ripgrep
fd
lf
jq
yq
bottom
coreutils
sc-im
tree
tokei
watch
lazydocker
docker-completion
kubernetes-cli
kubernetes-helm
rs/tap/curlie
golangci/tap/golangci-lint
write-good
shellcheck"

echo "$taps_list" | xargs -n 1 brew tap

echo "$cask_list" | xargs brew cask install

echo "$progs_list" | xargs brew install
