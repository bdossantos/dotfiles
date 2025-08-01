# ~/.dotfiles

## dotfiles

### Installation

Using [GNU Stow](http://www.gnu.org/software/stow/):

```bash
git clone https://github.com/bdossantos/dotfiles ~/.dotfiles
cd ~/.dotfiles
make install
```

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

## Automatic Light/Dark Mode Switching

This dotfiles setup includes automatic light/dark mode switching for both Ghostty terminal and Neovim based on the time of day.

### How it works

- **Light Mode**: Active from 7:00 AM to 6:59 PM
- **Dark Mode**: Active from 7:00 PM to 6:59 AM
- **Ghostty**: Switches between `github-light` and `dracula` themes
- **Neovim**: Switches between `github_light` and `dracula` colorschemes

### Components

1. **`bin/theme-mode`**: Core script that detects current time and returns appropriate theme
2. **`bin/set-ghostty-theme`**: Updates Ghostty configuration with time-appropriate theme
3. **Bash Integration**: Automatically runs theme switching on new shell launches
4. **Neovim Integration**: Automatically sets colorscheme when Neovim starts

### Manual Theme Control

You can manually test or force theme changes:

```bash
# Check current theme mode
~/.dotfiles/bin/theme-mode

# Manually switch Ghostty theme
~/.dotfiles/bin/set-ghostty-theme

# Get theme names for different tools
~/.dotfiles/bin/theme-mode ghostty-light    # Returns: github-light
~/.dotfiles/bin/theme-mode ghostty-dark     # Returns: dracula
~/.dotfiles/bin/theme-mode nvim-light       # Returns: github_light  
~/.dotfiles/bin/theme-mode nvim-dark        # Returns: dracula
```

### Requirements

- **Ghostty**: Must have `github-light` and `dracula` themes available
- **Neovim**: Requires the github-nvim-theme plugin (installed automatically via LazyVim)
- **Portability**: Works on Linux and macOS systems

The switching happens automatically on:
- New terminal/shell sessions (Ghostty)  
- Neovim startup (colorscheme selection)

For troubleshooting, check that the scripts in `bin/` are executable and that your system's `date` command works correctly.
