# ~/.dotfiles

[![CI](https://github.com/bdossantos/dotfiles/actions/workflows/ci.yml/badge.svg)](https://github.com/bdossantos/dotfiles/actions/workflows/ci.yml)
[![License: WTFPL](https://img.shields.io/badge/License-WTFPL-brightgreen.svg)](LICENCE)

Personal dotfiles for macOS, managed with [mise](https://mise.jdx.dev)
(`mise dot`, `mise bootstrap`).

## What's included

| File / directory    | Description                                      |
| ------------------- | ------------------------------------------------ |
| `.config/ghostty/`  | [Ghostty](https://ghostty.org) terminal with Dracula colour scheme |
| `.config/nvim/`     | Neovim config with [lazy.nvim](https://github.com/folke/lazy.nvim) plugin manager and a pinned `lazy-lock.json` lockfile |
| `.aliases`          | Handy shell aliases                              |
| `.bash_profile` / `.bashrc` / `.profile` | Bash startup files     |
| `.config/mise/`     | [mise](https://mise.jdx.dev) tools, dotfiles, macOS defaults and casks |
| `.gitconfig`        | Git settings (diff-so-fancy, GPG signing, …)     |
| `.gitmessage`       | Conventional Commits message template            |
| `.gnupg/`           | GPG configuration                                |
| `.macos`            | Sensible macOS defaults that need `sudo`        |
| `.macos_hardening`  | Security-focused macOS hardening settings        |
| `.ssh/`             | SSH client configuration                         |
| `.config/zellij/`   | [Zellij](https://zellij.dev) terminal multiplexer with Dracula theme |
| `.vimrc`            | Vim with Vundle plugins (fzf, ALE, airline, …)   |
| `bin/`              | Utility scripts                                  |

## Prerequisites

- **git**
- **[mise](https://mise.jdx.dev)** with `mise dot` and `mise bootstrap`
  support — `brew install mise` or <https://mise.jdx.dev/getting-started.html>

## Installation

```bash
git clone https://github.com/bdossantos/dotfiles ~/.dotfiles
cd ~/.dotfiles
make install
```

`make install` links `~/.config/mise`, then runs `mise dot apply`, which
symlinks every file tracked by Git into `$HOME` (see
`.config/mise/conf.d/dotfiles.toml`).

### Migrating from GNU Stow

Remove the old Stow symlinks first, then install again:

```bash
cd ~/.dotfiles
make migrate-from-stow
make install
```

## Uninstallation

```bash
cd ~/.dotfiles
make uninstall
```

## macOS setup

### Sensible macOS defaults

User-level preferences are declared in
`.config/mise/conf.d/macos.toml`:

```bash
mise bootstrap macos defaults apply --dry-run
mise bootstrap macos defaults apply
```

mise never uses `sudo`, so everything that needs it (`pmset`, `systemsetup`,
system-wide `defaults`, hardening, …) stays in the scripts below. Run them
as the admin user:

```bash
su - admin -c "env PATH=$PATH:/usr/sbin/ bash -x $HOME/.dotfiles/.macos"
su - admin -c "env PATH=$PATH:/usr/sbin/ bash -x $HOME/.dotfiles/.macos_hardening"
```

### Install Homebrew formulae, apps and tools

Everything formerly installed by the `.brew` script is declared in mise:

- command-line tools with a mise equivalent (ripgrep, fzf, jq, bat, eza,
  shellcheck, shfmt, awscli, ...) in `.config/mise/conf.d/tools.toml`, installed
  without Homebrew or `sudo`
- Homebrew formulae (`brew:`), casks and fonts (`brew-cask:`) in
  `.config/mise/conf.d/packages.toml`

Install mise first (`make install-mise`, or see the
[mise documentation](https://mise.jdx.dev/getting-started.html)), then
`make install` runs `make install-homebrew install-packages` on macOS:

```bash
make install-homebrew             # brew itself, in /opt/homebrew
make install-packages
# or
mise bootstrap packages apply --dry-run
mise bootstrap packages apply
mise install
mise bootstrap packages upgrade   # replaces `brew upgrade`
```

mise's `brew` manager does not need Homebrew, but Homebrew provides the `brew`
command (used by `brew shellenv` in `.config/bash/tools.bash`). `make
install-homebrew` extracts Homebrew into the standard prefix (`/opt/homebrew`,
Apple Silicon only) when `brew` is missing, creating the prefix with `sudo`
once so the daily user stays unprivileged. Homebrew then sees what mise
installs. Use `mise bootstrap packages upgrade` rather than `brew upgrade`, to
avoid the two tools fighting over versions.

`/opt/homebrew/bin` is added to `PATH` in `.profile`. `brew` formulae are only
available on Apple Silicon (and Linux), casks also work on Intel.

Casks that must be installed system-wide by the admin user are in
`.config/mise/system-casks.toml`:

```bash
su admin -c "MISE_GLOBAL_CONFIG_FILE=$HOME/.dotfiles/.config/mise/system-casks.toml \
  mise bootstrap packages apply --manager brew-cask"
```

## Bash

### Set Bash as default shell

```bash
chsh -s "$(brew --prefix)/bin/bash"
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

### Bash modules

`~/.bashrc` is kept intentionally thin — it sources six focused modules from
`~/.config/bash/` in a defined order:

| Module | Purpose |
| --- | --- |
| `options.bash` | `shopt` flags and `set -o vi` |
| `prompt.bash` | Ghostty shell integration + starship prompt (sets `PROMPT_COMMAND`) |
| `tools.bash` | brew env, chruby, zoxide, direnv, gcloud SDK, fzf, nomad |
| `history.bash` | Prepends `history -a` to `PROMPT_COMMAND` (must run last among PROMPT_COMMAND setters) |
| `completions.bash` | System-wide and Homebrew tab completions |
| `ssh_agent.bash` | Auto-start / attach SSH agent and add keys |

**Required tools:** `bash` ≥ 4 (install via `brew install bash`)

**Optional tools** (gracefully skipped when absent): `starship`, `zoxide`,
`direnv`, `fzf`, `chruby`, `gcloud` (via Homebrew), `nomad`, `zellij`

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
