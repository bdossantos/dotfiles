# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# User configuration

# PATH
export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH

# You may need to manually set your language environment
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# homebrew
export HOMEBREW_ROOT=$(brew --prefix)

# history settings
setopt hist_ignore_all_dups inc_append_history
HISTFILE=~/.zsh_history
HISTSIZE=4096
SAVEHIST=4096

# color scheme
export TERM=xterm-256color
BASE16_SHELL=~/.base16-shell/base16-tomorrow.dark.sh
[[ -f $BASE16_SHELL ]] && source $BASE16_SHELL

# z is the new j, yo
export _Z_DATA=~/.z_data
[[ -f "${HOMEBREW_ROOT}/etc/profile.d/z.sh" ]] && \
  source "${HOMEBREW_ROOT}/etc/profile.d/z.sh"

# gcloud
GCLOUD_SDK=/opt/homebrew-cask/Caskroom/google-cloud-sdk/latest/google-cloud-sdk
[[ -f "${GCLOUD_SDK}/path.zsh.inc" ]] && source "${GCLOUD_SDK}/path.zsh.inc"
[[ -f "${GCLOUD_SDK}/completion.zsh.inc" ]] && \
  source "${GCLOUD_SDK}/completion.zsh.inc"

# Use vi-mode in Your Shell, see also vi-mode plugin
bindkey -M viins ';;' vi-cmd-mode
bindkey '^R' history-incremental-search-backward

# Aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# ~/.extra can be used for other settings you don't want to commit.
[[ -f ~/.extra ]] && source ~/.extra
