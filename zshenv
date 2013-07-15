# default editor
export EDITOR='/usr/bin/vim'
export VISUAL='/usr/bin/vim'

# speed up building ruby
export RUBY_CONFIGURE_OPTS='--disable-install-rdoc --disable-install-ri'

# ruby build cache path
export RUBY_BUILD_CACHE_PATH='~/.rubies/cache'

# boxen
[ -f /opt/boxen/env.sh ] && source /opt/boxen/env.sh
