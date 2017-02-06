# PATH
export PATH=$HOME/.homebrew/bin:$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH

# Homebrew prefix
export HOMEBREW_PREFIX="$(brew --prefix)"

# You may need to manually set your language environment
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'

# default editor
export EDITOR='vim'
export VISUAL='vim'

# history
export HISTFILE="${HOME}/.zsh_history"
export HISTSIZE=32768
export HISTFILESIZE=$HISTSIZE
export HISTCONTROL='ignoreboth'
export HISTIGNORE='ls:cd:cd -:pwd:exit:date:* --help'

# Enable persistent REPL history for `node`.
export NODE_REPL_HISTORY_FILE="${HOME}/.node_history"
# Allow 32³ entries; the default is 1000.
export NODE_REPL_HISTORY_SIZE=32768

# pager
export PAGER='less'

# Set the default Less options.
# # Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# # Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS='-F -g -i -M -R -S -w -X -z-4'

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

# Don't clear the screen after quitting a manual page
export MANPAGER='less -X'

# color scheme
export TERM='xterm-256color'
BASE16_SHELL="${HOME}/.base16-shell/scripts/base16-tomorrow-night.sh"
[[ -f $BASE16_SHELL ]] && source $BASE16_SHELL

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
export PATH=$PATH:$GOPATH/bin

# MySQL prompt
export MYSQL_PS1='(\D) \u@\h [\d] > '

# Always enable colored `grep` output
export GREP_OPTIONS='--color=auto'

# 20ms for key sequences
export KEYTIMEOUT=20

# chruby
if [[ -f "${HOMEBREW_PREFIX}/share/chruby/chruby.sh" ]]; then
  RUBIES=("${HOME}/.rubies/*")

  source "${HOMEBREW_PREFIX}/share/chruby/chruby.sh"
  source "${HOMEBREW_PREFIX}/share/chruby/auto.sh"
fi

# Setting ag as the default source for fzf
export FZF_DEFAULT_COMMAND='ag -l -g ""'

# z is the new j, yo
export _Z_DATA="${HOME}/.z_data"
[[ -f "${HOMEBREW_PREFIX}/etc/profile.d/z.sh" ]] \
  && source "${HOMEBREW_PREFIX}/etc/profile.d/z.sh"

# Magic per-project shell environments. Very pretentious.
[[ -f "${HOMEBREW_PREFIX}/opt/autoenv/activate.sh" ]] \
  && source "${HOMEBREW_PREFIX}/opt/autoenv/activate.sh"

# iTerm2 Shell integration
[[ -f "${HOME}/.iterm2_shell_integration.zsh" ]] \
  && source "${HOME}/.iterm2_shell_integration.zsh"

# Temporary Files
if [[ ! -d "$TMPDIR" ]]; then
  export TMPDIR="/tmp/${LOGNAME}"
  mkdir -p -m 700 "$TMPDIR"
fi

TMPPREFIX="${TMPDIR%/}/zsh"

# Local config
[[ -f "${HOME}/.zshenv.local" ]] && source "${HOME}/.zshenv.local"
