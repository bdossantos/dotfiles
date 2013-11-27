# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME=""

# Example aliases
alias zshconfig="mate ~/.zshrc"
alias ohmyzsh="mate ~/.oh-my-zsh"

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
plugins=(git ruby gem bundler vagrant osx colored-man python pip brew go urltools vundle tmuxinator)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

# prompt
PURE_DEFAULT_USERNAME=$USER
PURE_CMD_MAX_EXEC_TIME=10
[ -f $ZSH/custom/pure/pure.zsh ] && source $ZSH/custom/pure/pure.zsh

# boxen
[ -f /opt/boxen/env.sh ] && source /opt/boxen/env.sh

# zsh syntax highlighting
hl="${HOMEBREW_ROOT}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
[ -f $hl ] && source $hl

# chruby
RUBIES=(~/.rubies/*)

[ -f /usr/local/share/chruby/chruby.sh ] && source /usr/local/share/chruby/chruby.sh
[ -f /usr/local/share/chruby/auto.sh ] && source /usr/local/share/chruby/auto.sh

# Base paths
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

# Aliases
alias vi='vim'
alias 'redis.start'='redis-server /usr/local/etc/redis.conf'
alias 'redis.stop'='kill $(cat /usr/local/var/run/redis.pid)'
alias ri='ri -f ansi'

# Some more alias to avoid making mistakes
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ln='ln -i'

# Time
alias now='date +"%T"'
alias nowtime='now'
alias nowdate='date +"%d-%m-%Y"'

# Shortcuts
alias c='clear'
alias x='exit'
alias q='exit'
alias h='history'
alias j='jobs -l'

# CAN I HAZ ?
alias please='sudo'

# passing alias to sudo
alias sudo='sudo '

# map Ctrl-Shift-left-arrow and Ctrl-Shift-right-arrow for word jumping
bindkey "\e[1;6D" backward-word
bindkey "\e[1;6C" forward-word
