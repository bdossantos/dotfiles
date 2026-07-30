# shellcheck shell=bash
# Third-party tool integrations
# Must be sourced before history.bash: tools such as direnv append to
# PROMPT_COMMAND, and history.bash needs to run last to prepend history -a.

# brew — refresh PATH, HOMEBREW_CELLAR, HOMEBREW_REPOSITORY, MANPATH, INFOPATH
if command -v brew &>/dev/null; then
  eval "$(brew shellenv)"
fi

# mise — polyglot version manager (replaces chruby + auto.sh)
if command -v mise &>/dev/null; then
  eval "$(mise activate bash)"
fi

# zoxide — smarter cd
if command -v zoxide &>/dev/null; then
  eval "$(zoxide init bash)"
fi

# direnv — per-directory env vars (appends to PROMPT_COMMAND)
if command -v direnv &>/dev/null; then
  eval "$(direnv hook bash)"
fi

# gcloud SDK (Homebrew-installed)
if [[ -n "${HOMEBREW_PREFIX}" ]] &&
  [[ -f "${HOMEBREW_PREFIX}/share/google-cloud-sdk/path.bash.inc" ]] &&
  [[ -f "${HOMEBREW_PREFIX}/share/google-cloud-sdk/completion.bash.inc" ]]; then
  # shellcheck source=/dev/null
  source "${HOMEBREW_PREFIX}/share/google-cloud-sdk/path.bash.inc"
  # shellcheck source=/dev/null
  source "${HOMEBREW_PREFIX}/share/google-cloud-sdk/completion.bash.inc"
fi

# fzf — fuzzy finder (key bindings + completion)
if command -v fzf &>/dev/null; then
  eval "$(fzf --bash)"
fi

# nomad completion
if command -v nomad &>/dev/null; then
  complete -C nomad nomad
fi
