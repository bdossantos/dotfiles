# default editor
VIM=$(which vim)
export EDITOR=$VIM
export VISUAL=$VIM

# history
export HISTSIZE=32768
export HISTFILESIZE=$HISTSIZE
export HISTCONTROL=ignoredups
export HISTIGNORE='ls:cd:cd -:pwd:exit:date:* --help'

# Enable persistent REPL history for `node`.
export NODE_REPL_HISTORY_FILE=~/.node_history;
# Allow 32³ entries; the default is 1000.
export NODE_REPL_HISTORY_SIZE='32768';

# pager
export PAGER='less'
export LESS='-r -R --follow-name'

# Don't clear the screen after quitting a manual page
export MANPAGER='less -X'

# enable cheat syntax highlighting
export CHEATCOLORS=true

# speed up building ruby
export RUBY_CONFIGURE_OPTS='--disable-install-rdoc --disable-install-ri'

# ruby build cache path
export RUBY_BUILD_CACHE_PATH=~/.rubies/cache

# Allow bundler to use all the cores for parallel installation
export BUNDLE_JOBS=4

# Go
export GOPATH=$HOME/Code/go
export PATH=$PATH:$GOPATH/bin

# MySQL prompt
export MYSQL_PS1='(\D) \u@\h [\d] > '

# Link Homebrew casks in `/Applications` rather than `~/Applications`
export HOMEBREW_CASK_OPTS='--appdir=/Applications'

# Always enable colored `grep` output
export GREP_OPTIONS='--color=auto'

# 10ms for key sequences
export KEYTIMEOUT=1

# chruby
if [[ -f '/usr/local/share/chruby/chruby.sh' ]]; then
  RUBIES=(~/.rubies/*)

  source '/usr/local/share/chruby/chruby.sh'
  source '/usr/local/share/chruby/auto.sh'

  [[ -f ~/.ruby-version ]] && chruby "$(cat ~/.ruby-version)"
fi

# Local config
[[ -f ~/.zshenv.local ]] && source ~/.zshenv.local
