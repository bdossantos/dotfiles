# default editor
export EDITOR=$(which vim)
export VISUAL=$(which vim)

# pager
export PAGER='less'
export LESS='-R'

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

# Link Homebrew casks in `/Applications` rather than `~/Applications`
export HOMEBREW_CASK_OPTS='--appdir=/Applications'

# Local config
[[ -f ~/.zshenv.local ]] && source ~/.zshenv.local
