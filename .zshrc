# shellcheck shell=bash
# The login shell stays /bin/zsh: `chsh` only accepts the shells listed in
# /etc/shells, which needs admin rights to edit. Hand over to the bash
# installed by mise (conda:bash) instead, and fall back to the system bash.
# Set DOTFILES_NO_BASH=1 to stay in zsh (e.g. when mise-installed bash breaks).
if [[ -o interactive && -z "${BASH_VERSION:-}" && -z "${DOTFILES_NO_BASH:-}" ]]; then
  _bash="${MISE_DATA_DIR:-${HOME}/.local/share/mise}/installs/conda-bash/latest/bin/bash"
  [[ -x "${_bash}" ]] || _bash=/bin/bash
  if [[ -x "${_bash}" ]]; then
    export SHELL="${_bash}"
    exec "${_bash}" -l
  fi
  unset _bash
fi
