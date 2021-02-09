# shellcheck shell=bash
# shellcheck disable=SC1090
if [ -f "${HOME}/.profile" ]; then
  . "${HOME}/.profile"
fi

if [ -f "${HOME}/.bashrc" ]; then
  . "${HOME}/.bashrc"
fi
