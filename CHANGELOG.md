# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.8.0] - 2020-12-13
### Added
- Switch `ytop` to `bottom` and add `curlie`.

### Fixed
- Update vimium config.
- Add private git service to lazygit config.
- Pretty big updates to zsh config!
- Various nvim config fixes and some configs in testings.
- Add shift modifier for clicking alacritty links.

## [0.7.6] - 2020-10-28
### Fixed
- Small changes for delta, aliases, lazygit.
- Update alacritty config for new version.
- Update lf configs for new version.

## [0.7.5] - 2020-06-12
### Fixed
- Fixed Vim hiding style characters in markdown files.
- Improved highlighting in Vim for matched parentheses.
- Made Vim Alignment function more robust.
- Improved FZF and Easy-Motion bindings in Vim.

### Added
- Add :Essayon and :Essayoff commands to Vim.
- Add write-good package for linting prose.
- Add private to go config.

## [0.7.4] - 2020-06-11
### Fixed
- Continued making tweaks to install script.

## [0.7.3] - 2020-06-10
### Fixed
- Install packages script.
- Add error for possible linking issue.

## [0.7.2] - 2020-06-10
### Fixed
- Removed vimwiki in favor of using the `ideas` tool.

## [0.7.1] - 2020-06-09
### Fixed
- Cleaned up vimrc.
- Fixed Amethyst bindings.

## [0.7.0] - 2020-06-06
### Added
- Replace htop with ytop. You'll have to install ytop. It's been given the alias `top`.

### Fixed
- Combine install package scripts into one.
- Lf config got out of sync.
- Fine tune ChangeReplace for nvim.

## [0.6.1] - 2020-06-05
### Fixed
- Add script to extras for creating alacritty terminfo.
- mksh function opens file in editor.
- Remove marks error with ChangeReplace in nvim.

## [0.6.0] - 2020-06-05
### Added
- Plugin "easy-motion" to nvim.

### Fixed
- Improve bat and lf settings.
- Improve functions and bindings for nvim.
- Improve bindings for amethyst.

### Changed
- Fix README typo.
- Add a changelog to the project.

## [0.5.0] - 2020-05-27
### Added
- Created way more fzf functions in zsh.

## [0.4.3] - 2020-05-27
### Fixed
- Generalized simple bindings for keyboard config.
- More notes in keyboard section of README.

## [0.4.2] - 2020-05-27
### Changed
- Tiny improvement to ip function for zsh.

## [0.4.1] - 2020-05-27
### Fixed
- Use EDITOR when possible.

### Added
- Write a README for the project.
- Added some pictures & links.

## [0.4.0] - 2020-05-26
### Added
- Separate rust & go configs for zsh so they can easily be sourced or not.

## [0.3.3] - 2020-05-26
### Fixed
- When linking, create parent directories if they don't exist.
- Backup history script now handles case where history file doesn't exist.

## [0.3.2] - 2020-05-26
### Fixed
- Improve existing zsh functions.

## [0.3.1] - 2020-05-26
### Fixed
- Cleaned up and organized  zsh files.

## [0.3.0] - 2020-05-26
### Added
- Simplified config for amethyst for more overlap with dwm.

## [0.2.0] - 2020-05-26
### Added
- Put my config files in the repo.

## [0.1.1] - 2020-05-26
### Fixed
- `ln` shouldn't follow symlinks when overwitting them.

## [0.1.0] - 2020-05-25
### Added
- Created basic script for proof of concept.

[Unreleased]: https://github.com/adamtabrams/fig/compare/0.8.0...HEAD
[0.8.0]: https://github.com/adamtabrams/fig/compare/0.7.6...0.8.0
[0.7.6]: https://github.com/adamtabrams/fig/compare/0.7.5...0.7.6
[0.7.5]: https://github.com/adamtabrams/fig/compare/0.7.4...0.7.5
[0.7.4]: https://github.com/adamtabrams/fig/compare/0.7.3...0.7.4
[0.7.3]: https://github.com/adamtabrams/fig/compare/0.7.2...0.7.3
[0.7.2]: https://github.com/adamtabrams/fig/compare/0.7.1...0.7.2
[0.7.1]: https://github.com/adamtabrams/fig/compare/0.7.0...0.7.1
[0.7.0]: https://github.com/adamtabrams/fig/compare/0.6.1...0.7.0
[0.6.1]: https://github.com/adamtabrams/fig/compare/0.6.0...0.6.1
[0.6.0]: https://github.com/adamtabrams/fig/compare/0.5.0...0.6.0
[0.5.0]: https://github.com/adamtabrams/fig/compare/0.4.3...0.5.0
[0.4.3]: https://github.com/adamtabrams/fig/compare/0.4.2...0.4.3
[0.4.2]: https://github.com/adamtabrams/fig/compare/0.4.1...0.4.2
[0.4.1]: https://github.com/adamtabrams/fig/compare/0.4.0...0.4.1
[0.4.0]: https://github.com/adamtabrams/fig/compare/0.3.3...0.4.0
[0.3.3]: https://github.com/adamtabrams/fig/compare/0.3.2...0.3.3
[0.3.2]: https://github.com/adamtabrams/fig/compare/0.3.1...0.3.2
[0.3.1]: https://github.com/adamtabrams/fig/compare/0.3.0...0.3.1
[0.3.0]: https://github.com/adamtabrams/fig/compare/0.2.0...0.3.0
[0.2.0]: https://github.com/adamtabrams/fig/compare/0.1.1...0.2.0
[0.1.1]: https://github.com/adamtabrams/fig/compare/0.1.0...0.1.1
[0.1.0]: https://github.com/adamtabrams/fig/releases/tag/0.1.0
