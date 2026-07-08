# shellcheck shell=bash
# Tab completions: system-wide and Homebrew

# System bash completions
if [[ -r /etc/bash_completion ]]; then
  # shellcheck source=/dev/null
  source /etc/bash_completion
fi

if [[ -r /etc/profile.d/bash_completion.sh ]]; then
  # shellcheck source=/dev/null
  source /etc/profile.d/bash_completion.sh
fi

# Homebrew bash completions
# https://docs.brew.sh/Shell-Completion
if [[ -n "${HOMEBREW_PREFIX}" ]]; then
  if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]; then
    export BASH_COMPLETION_COMPAT_DIR="${HOMEBREW_PREFIX}/etc/bash_completion.d"
    # shellcheck source=/dev/null
    source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
  else
    for _completion in "${HOMEBREW_PREFIX}"/etc/bash_completion.d/*; do
      # shellcheck source=/dev/null
      [[ -r "$_completion" ]] && source "$_completion"
    done
    unset _completion
  fi
fi
