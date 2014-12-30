# default editor
VIM=$(which vim)
export EDITOR=$VIM
export VISUAL=$VIM

# history
export HISTSIZE=32768
export HISTFILESIZE=$HISTSIZE
export HISTCONTROL=ignoredups
export HISTIGNORE='ls:cd:cd -:pwd:exit:date:* --help'

# pager
export PAGER='less'
export LESS='-R'

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

# Local config
[[ -f ~/.zshenv.local ]] && source ~/.zshenv.local
