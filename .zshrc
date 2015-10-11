# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# User configuration

# Use vi-mode in Your Shell, see also vi-mode plugin
bindkey -M viins 'jj' vi-cmd-mode
bindkey '^R' history-incremental-search-backward

# gcloud
GCLOUD_SDK=/opt/homebrew-cask/Caskroom/google-cloud-sdk/latest/google-cloud-sdk
[[ -f "${GCLOUD_SDK}/path.zsh.inc" ]] && source "${GCLOUD_SDK}/path.zsh.inc"
[[ -f "${GCLOUD_SDK}/completion.zsh.inc" ]] && \
  source "${GCLOUD_SDK}/completion.zsh.inc"

# Aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# ~/.extra can be used for other settings you don't want to commit.
[[ -f ~/.extra ]] && source ~/.extra
