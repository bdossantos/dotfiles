# PATH
export PATH="$HOME/.homebrew/bin:$HOME/.homebrew/sbin:$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH"

# Homebrew prefix
export HOMEBREW_PREFIX='/usr/local'
if which brew &>/dev/null; then
  exportHOMEBREW_PREFIX="$(brew --prefix)"
fi

# You may need to manually set your language environment
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'

# default editor
export EDITOR='vim'
export VISUAL='vim'

# history
export HISTFILE="${HOME}/.bash_history"
export HISTSIZE=32768
export HISTFILESIZE=$HISTSIZE
export HISTCONTROL='ignoreboth'
export HISTIGNORE='ls:cd:cd -:pwd:exit:date:* --help'

# pager
export PAGER='less'

# Set the default Less options.
# # Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# # Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS='-F -g -i -M -R -S -w -X -z-4'

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if less_pipe=$(which lesspipe); then
  eval "$($less_pipe)"
elif less_pipe=$(which lesspipe.sh); then
  eval "$($less_pipe)"
fi

# Don't clear the screen after quitting a manual page
export MANPAGER='less -X'

# bash-it
export BASH_IT="${HOME}/.bash_it"
export BASH_IT_THEME='minimal'

if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
  export BASH_IT_THEME='demula'
fi

# color scheme
export TERM='xterm-256color'
export BASE16_THEME='base16-ashes'
export BASE16_SHELL="${HOME}/.base16-shell/scripts/${BASE16_THEME}.sh"

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
export FZF_DEFAULT_COMMAND='ag -l -g ""'

# Temporary Files
if [ ! -d "$TMPDIR" ]; then
  export TMPDIR="/tmp/${LOGNAME}"
  mkdir -p -m 700 "$TMPDIR"
fi

# diff-highligh
if [ -d "${HOMEBREW_PREFIX}/share/git-core/contrib/diff-highlight/" ]; then
  export PATH="${PATH}:${HOMEBREW_PREFIX}/share/git-core/contrib/diff-highlight/"
fi

# Set this to false to turn off version control status checking within the prompt for all themes
export SCM_CHECK=true

# Don't check mail when opening terminal.
unset MAILCHECK
