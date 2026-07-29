# shellcheck shell=bash
# Bash shell options

# vi keybindings at the command line
set -o vi

# append to history file instead of overwriting it
shopt -s histappend

# save multi-line commands as a single history entry
shopt -s cmdhist

# auto-correct minor cd misspellings
shopt -s cdspell

# include dotfiles in pathname expansion (globbing)
shopt -s dotglob

# expand aliases in interactive shells
shopt -s expand_aliases

# enable extended glob patterns: !(pat), +(pat), ?(pat), @(pat), *(pat)
shopt -s extglob

# case-insensitive glob matching
shopt -s nocaseglob

# enable ** recursive globbing (e.g. ls **/*.rb)
shopt -s globstar

# update LINES/COLUMNS after each command (fixes resize artefacts)
shopt -s checkwinsize

# cd by typing a path alone, without the cd command
shopt -s autocd

# spell-correction for directory tab-completion
shopt -s dirspell

# show history expansion result in readline buffer before executing
shopt -s histverify
