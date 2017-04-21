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
```

### Install Homebrew Formulae/Native apps

```bash
make run-brew
```
