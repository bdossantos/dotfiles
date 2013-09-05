#!/usr/bin/env bash

if ! which stow >/dev/null; then
  echo "CAN I HAZ STOW ?"
  exit 1
fi

script_name=$(basename $0)

stow -S . -t $HOME -v --ignore='README.md' --ignore="$script_name"
if [ $? -eq 0 ]; then
  exec $SHELL
fi
