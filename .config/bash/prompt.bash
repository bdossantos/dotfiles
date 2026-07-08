# shellcheck shell=bash
# Prompt: Ghostty shell integration and starship
# Must be sourced before history.bash so that PROMPT_COMMAND is fully
# populated by the time history -a is prepended.

# Ghostty shell integration
if [[ -n "${GHOSTTY_RESOURCES_DIR}" ]]; then
  # shellcheck source=/dev/null
  builtin source "${GHOSTTY_RESOURCES_DIR}/shell-integration/bash/ghostty.bash"
fi

# Starship cross-shell prompt
if command -v starship &>/dev/null; then
  eval "$(starship init bash)"
fi
