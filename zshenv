# default editor
export EDITOR='/usr/bin/vim'
export VISUAL='/usr/bin/vim'

# speed up building ruby
export RUBY_CONFIGURE_OPTS='--disable-install-rdoc --disable-install-ri'

# ruby build cache path
export RUBY_BUILD_CACHE_PATH='~/.rubies/cache'

# zsh syntax highlighting
highlighters=/opt/boxen/homebrew/share/zsh-syntax-highlighting/highlighters
[ -d $highlighters ] && export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=$highlighters
