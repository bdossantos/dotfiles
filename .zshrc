# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# User configuration

# Use vi-mode in Your Shell, see also vi-mode plugin
bindkey -M viins ';;' vi-cmd-mode
bindkey '^R' history-incremental-search-backward

# Aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# ~/.extra can be used for other settings you don't want to commit.
[[ -f ~/.extra ]] && source ~/.extra
