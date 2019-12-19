# shellcheck disable=SC1090

# vi mode
set -o vi

# starship
if command -v starship &>/dev/null; then
  eval "$(starship init bash)"
fi

# base16
if [ -f "${BASE16_SHELL}/profile_helper.sh" ]; then
  eval "$("${BASE16_SHELL}/profile_helper.sh")"
fi

if [ -z "$BASE16_THEME" ] && type base16_ia-dark &>/dev/null; then
  base16_ia-dark
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

# https://docs.brew.sh/Shell-Completion
if [ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]; then
  export BASH_COMPLETION_COMPAT_DIR="${HOMEBREW_PREFIX}/etc/bash_completion.d"
  source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
else
  for completion in "${HOMEBREW_PREFIX}"/etc/bash_completion.d/*; do
    [ -r "$completion" ] && source "$completion"
  done
fi

# chruby
if [ -f "${HOMEBREW_PREFIX}/share/chruby/chruby.sh" ]; then
  # shellcheck disable=SC2034
  RUBIES=("${HOME}/.rubies/*")

  source "${HOMEBREW_PREFIX}/share/chruby/chruby.sh"
  source "${HOMEBREW_PREFIX}/share/chruby/auto.sh"
fi

# z is the new j, yo
if [ -f "${HOMEBREW_PREFIX}/etc/profile.d/z.sh" ]; then
  source "${HOMEBREW_PREFIX}/etc/profile.d/z.sh"
fi

if command -v direnv &>/dev/null; then
  eval "$(direnv hook bash)"
fi

# gcloud
GCLOUD_SDK="${HOME}/.google-cloud-sdk"
if [ -f "${GCLOUD_SDK}/path.bash.inc" ] &&
  [ -f "${GCLOUD_SDK}/completion.bash.inc" ]; then
  source "${GCLOUD_SDK}/path.bash.inc"
  source "${GCLOUD_SDK}/completion.bash.inc"
fi

# fzf
if [ -f "${HOME}/.fzf.bash" ]; then
  source "${HOME}/.fzf.bash"
fi

# nomad
if command -v nomad &>/dev/null; then
  complete -C nomad nomad
fi

# Auto start|attach tmux session
if command -v tmux &>/dev/null; then
  if [ -z "$TMUX" ]; then
    if tmux ls &>/dev/null; then
      exec tmux attach-session
    else
      exec tmux new-session
    fi
  fi
fi

# Auto start|attach ssh-agent
if ! ssh-add -l &>/dev/null; then
  SSH_AGENT="${HOME}/.ssh-agent"

  [ -r "$SSH_AGENT" ] &&
    eval "$(<"$SSH_AGENT")" >/dev/null

  if ! ssh-add -l &>/dev/null; then
    (
      umask 066
      ssh-agent >"$SSH_AGENT"
    )
    eval "$(<"$SSH_AGENT")" >/dev/null
    ssh-add -t 8h
  fi
fi

# Aliases
if [ -f "${HOME}/.aliases" ]; then
  source "${HOME}/.aliases"
fi

# ~/.extra can be used for other settings you don't want to commit.
if [ -f "${HOME}/.extra" ]; then
  source "${HOME}/.extra"
fi
