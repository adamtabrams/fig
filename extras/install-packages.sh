#!/bin/sh

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
clementtsang/bottom/bottom
coreutils
sc-im
tree
tokei
watch
lazydocker
k9s
docker-completion
kubernetes-cli
kubernetes-helm
rs/tap/curlie
golangci/tap/golangci-lint
shellcheck"

echo "$progs_list" | xargs brew install


# Generate list of installed progs: brew list --cask
cask_list="\
amethyst
alacritty
brave-browser
caffeine
homebrew/cask-fonts/font-fira-code-nerd-font
karabiner-elements"

echo "$cask_list" | xargs brew install
