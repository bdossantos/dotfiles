# PATH
export PATH="$HOME/.homebrew/bin:$HOME/.homebrew/sbin:$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH"

# Homebrew prefix
export HOMEBREW_PREFIX='/usr/local'
if command -v brew >/dev/null 2>&1; then
  HOMEBREW_PREFIX="$(brew --prefix)"
  export HOMEBREW_PREFIX
fi

export HOMEBREW_CASK_OPTS="--appdir=${HOME}/Applications --fontdir=${HOME}/Library/Fonts --no-binaries"
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_INSECURE_REDIRECT=1

# XDG_CONFIG_DIR
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"

# You may need to manually set your language environment
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'

# default editor
export EDITOR='vim'
export VISUAL='vim'

if command -v nvim &>/dev/null; then
  export EDITOR='nvim'
  export VISUAL='nvim'
fi

# history
export HISTFILE="${HOME}/.bash_history"
export HISTSIZE=32768
export HISTFILESIZE=$HISTSIZE
export HISTCONTROL='ignoreboth'
export HISTIGNORE='ls:cd:cd -:pwd:exit:date:*--help:vault*:*VAULT_TOKEN*:*NOMAD_TOKEN*:*CONSUL_HTTP_TOKEN*'
export HISTTIMEFORMAT='%h/%d -- %H:%M:%S '

# pager
export PAGER='less'

# Set the default Less options.
# # Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# # Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS='-F -g -i -M -R -S -w -X -z-4'

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if less_pipe=$(command -v lesspipe); then
  eval "$($less_pipe)"
elif less_pipe=$(command -v lesspipe.sh); then
  eval "$($less_pipe)"
fi

# man
export MANPATH="$HOME/.homebrew/share/man${MANPATH+:$MANPATH}:"

# Don't clear the screen after quitting a manual page
export MANPAGER='less -X'

# color scheme
export TERM='xterm-256color'
export BAT_THEME='Dracula'

# enable cheat syntax highlighting
export CHEATCOLORS=true

# speed up building ruby
export RUBY_CONFIGURE_OPTS='--disable-install-rdoc --disable-install-ri'

# ruby build cache path
export RUBY_BUILD_CACHE_PATH="${HOME}/.rubies/cache"

# Allow bundler to use all the cores for parallel installation
export BUNDLE_JOBS=4

# Go
export GOPATH="${HOME}/Code/go"
export PATH="$PATH:$GOPATH/bin"

# MySQL prompt
export MYSQL_PS1='(\D) \u@\h [\d] > '

# 20ms for key sequences
export KEYTIMEOUT=20

# Setting ag as the default source for fzf
export FZF_DEFAULT_COMMAND='rg --files --ignore-vcs --hidden'

# fzf preview
export FZF_PREVIEW_COMMAND="bat --style=numbers,changes --wrap never --color always {} || cat {} || tree -C {}"
export FZF_DEFAULT_OPTS="--preview '($FZF_PREVIEW_COMMAND) 2> /dev/null' --preview-window=right:50% --color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden --bind ?:toggle-preview"
export FZF_CTRL_T_OPTS="--preview '($FZF_PREVIEW_COMMAND) 2> /dev/null | head -$LINES'"

# Temporary Files
if [ ! -d "$TMPDIR" ]; then
  export TMPDIR="/tmp/${USER}"
  mkdir -p -m 0700 "$TMPDIR"
fi

# diff-highligh
if [ -d "${HOMEBREW_PREFIX}/share/git-core/contrib/diff-highlight/" ]; then
  export PATH="${PATH}:${HOMEBREW_PREFIX}/share/git-core/contrib/diff-highlight"
fi

# Set this to false to turn off version control status checking within the prompt for all themes
export SCM_CHECK=true

# Don't check mail when opening terminal.
unset MAILCHECK

# Unset KUBECONFIG, config is defined in each .envrc files
export KUBECONFIG=/dev/null

# Set default platform for docker buildx
export DOCKER_DEFAULT_PLATFORM=linux/amd64
