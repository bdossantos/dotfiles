# default editor
export EDITOR=$(which vim)
export VISUAL=$(which vim)

# pager
export PAGER='less'
export LESS='-R'

# homebrew
export HOMEBREW_PREFIX=${HOMEBREW_PREFIX:='/opt/boxen/homebrew'}

# chruby
if [ -d "${HOMEBREW_PREFIX}/share/chruby" ]; then
  RUBIES=(~/.rubies/*)

  source "${HOMEBREW_PREFIX}/share/chruby/chruby.sh"
  source "${HOMEBREW_PREFIX}/share/chruby/auto.sh"

  [ -f ~/.ruby-version ] && chruby $(cat ~/.ruby-version)
fi

# speed up building ruby
export RUBY_CONFIGURE_OPTS='--disable-install-rdoc --disable-install-ri'

# ruby build cache path
export RUBY_BUILD_CACHE_PATH='~/.rubies/cache'

# Allow bundler to use all the cores for parallel installation
export BUNDLE_JOBS=4

# Go
export GOPATH=$HOME/Code/go
export PATH=$PATH:$GOPATH/bin

# zsh syntax highlighting
highlighters="${HOMEBREW_PREFIX}/share/zsh-syntax-highlighting/highlighters"
[ -d $highlighters ] && export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=$highlighters
