# dotfiles

## Installation

Using [GNU Stow](http://www.gnu.org/software/stow/):

```bash
git clone https://github.com/bdossantos/dotfiles ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

## Uninstallation

```bash
cd ~/.dotfiles
stow -D . -t $HOME -v
```
