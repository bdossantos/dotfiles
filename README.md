# ~/.dotfiles

## dotfiles

### Installation

Using [GNU Stow](http://www.gnu.org/software/stow/):

```bash
git clone https://github.com/bdossantos/dotfiles ~/.dotfiles
cd ~/.dotfiles
./install
```

### Uninstallation

```bash
cd ~/.dotfiles
stow -D . -t $HOME -v
```

## Mac setup

### Sensible OS X defaults

When setting up a new Mac, you may want to set some sensible OS X defaults:

```bash
./.osx
```

### Install Homebrew Formulae/Native apps

```bash
./.brew 2>/dev/null
```
