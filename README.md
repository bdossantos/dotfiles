# ~/.dotfiles

[![CI](https://github.com/bdossantos/dotfiles/actions/workflows/ci.yml/badge.svg)](https://github.com/bdossantos/dotfiles/actions/workflows/ci.yml)
[![License: WTFPL](https://img.shields.io/badge/License-WTFPL-brightgreen.svg)](LICENCE)

Personal dotfiles for macOS, managed with
[GNU Stow](https://www.gnu.org/software/stow/).

CLI tools are managed declaratively with [Nix](https://nixos.org/) and
[home-manager](https://nix-community.github.io/home-manager/). GUI / cask
applications are still installed via
[Homebrew](https://brew.sh/).

## What's included

| File / directory    | Description                                      |
| ------------------- | ------------------------------------------------ |
| `.config/ghostty/`  | [Ghostty](https://ghostty.org) terminal with Dracula colour scheme |
| `.aliases`          | Handy shell aliases                              |
| `.bash_profile` / `.bashrc` / `.profile` | Bash startup files     |
| `.brew`             | Homebrew casks (GUI apps only)                   |
| `flake.nix` / `home.nix` | Nix home-manager configuration (CLI tools) |
| `.gitconfig`        | Git settings (diff-so-fancy, GPG signing, …)     |
| `.gitmessage`       | Conventional Commits message template            |
| `.gnupg/`           | GPG configuration                                |
| `.macos`            | Sensible macOS defaults                          |
| `.macos_hardening`  | Security-focused macOS hardening settings        |
| `.ssh/`             | SSH client configuration                         |
| `.tmux.conf`        | tmux with vi-style key bindings                  |
| `.vimrc`            | Vim with Vundle plugins (fzf, ALE, airline, …)   |
| `bin/`              | Utility scripts                                  |

## Prerequisites

- **git**
- **[GNU Stow](https://www.gnu.org/software/stow/)** — `brew install stow`
  (macOS) or `apt install stow` (Debian/Ubuntu)
- **[Nix](https://nixos.org/)** — install with the
  [Determinate Nix Installer](https://zero-to-nix.com/start/install):

  ```bash
  curl --proto '=https' --tlsv1.2 -sSf -L \
    https://install.determinate.systems/nix | sh -s -- install
  ```

## Installation

```bash
git clone https://github.com/bdossantos/dotfiles ~/.dotfiles
cd ~/.dotfiles
make install
```

## Uninstallation

```bash
cd ~/.dotfiles
make uninstall
```

## Package management

### CLI tools (Nix + home-manager)

All command-line tools are declared in `home.nix` and installed via
home-manager. To add or remove a CLI tool, edit `home.nix` and apply:

```bash
make run-nix
```

### GUI / cask applications (Homebrew)

GUI applications, fonts, and other casks are still installed via Homebrew:

```bash
make run-brew
```

## macOS setup

### Sensible macOS defaults

When setting up a new Mac, you may want to apply sensible defaults and
security hardening:

```bash
su - admin -c "env PATH=$PATH:/usr/sbin/ bash -x $HOME/.dotfiles/.macos"
su - admin -c "env PATH=$PATH:/usr/sbin/ bash -x $HOME/.dotfiles/.macos_hardening"
```

## Bash

### Set Bash as default shell

```bash
chsh -s "$(command -v bash)"
exec $SHELL
```

### Choosing between .bashrc, .profile, .bash_profile, etc.

* `~/.bash_profile` should be super-simple and just load `~/.profile` and
  `~/.bashrc` (in that order)
* `~/.profile` has the stuff NOT specifically related to bash, such as
  environment variables (PATH and friends)
* `~/.bashrc` has anything you'd want at an interactive command line. Command
  prompt, EDITOR variable, bash aliases for my use

A few other notes:

* Anything that should be available to graphical applications OR to sh (or bash
  invoked as sh) MUST be in `~/.profile`
* `~/.bashrc` must not output anything
* Anything that should be available only to login shells should go in
  `~/.profile`
* Ensure that `~/.bash_login` does not exist.

See also <https://www.gnu.org/software/bash/manual/html_node/Bash-Startup-Files.html>

## Testing

[pre-commit](https://pre-commit.com) is used for linting (shellcheck, YAML,
trailing whitespace, …). Run the full test suite with:

```bash
make test
```

## Licence

[WTFPL](LICENCE) © Benjamin Dos Santos
