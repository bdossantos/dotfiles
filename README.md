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
  support — installed by `make install-mise`, or see
  <https://mise.jdx.dev/getting-started.html>

No Homebrew, `sudo` or admin rights are needed: everything is installed in
`$HOME` (`~/.local/share/mise`, `~/Applications`, `~/Library/Fonts`).

## Installation

```bash
git clone https://github.com/bdossantos/dotfiles ~/.dotfiles
cd ~/.dotfiles
make install
```

`make install` installs mise if missing, links `~/.config/mise`, and runs
`mise bootstrap`, which applies packages (apps and fonts), directories, Git
repositories (Vundle), dotfiles, macOS defaults (restarting
Dock/Finder/SystemUIServer via `post-defaults`), mise tools and the `bootstrap`
finish task (see `.config/mise/conf.d/`).
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

### Install apps, fonts and tools (no Homebrew, no sudo)

Everything formerly installed by Homebrew is declared in mise:

- command-line tools in `.config/mise/conf.d/tools.toml`: release binaries
  (`aqua`, `npm`, `pypi` backends) and GNU userland from conda-forge
  (`conda:`), all installed in `~/.local/share/mise`
- macOS apps and fonts (`brew-cask:`) in `.config/mise/conf.d/packages.toml`,
  installed in `~/Applications` and `~/Library/Fonts`

Homebrew formulae (`brew:`) are **not** used: mise can only install them in
`/opt/homebrew`, which needs `sudo` to be created. Install mise first
(`make install-mise`), then run `make install` (or apply only packages and
tools):

```bash
make install-packages
# or
mise bootstrap packages apply --dry-run
mise bootstrap packages apply
mise install --locked
mise bootstrap packages upgrade   # upgrade apps and fonts
mise upgrade                      # upgrade tools (review the lock first)
```

`brew-cask:` entries need a prefix where mise records what it installed. The
default, `/opt/homebrew`, needs `sudo`, so `.profile` and the `Makefile` set the
(undocumented) `MISE_SYSTEM_BREW_PREFIX` to `~/.local/share/mise-casks`, and
`MISE_BREW_CASK_OPT_APPDIR` to `~/Applications`. Re-check this when bumping
mise.

Limits of a no-admin setup: casks shipping a `pkg` installer, system
extensions (Little Snitch, VirtualBox, GPG Suite, ...) or refusing to run
outside `/Applications` (1Password) cannot be installed. Install them with an
admin account, or from the vendor.

GNU tools whose commands macOS also provides (`sed`, `awk`, `find`, `xargs`,
`make`) are excluded from the mise shims (`[settings.shims]` in
`.config/mise/config.toml`) and exposed as `gsed`, `gawk`, `gfind`, `gxargs`
and `gmake` in `.aliases`. `gdate` and `gshuf` come from uutils coreutils.


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
bootstrap pins the [mise 2026.11.8 release archives][mise-release], checking
their recorded SHA-256 values before installation. The hashes come from the
release assets. Existing executables are not reverified or replaced. Update the
pin and hashes together after reviewing the release and checking upstream
verification information.

[mise-release]: https://github.com/jdx/mise/releases/tag/v2026.11.8

The release-age setting and tool lock do **not** cover `brew-cask:` apps, their
dependencies, or self-updating apps. conda packages are locked with their URLs
and SHA-256 (`[conda-packages]` in `mise.lock`), but only for the locked
platforms.
Vundle and the Vim plugins installed by the bootstrap task are also unpinned.
mise fetches current Homebrew cask metadata and checks casks when their
metadata has a checksum. Review package changes before running apply or
upgrade; even a fresh install selects current versions. Where a vendor
provides a stable versioned app archive and checksum, a reviewed `macos-app:`
entry can pin that app, but it does not support every cask or prevent the app
from updating itself. Keep security-sensitive apps patched.

## Bash

### Use mise's Bash as default shell

Without admin rights, `chsh` cannot switch to a shell that is not listed in
`/etc/shells`, so the login shell stays `/bin/zsh`. The tracked `.zshrc` hands
over to the Bash installed by mise (`conda:bash`, falling back to `/bin/bash`):
open a new terminal after `make install`. Set `DOTFILES_NO_BASH=1` to stay in
zsh if the mise-installed Bash is broken.

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
| `tools.bash` | mise, zoxide, direnv, gcloud SDK, fzf, nomad |
| `prompt.bash` | Ghostty shell integration + starship prompt (sets `PROMPT_COMMAND`) |
| `history.bash` | Prepends `history -a` to `PROMPT_COMMAND` (must run last among PROMPT_COMMAND setters) |
| `completions.bash` | System-wide and mise-installed tab completions |
| `ssh_agent.bash` | Auto-start / attach SSH agent and add keys |

**Required tools:** `bash` ≥ 4 (installed by mise, `conda:bash`)

**Optional tools** (gracefully skipped when absent): `mise`, `starship`, `zoxide`,
`direnv`, `fzf`, `gcloud`, `nomad`, `zellij`

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
