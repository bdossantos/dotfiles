# shellcheck shell=bash
# Terminal color support

# Initialise LS_COLORS from ~/.dircolors (fall back to distro defaults)
if command -v dircolors &>/dev/null; then
  if [[ -r "${HOME}/.dircolors" ]]; then
    eval "$(dircolors -b "${HOME}/.dircolors")"
  else
    eval "$(dircolors -b)"
  fi
fi

# macOS: enable colour output for ls(1)
export CLICOLOR=1

# Coloured GCC diagnostics (error, warning, note, …)
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
