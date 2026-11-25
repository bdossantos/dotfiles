# shellcheck shell=bash
# shellcheck disable=SC1090,SC1091
# ~/.bashrc — thin loader; all logic lives in ~/.config/bash/*.bash

_bash_config="${HOME}/.config/bash"

# 1. Shell options (shopt, set -o vi, …)
[[ -r "${_bash_config}/options.bash" ]] && source "${_bash_config}/options.bash"

# 2. Tool integrations — brew, mise, zoxide, direnv, fzf, gcloud, nomad; must
#    precede prompt.bash (so mise-managed starship is on PATH) and history.bash
[[ -r "${_bash_config}/tools.bash" ]] && source "${_bash_config}/tools.bash"

# 3. Prompt — Ghostty integration + starship (sets PROMPT_COMMAND)
[[ -r "${_bash_config}/prompt.bash" ]] && source "${_bash_config}/prompt.bash"

# 4. History — prepends 'history -a' to PROMPT_COMMAND; must run after all
#    other PROMPT_COMMAND setters (mise, direnv, starship, …)
[[ -r "${_bash_config}/history.bash" ]] && source "${_bash_config}/history.bash"

# 5. Tab completions (system + Homebrew)
[[ -r "${_bash_config}/completions.bash" ]] && source "${_bash_config}/completions.bash"

# 6. SSH agent — auto-start / attach
[[ -r "${_bash_config}/ssh_agent.bash" ]] && source "${_bash_config}/ssh_agent.bash"

unset _bash_config

# Aliases and shell functions
if [[ -f "${HOME}/.aliases" ]]; then
  source "${HOME}/.aliases"
fi

# ~/.extra — machine-local settings not committed to the repo
if [[ -f "${HOME}/.extra" ]]; then
  source "${HOME}/.extra"
fi

# Auto-attach or start a zellij session (interactive local TTY, non-nested)
if [[ $- == *i* ]] && [[ -t 0 && -t 1 ]] && [[ -z "${ZELLIJ}" ]] &&
  [[ -z "${SSH_CONNECTION}" ]] && command -v zellij &>/dev/null; then
  zellij attach -c 'BDS 🐑'
fi
