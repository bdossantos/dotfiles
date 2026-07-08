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

# include dotfiles in glob expansion
shopt -s dotglob

# expand aliases in interactive shells
shopt -s expand_aliases

# enable extended glob patterns: !(pat), +(pat), ?(pat), @(pat), *(pat)
shopt -s extglob

# case-insensitive glob matching
shopt -s nocaseglob
