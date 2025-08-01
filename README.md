# ~/.dotfiles

Personal configuration files for various tools and applications.

## Features

- **Shell Configuration**: Enhanced Bash setup with completions, history management, and integrations  
- **Terminal Applications**: Configurations for tmux, vim, neovim, and modern terminal emulators
- **Development Tools**: Git, SSH, and various development environment setups
- **Automated Installation**: Makefile-based installation with dependency management
- **🌅 Automatic Theme Switcher**: Time-based light/dark theme switching for terminal, shell, and editor

## dotfiles

### Installation

Using [GNU Stow](http://www.gnu.org/software/stow/):

```bash
git clone https://github.com/bdossantos/dotfiles ~/.dotfiles
cd ~/.dotfiles
make install
```

### Theme Switcher

The dotfiles include an intelligent theme switching system that automatically adjusts themes based on time of day:

- **Ghostty terminal**: Custom light/dark color palettes
- **Bash shell**: Theme-aware color variables  
- **Neovim**: Automatic colorscheme switching (Dracula ↔ Tokyo Night Day)

#### Quick Theme Setup

```bash
# Initialize theme configuration
./bin/theme-switcher setup

# Test theme switching
./bin/theme-switcher light
./bin/theme-switcher dark
./bin/theme-switcher auto

# Set up automatic switching (7 AM light, 7 PM dark)
.config/theme-switcher/setup-cron.sh install
```

See [Theme Switcher Documentation](.config/theme-switcher/README.md) for detailed usage and customization options.

### Uninstallation

```bash
cd ~/.dotfiles
make uninstall
```

## Mac setup

### Sensible OS X defaults

When setting up a new Mac, you may want to set some sensible OS X defaults:

```bash
su - admin -c "env PATH=$PATH:/usr/sbin/ bash -x $HOME/.dotfiles/.macos"
su - admin -c "env PATH=$PATH:/usr/sbin/ bash -x $HOME/.dotfiles/.macos_hardening"
```

### Install Homebrew Formulae/Native apps

```bash
make run-brew
```

## Bash

### Installation

```bash
chsh -s "$(brew --prefix)/bin/bash"
exec $SHELL
```

### Choosing between .bashrc, .profile, .bash_profile, etc [...]

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

See also https://www.gnu.org/software/bash/manual/html_node/Bash-Startup-Files.html
