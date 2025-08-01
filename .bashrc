# shellcheck shell=bash
# shellcheck disable=SC1090

# vi mode
set -o vi

# append history instead of rewriting it
shopt -s histappend

# save multi-line commands in history as single line
shopt -s cmdhist

# autocorrects cd misspellings
shopt -s cdspell

# include dotfiles in pathname expansio
shopt -s dotglob

# expand aliases
shopt -s expand_aliases

# enable extended pattern-matching features
shopt -s extglob

# pathname expansion will be treated as case-insensitive
shopt -s nocaseglob

# ghostty
if [[ -n ${GHOSTTY_RESOURCES_DIR} ]]; then
  builtin source "${GHOSTTY_RESOURCES_DIR}/shell-integration/bash/ghostty.bash"
fi

# starship
if command -v starship &>/dev/null; then
  eval "$(starship init bash)"
fi

# bash completions
if [ -r /etc/bash_completion ]; then
  # shellcheck disable=SC1091
  source /etc/bash_completion
fi

if [ -r /etc/profile.d/bash_completion.sh ]; then
  # shellcheck disable=SC1091
  source /etc/profile.d/bash_completion.sh
fi

# brew
if command -v brew &>/dev/null; then
  eval "$(brew shellenv)"
fi

# https://docs.brew.sh/Shell-Completion
if [ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]; then
  export BASH_COMPLETION_COMPAT_DIR="${HOMEBREW_PREFIX}/etc/bash_completion.d"
  # shellcheck disable=SC1091
  source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
else
  for completion in "${HOMEBREW_PREFIX}"/etc/bash_completion.d/*; do
    [ -r "$completion" ] && source "$completion"
  done
fi

# Save bash history after each command, depend `shopt -s histappend`
# Optimized history management - just append new entries
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

# chruby
if [ -f "${HOMEBREW_PREFIX}/share/chruby/chruby.sh" ]; then
  # shellcheck disable=SC2034
  RUBIES=("${HOME}/.rubies/*")

  # shellcheck source=/dev/null
  source "${HOMEBREW_PREFIX}/share/chruby/chruby.sh"
  # shellcheck source=/dev/null
  source "${HOMEBREW_PREFIX}/share/chruby/auto.sh"
fi

if command -v zoxide &>/dev/null; then
  eval "$(zoxide init bash)"
fi

if command -v direnv &>/dev/null; then
  eval "$(direnv hook bash)"
fi

# gcloud
# For Homebrew-installed gcloud-cli
if command -v brew &>/dev/null; then
  GCLOUD_SDK="${HOMEBREW_PREFIX}/share/google-cloud-sdk"
  if [ -f "${GCLOUD_SDK}/path.bash.inc" ] &&
    [ -f "${GCLOUD_SDK}/completion.bash.inc" ]; then
    # shellcheck source=/dev/null
    source "${GCLOUD_SDK}/path.bash.inc"
    # shellcheck source=/dev/null
    source "${GCLOUD_SDK}/completion.bash.inc"
  fi
fi

# fzf
if command -v fzf &>/dev/null; then
  eval "$(fzf --bash)"
fi

# nomad
if command -v nomad &>/dev/null; then
  complete -C nomad nomad
fi

# Auto attach|start ssh-agent
SSH_AGENT="${HOME}/.ssh-agent"

if [ -r "$SSH_AGENT" ]; then
  eval "$(<"$SSH_AGENT")" >/dev/null
fi

if [ -z "$SSH_AGENT_PID" ] || ! kill -0 "$SSH_AGENT_PID" &>/dev/null; then
  (
    umask 066
    ssh-agent >"$SSH_AGENT"
  )

  eval "$(<"$SSH_AGENT")" >/dev/null
fi

if ! ssh-add -l &>/dev/null; then
  trap '' SIGINT
  ssh-add -t 8h
  trap - SIGINT
fi

# Aliases
if [ -f "${HOME}/.aliases" ]; then
  # shellcheck source=/dev/null
  source "${HOME}/.aliases"
fi

# ~/.extra can be used for other settings you don't want to commit.
if [ -f "${HOME}/.extra" ]; then
  # shellcheck source=/dev/null
  source "${HOME}/.extra"
fi

# Theme switcher integration
if [ -f "${HOME}/.config/theme-switcher/bashrc-addition" ]; then
  # shellcheck source=/dev/null
  source "${HOME}/.config/theme-switcher/bashrc-addition"
fi

# Auto start|attach zellij session
if command -v zellij &>/dev/null; then
  if [ -z "$ZELLIJ" ]; then
    zellij attach -c 'BDS 🐑'
  fi
fi
