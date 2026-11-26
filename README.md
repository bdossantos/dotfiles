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

`make install` installs mise if missing, links `~/.config/mise`, installs
Homebrew on Apple Silicon if missing, and runs `mise bootstrap`, which applies
packages, directories, Git repositories (Vundle), dotfiles, macOS defaults
(restarting Dock/Finder/SystemUIServer via `post-defaults`), the login shell,
mise tools and the `bootstrap` finish task (see `.config/mise/conf.d/`).
Preview everything first with `make bootstrap-dry-run` (or
`mise bootstrap --dry-run`).

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

Safari and Mail are sandboxed apps: open each of them once, and give your
terminal Full Disk Access (System Settings → Privacy & Security), before
applying, otherwise their preferences cannot be written.

### Install Homebrew formulae, apps and tools

Everything formerly installed by the `.brew` script is declared in mise:

- command-line tools with a mise equivalent (ripgrep, fzf, jq, bat, eza,
  shellcheck, shfmt, awscli, ...) in `.config/mise/conf.d/tools.toml`, installed
  without Homebrew or `sudo`
- Homebrew formulae (`brew:`), casks and fonts (`brew-cask:`) in
  `.config/mise/conf.d/packages.toml`

Install mise first (`make install-mise`, or see the
[mise documentation](https://mise.jdx.dev/getting-started.html)), then run
`make install` (or apply only packages and tools):

```bash
make install-homebrew             # brew itself, in /opt/homebrew
make install-packages
# or
mise bootstrap packages apply --dry-run
mise bootstrap packages apply
mise install --locked
mise bootstrap packages upgrade   # replaces `brew upgrade`
```

mise's `brew` manager does not need Homebrew, but Homebrew provides the `brew`
command (used by `brew shellenv` in `.config/bash/tools.bash`). `make
install-homebrew` verifies a pinned Homebrew source archive before extracting
it into `/opt/homebrew` on Apple Silicon. If the prefix is missing, it creates
it with `sudo` and assigns ownership to the current user. An existing prefix
must already be writable. Use `mise bootstrap packages upgrade` rather than
`brew upgrade` for packages managed by mise.

`/opt/homebrew/bin` is added to `PATH` in `.profile`. `brew` formulae are only
available on Apple Silicon (and Linux), casks also work on Intel.

Casks that must be installed system-wide by the admin user are in
`.config/mise/system-casks.toml`:

```bash
su admin -c "MISE_GLOBAL_CONFIG_FILE=$HOME/.dotfiles/.config/mise/system-casks.toml \
  mise bootstrap packages apply --manager brew-cask"
```

### Supply-chain safeguards

The global mise config sets `minimum_release_age = "7d"` and requires
locked tools declared in that config. `make install` also requires locked
entries during bootstrap. The seven-day delay applies when mise resolves
versions with release dates; undated releases, exact versions and existing lock
entries are not held back. Existing locked versions were not retroactively
checked against this policy. npm and PyPI can also apply the cutoff to newly
resolved dependencies, but other installers may resolve dependencies
independently.

`.config/mise/mise.lock` records tool versions and available platform
checksums; `.config/mise/locks/` contains the npm and PyPI dependency graphs.
Keep both in Git and review changes before installing. The lock currently
covers Linux x64 and macOS arm64; other platforms need reviewed lock entries.
Checksums detect changes to recorded artifacts, but do not prove the original
release is trustworthy. Already installed tools are not reverified.

To update tools deliberately, preview and review upstream changes first:

```bash
mise lock --global --bump --dry-run
mise lock --global --bump
git diff -- .config/mise/mise.lock .config/mise/locks/
mise install --locked
```

Commit the reviewed lockfile and dependency graph changes together. The
bootstrap pins the [mise 2026.11.8 release archives][mise-release] and the
[Homebrew 7.0.13 source commit][brew-release], checking their recorded SHA-256
values before installation. The mise hashes come from the release assets.
Existing executables are not reverified or replaced. Update pins and hashes
together after reviewing releases and checking upstream verification
information; the Homebrew source hash was calculated from the downloaded
archive, not an upstream signature.

[mise-release]: https://github.com/jdx/mise/releases/tag/v2026.11.8
[brew-release]: https://github.com/Homebrew/brew/releases/tag/7.0.13

The release-age setting and tool lock do **not** cover `brew:` formulae,
`brew-cask:` apps, their dependencies, Homebrew itself, or self-updating apps.
Vundle and the Vim plugins installed by the bootstrap task are also unpinned.
mise fetches current Homebrew metadata, verifies bottles and checks casks when
their metadata has a checksum. A versioned formula such as `openssl@4` selects
a major line, not an exact build. Review package changes before running apply
or upgrade; even a fresh install selects current versions. Where a vendor
provides a stable versioned app archive and checksum, a reviewed `macos-app:`
entry can pin that app, but it does not support every cask or prevent the app
from updating itself. Keep security-sensitive apps patched.

## Bash

### Set Bash as default shell

`mise bootstrap` sets your login shell to Homebrew's Bash via
`[bootstrap.user]` in `.config/mise/conf.d/bootstrap.toml`. To run only that
step (or do it manually):

```bash
mise bootstrap user apply
# or manually:
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
| `tools.bash` | brew env, mise, zoxide, direnv, gcloud SDK, fzf, nomad |
| `prompt.bash` | Ghostty shell integration + starship prompt (sets `PROMPT_COMMAND`) |
| `history.bash` | Prepends `history -a` to `PROMPT_COMMAND` (must run last among PROMPT_COMMAND setters) |
| `completions.bash` | System-wide and Homebrew tab completions |
| `ssh_agent.bash` | Auto-start / attach SSH agent and add keys |

**Required tools:** `bash` ≥ 4 (install via `brew install bash`)

**Optional tools** (gracefully skipped when absent): `mise`, `starship`, `zoxide`,
`direnv`, `fzf`, `gcloud` (via Homebrew), `nomad`, `zellij`

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
