#!/usr/bin/env bash

CWD="$(pwd)"
FILES='zshrc zshenv gitconfig gitignore_global'

for f in $FILES; do
    rm -f ~/.$f.orig
    if [ -f ~/.$f ]; then
        cp -f -R ~/.$f{,.orig}
    fi
    ln -v -s -f $CWD/$f ~/.$f
done