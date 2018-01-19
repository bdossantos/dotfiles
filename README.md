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

### Choosing between .bashrc, .profile, .bash_profile, etc [...]

* ~/.bash_profile should be super-simple and just load .profile and .bashrc
  (in that order)
* ~/.profile has the stuff NOT specifically related to bash, such as environment
  variables (PATH and friends)
* ~/.bashrc has anything you'd want at an interactive command line. Command
  prompt, EDITOR variable, bash aliases for my use

A few other notes:

* Anything that should be available to graphical applications OR to sh (or bash
  invoked as sh) MUST be in ~/.profile
* ~/.bashrc must not output anything
* Anything that should be available only to login shells should go in ~/.profile
* Ensure that ~/.bash_login does not exist.

See also https://www.gnu.org/software/bash/manual/html_node/Bash-Startup-Files.html
