#!/usr/bin/env bash

if ! which stow >/dev/null; then
  echo 'CAN I HAZ STOW ?'
  exit 1
fi

script_name=$(basename "$0")

stow -S . -t "$HOME" -v \
  --ignore='README.md' \
  --ignore="LICENCE" \
  --ignore="$script_name" && \
  exec "$SHELL"
