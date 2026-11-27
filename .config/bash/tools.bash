# shellcheck shell=bash
# Third-party tool integrations
# Must be sourced before prompt.bash (so mise-managed tools like starship are
# on PATH) and before history.bash: tools such as mise and direnv update
# PROMPT_COMMAND, and history.bash needs to run last to prepend history -a.

# mise — polyglot version manager (replaces chruby + auto.sh)
if command -v mise &>/dev/null; then
  eval "$(mise activate bash)"
fi

# zoxide — smarter cd
# starship (prompt.bash) moves the existing PROMPT_COMMAND into
# STARSHIP_PROMPT_COMMAND, so __zoxide_hook still runs but zoxide's doctor
# can't see it in PROMPT_COMMAND and prints a false-positive warning.
if command -v zoxide &>/dev/null; then
  export _ZO_DOCTOR=0
  eval "$(zoxide init bash)"
fi

# direnv — per-directory env vars (appends to PROMPT_COMMAND)
if command -v direnv &>/dev/null; then
  eval "$(direnv hook bash)"
fi

# gcloud SDK (mise-installed: the bin/ directory is already on PATH)
if command -v gcloud &>/dev/null; then
  _gcloud_dir="$(mise where gcloud 2>/dev/null)"
  if [[ -r "${_gcloud_dir}/completion.bash.inc" ]]; then
    # shellcheck source=/dev/null
    source "${_gcloud_dir}/completion.bash.inc"
  fi
  unset _gcloud_dir
fi

# fzf — fuzzy finder (key bindings + completion)
if command -v fzf &>/dev/null; then
  eval "$(fzf --bash)"
fi

# nomad completion
if command -v nomad &>/dev/null; then
  complete -C nomad nomad
fi
