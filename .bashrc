# shellcheck disable=SC1090

# vi mode
set -o vi

# Bash-it
if [ -f "${BASH_IT}/bash_it.sh" ]; then
  source "${BASH_IT}/bash_it.sh"
fi

# base16
if [ -f "${BASE16_SHELL}/profile_helper.sh" ]; then
  eval "$("${BASE16_SHELL}/profile_helper.sh")"
fi

if [ -z "$BASE16_THEME" ] && type base16_ia-dark &>/dev/null; then
  base16_ia-dark
fi

# bash completions
if [ -f /etc/bash_completion ]; then
  source /etc/bash_completion
fi

if [ -f /etc/profile.d/bash_completion.sh ]; then
  source /etc/profile.d/bash_completion.sh
fi

if [ -f "${HOMEBREW_PREFIX}/etc/bash_completion" ]; then
  source "${HOMEBREW_PREFIX}/etc/bash_completion"
fi

if [ -f "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]; then
  source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
fi

# chruby
if [ -f "${HOMEBREW_PREFIX}/share/chruby/chruby.sh" ]; then
  RUBIES=("${HOME}/.rubies/*")

  source "${HOMEBREW_PREFIX}/share/chruby/chruby.sh"
  source "${HOMEBREW_PREFIX}/share/chruby/auto.sh"
fi

# pyenv
command -v pyenv &>/dev/null && eval "$(pyenv init -)"

# z is the new j, yo
if [ -f "${HOMEBREW_PREFIX}/etc/profile.d/z.sh" ]; then
  source "${HOMEBREW_PREFIX}/etc/profile.d/z.sh"
fi

# Magic per-project shell environments. Very pretentious.
if [ -f "${HOMEBREW_PREFIX}/opt/autoenv/activate.sh" ]; then
  source "${HOMEBREW_PREFIX}/opt/autoenv/activate.sh"
fi

# gcloud
GCLOUD_SDK="${HOME}/.google-cloud-sdk"
if [ -f "${GCLOUD_SDK}/path.bash.inc" ] \
  && [ -f "${GCLOUD_SDK}/completion.bash.inc" ]; then
  source "${GCLOUD_SDK}/path.bash.inc"
  source "${GCLOUD_SDK}/completion.bash.inc"
fi

# kubectl
if command -v kubectl &>/dev/null; then
  source <(kubectl completion bash)
fi

# kops
if [ ! -f "${HOME}/.kops/completion.bash.inc" ]; then
  mkdir -m 0700 -p "${HOME}/.kops/"
  command -v kops &>/dev/null \
    && kops completion bash > "${HOME}/.kops/completion.bash.inc"
fi

if [ -f "${HOME}/.kops/completion.bash.inc" ]; then
  source "${HOME}/.kops/completion.bash.inc"
fi

# fzf
if [ -f "${HOME}/.fzf.bash" ]; then
  source "${HOME}/.fzf.bash"
fi

# Auto start|attach tmux session
if command -v tmux &>/dev/null; then
  if [ -z "$TMUX" ] ;then
    if tmux ls &> /dev/null; then
      exec tmux attach-session
    else
      exec tmux new-session
    fi
  fi
fi

# Auto start|attach ssh-agent
if ! ssh-add -l &>/dev/null; then
  SSH_AGENT="${HOME}/.ssh-agent"

  [ -r "$SSH_AGENT" ] \
    && eval "$(< "$SSH_AGENT")" >/dev/null

  if ! ssh-add -l &>/dev/null; then
    (umask 066; ssh-agent > "$SSH_AGENT")
    eval "$(< "$SSH_AGENT")" >/dev/null
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
