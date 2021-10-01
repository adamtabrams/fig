# About

Fig gives you a simple way to track, backup, and share system configurations.
This repo currently has some of my own configs.

# Usage

If you plan to use this repo, it's probably a good idea to fork it. That way you can
easily make your own changes on top of what's here.

The config files are split up into 4 directories:
- shared_configs - for both Linux and macOS
- linux_configs - specific to Linux
- macos_configs - specific to macOS
- other_configs - other helpful files and scripts

Some of the `*_configs` directories have a `home` directory in them.
It represents the `$HOME` directory of you system.
Here's an example:
If I want a file to exist as `~/.config/foo/bar.conf` on my Linux and macOS systems,
then I should put that file in `shared_configs/home/.config/foo/bar.conf`.

The default behavior of the `link_*_configs.sh` scripts is to create links in `$HOME` that point to the
corresponding file in `*_configs/home`. You can also create links that point to a
corresponding directory by adding a file named `.figlink` to that directory.

# Tips
- I highly recommend simplifying your home directory. I primarily use these:
    - repos - where I clone git repos
    - save - for anything worth saving, documents, media, etc
    - temp - for scratch files, downloads, and anything I won't need in a few months

- If after installing you see and error like: `zsh compinit: insecure directories...`,
check [this](https://stackoverflow.com/a/43544733). It explains why you're seeing that
and how to fix it.


<!--
# Highlights
### nvim
        plugins
        functions
        coding maps
        space maps
        term, tabs, bufs, splits
## zsh ✔
        autocomplete
        vi mode
        aliases
### lazygit ✔
        basics
        delta
        x key
### lf ✔
        marks
        H key
        hiddenFiles PR
### amethyst ✔
        bindings
        use workspaces
### karabiner ✔
        layers
### vimiumc ✔
        ? key
        disabling keys
### local/bin ✔
        swaprm
        clipedit
        historybackup
### other ✔
        docs good
### projects
        keys
        sink
        change
-->
