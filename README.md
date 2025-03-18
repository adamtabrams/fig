## About

Fig is a simple way to track, backup, and share system configurations.
This repo currently has some of my own configs.

The `home` directory represents your system's `$HOME` dir.

The `link-figs.sh` script creates symlinks at the represented paths which point back to configs in `home`.

This way, changes to configs are tracked by git. And configs can be quickly setup on any system.


## Usage

The file `home/.fig` is used to create links to files.

```
all    .bashrc
linux  .scimrc
darwin .hushlogin
```
The example above would create these links:
  - `$HOME/.bashrc -> home/.bashrc` on all platforms
  - `$HOME/.scimrc -> home/.scimrc` only on linux
  - `$HOME/.hushlogin -> home/.hushlogin` only on macos


Other `.fig` files are used to create should be linked to dirs.

```
all
```
Placed at `home/.config/lf`, the example above would create this link:
  - `$HOME/.config/lf -> home/.config/lf` on all platforms


## Tips

If you plan to use this repo, you should fork it.
That way you can easily make your own changes on top.

I recommend simplifying your home directory. I use these:
  - repo - for keeping git repos (~/repo/OWNER/REPO)
  - save - for anything worth saving (documents, media, etc)
  - temp - for scratch files, downloads, and anything not needed after a few months
