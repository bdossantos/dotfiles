# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="minimal"

# Example aliases
alias zshconfig="mate ~/.zshrc"
alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git ruby gem bundler vagrant osx colored-man python pip brew go urltools vundle)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

# prompt
PROMPT='%{$fg[white]%}%2~ $(git_prompt_info)%{$fg[red]%}%# %{$reset_color%}'
ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}[%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}] "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN=""

# boxen
[ -f /opt/boxen/env.sh ] && source /opt/boxen/env.sh

# chruby
if [ -f /usr/local/share/chruby/chruby.sh ]; then
  source /usr/local/share/chruby/chruby.sh
fi

if [ -f /usr/local/share/chruby/auto.sh ]; then
  source /usr/local/share/chruby/auto.sh
fi

RUBIES=(~/.rubies/*)

if which chruby &>/dev/null; then
  chruby 2.0.0-p247
fi

# Base paths
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

# Aliases
alias vi='vim'
alias 'redis.start'='redis-server /usr/local/etc/redis.conf'
alias 'redis.stop'='kill $(cat /usr/local/var/run/redis.pid)'

# map Ctrl-Shift-left-arrow and Ctrl-Shift-right-arrow for word jumping
bindkey "\e[1;6D" backward-word
bindkey "\e[1;6C" forward-word
