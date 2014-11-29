# Path to your oh-my-zsh configuration.
ZSH=~/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME=""

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(
  aws
  brew
  bundler
  capistrano
  colored-man
  common-aliases
  gem
  git
  go
  osx
  pip
  python
  rake-fast
  ruby
  tmux
  tmuxinator
  urltools
  vagrant
  vi-mode
  vundle
)

# load oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Customize to your needs...

# homebrew
export HOMEBREW_ROOT=$(brew --prefix)

# history settings
setopt hist_ignore_all_dups inc_append_history
HISTFILE=~/.zsh_history
HISTSIZE=4096
SAVEHIST=4096

# prompt
[[ -f ~/.bds.zsh-theme ]] && source ~/.bds.zsh-theme

# zsh syntax highlighting
hl="${HOMEBREW_ROOT}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
[[ -f $hl ]] && source "$hl"

# z is the new j, yo
export _Z_DATA=~/.z_data
[[ -f "${HOMEBREW_ROOT}/etc/profile.d/z.sh" ]] && \
  source "${HOMEBREW_ROOT}/etc/profile.d/z.sh"

# chruby
if [[ -d "${HOMEBREW_ROOT}/share/chruby" ]]; then
  RUBIES=(~/.rubies/*)

  source "${HOMEBREW_ROOT}/share/chruby/chruby.sh"
  source "${HOMEBREW_ROOT}/share/chruby/auto.sh"

  [[ -f ~/.ruby-version ]] && chruby "$(cat ~/.ruby-version)"
fi

# Base paths
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

# You may need to manually set your language environment
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Use vi-mode in Your Shell, see also vi-mode plugin
bindkey -M viins ';;' vi-cmd-mode
bindkey '^R' history-incremental-search-backward

# Aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# ~/.extra can be used for other settings you don't want to commit.
[[ -f ~/.extra ]] && source ~/.extra
