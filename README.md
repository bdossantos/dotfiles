# ~/.dotfiles

[![CI](https://github.com/bdossantos/dotfiles/actions/workflows/ci.yml/badge.svg)](https://github.com/bdossantos/dotfiles/actions/workflows/ci.yml)
[![License: WTFPL](https://img.shields.io/badge/License-WTFPL-brightgreen.svg)](LICENCE)

Personal dotfiles for macOS, managed with
[GNU Stow](https://www.gnu.org/software/stow/).

On macOS, system configuration and packages are managed declaratively with
[nix-darwin](https://github.com/LnL7/nix-darwin) (which includes
[home-manager](https://nix-community.github.io/home-manager/) for user-level
packages and [Homebrew](https://brew.sh/) for GUI / cask applications).

On Linux, [home-manager](https://nix-community.github.io/home-manager/) is
used standalone for CLI tools.

## What's included

| File / directory    | Description                                      |
| ------------------- | ------------------------------------------------ |
| `.config/ghostty/`  | [Ghostty](https://ghostty.org) terminal with Dracula colour scheme |
| `.config/nvim/`     | Neovim config with [lazy.nvim](https://github.com/folke/lazy.nvim) plugin manager and a pinned `lazy-lock.json` lockfile |
| `.aliases`          | Handy shell aliases                              |
| `.bash_profile` / `.bashrc` / `.profile` | Bash startup files     |
| `flake.nix`         | Nix flake (nix-darwin + home-manager)            |
| `darwin.nix`        | macOS system config (Homebrew casks, launchd, …)  |
| `home.nix`          | Home-manager config (CLI tools, shared across OS) |
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

- **[Homebrew](https://brew.sh/)** (macOS only) — nix-darwin manages casks
  through Homebrew, so it must be installed first:

  ```bash
  mkdir -m 0700 -p ~/.homebrew
  curl -L https://github.com/Homebrew/brew/tarball/master \
    | tar xz --strip 1 -C ~/.homebrew
  ```

## Installation

```bash
git clone https://github.com/bdossantos/dotfiles ~/.dotfiles
cd ~/.dotfiles
make install
```

On a fresh macOS where `darwin-rebuild` is not yet available, nix-darwin is
bootstrapped automatically via `nix run nix-darwin -- switch`.

## Uninstallation

```bash
cd ~/.dotfiles
make uninstall
```

## Package management

### macOS (nix-darwin)

A single `darwin-rebuild switch` manages **everything** — CLI tools (via
home-manager), GUI applications (via Homebrew casks), and system settings:

```bash
make run-darwin
```

- **CLI tools** — edit `home.nix`, then `make run-darwin`
- **GUI / cask apps** — edit `darwin.nix` (`homebrew.casks`), then
  `make run-darwin`

### Linux (home-manager)

On Linux, only home-manager is used for CLI tools:

```bash
make run-nix
```

### Ruby versions

Ruby versions are installed via `ruby-install` (managed by Nix):

```bash
make install-rubies
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

## Neovim

### Updating plugins safely

> **Do not blindly run `:Lazy update`.** A supply chain attack relies on
> developers pulling malicious updates without reviewing them first.

Follow these steps instead:

1. **Check for updates without applying them**

   ```
   :Lazy check
   ```

   This fetches the latest commits for every plugin but does **not** install
   anything.

2. **Review the pending changes**

   Open the Lazy UI (`:Lazy`). It lists every commit between your locked
   version and the remote tip. Skim the commit messages for anything
   suspicious before proceeding.

3. **Update deliberately**

   Once you are satisfied that the updates are legitimate, press <kbd>U</kbd>
   inside the Lazy UI to apply them.

4. **Commit the updated lockfile**

   Immediately after updating and confirming Neovim still works, commit
   `lazy-lock.json` so that the pinned versions are recorded:

   ```bash
   git add .config/nvim/lazy-lock.json
   git commit -m "chore(nvim): update lazy-lock.json"
   ```

## Testing

[pre-commit](https://pre-commit.com) is used for linting (shellcheck, YAML,
trailing whitespace, …). Run the full test suite with:

```bash
make test
```

## Licence

[WTFPL](LICENCE) © Benjamin Dos Santos
