#!/bin/sh

# Generate list of installed progs: brew cask list
taps_list=" \
homebrew/cask-fonts
cjbassi/ytop"

progs_list=" \
amethyst
alacritty
brave-browser
font-firacode-nerd-font
karabiner-elements"

echo "$taps_list" | xargs brew tap

echo "$progs_list" | xargs brew cask install


# Generate list of installed progs: brew leaves
progs_list=" \
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
ytop
coreutils
sc-im
tree
tokei
watch
lazydocker
docker-completion
kubernetes-cli
kubernetes-helm
golangci/tap/golangci-lint
shellcheck"

echo "$progs_list" | xargs brew install
