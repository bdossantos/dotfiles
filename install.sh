#!/usr/bin/env bash

CWD="$(pwd)"
FILES='.zshrc .gitconfig .gitignore_global'

for f in $FILES; do
    cp -v -f -R ~/$f ~/$f.orig
    ln -v -s -f $CWD/$f ~/$f
done