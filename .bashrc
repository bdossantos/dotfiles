# shellcheck shell=bash
# shellcheck disable=SC1090,SC1091
# ~/.bashrc — thin loader; all logic lives in ~/.config/bash/*.bash

_bash_config="${HOME}/.config/bash"

# 1. Shell options (shopt, set -o vi, …)
[[ -r "${_bash_config}/options.bash" ]] && source "${_bash_config}/options.bash"

# 2. Colour — LS_COLORS, CLICOLOR, GCC_COLORS, COLORTERM
[[ -r "${_bash_config}/colors.bash" ]] && source "${_bash_config}/colors.bash"

# 3. Prompt — Ghostty integration + starship (sets PROMPT_COMMAND)
[[ -r "${_bash_config}/prompt.bash" ]] && source "${_bash_config}/prompt.bash"

# 4. Tool integrations — brew, chruby, zoxide, direnv (appends to
#    PROMPT_COMMAND), fzf, gcloud, nomad; must precede history.bash
[[ -r "${_bash_config}/tools.bash" ]] && source "${_bash_config}/tools.bash"

# 5. History — prepends 'history -a' to PROMPT_COMMAND; must run after all
#    other PROMPT_COMMAND setters (starship, direnv, …)
[[ -r "${_bash_config}/history.bash" ]] && source "${_bash_config}/history.bash"

# 6. Tab completions (system + Homebrew)
[[ -r "${_bash_config}/completions.bash" ]] && source "${_bash_config}/completions.bash"

# 7. SSH agent — auto-start / attach
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

# Auto-attach or start a zellij session (skip in nested or non-interactive shells)
if command -v zellij &>/dev/null && [[ -z "${ZELLIJ}" ]]; then
  zellij attach -c 'BDS 🐑'
fi
