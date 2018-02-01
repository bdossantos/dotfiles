BASH_IT := ~/.bash_it
OS = "$(uname)"
SHELL := /usr/bin/env bash

.DEFAULT_GOAL := help

help:
	@grep -E '^[a-zA-Z1-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN { FS = ":.*?## " }; { printf "\033[36m%-30s\033[0m %s\n", $$1, $$2 }'

install: ## Install all the things
	@make install-dotfiles \
		install-bash-it \
		install-base16 \
		install-tpm \
		install-vundle
	@[[ $OS == 'Darwin' ]] \
		&& make install-homebrew run-brew

install-dotfiles: ## Pull and Install dotfiles
	@git pull -q && git submodule update --init --recursive -q
	@mkdir -m 0700 -p ~/.ssh
	@which stow >/dev/null || { echo 'CAN I HAZ STOW ?'; exit 1; }
	@stow -S . -t "$(HOME)" -v \
		--ignore='README.md' \
		--ignore='LICENCE' \
		--ignore='Makefile' \
		--override='.bashrc' \
		--override='.profile' \
		--override='.bash_profile'

install-bash-it: ## Clone and pull bash-it, a community Bash framework
	$(info --> Install bash-it)
	@[[ -d $(BASH_IT) ]] || \
		git clone -q --depth 1 --recursive \
			https://github.com/Bash-it/bash-it $(BASH_IT)
	$(info --> Update bash-it + submodules)
	@pushd $(BASH_IT) &>/dev/null \
		&& git pull --quiet \
		&& git submodule update --init --recursive --quiet \
		&& popd &>/dev/null
	@source $(BASH_IT)/lib/helpers.bash \
		&& source $(BASH_IT)/lib/composure.bash \
		&& _enable-alias \
			ag \
			general \
			curl \
			docker \
			general \
			git \
			osx \
			systemd \
			tmux \
		&& _enable-completion \
			bash-it \
			git \
			docker \
			docker-compose \
			export \
			system \
			ssh \
			tmux \
			makefile \
		&& _enable-plugin \
		  alias-completion \
		  aws \
		  base \
		  docker \
		  edit-mode-vi \
		  extract \
		  git \
		  go \
		  history \
		  jekyll \
		  osx \
		  osx-timemachine \
		  proxy \
		  sshagent \
		  xterm

install-homebrew: ## Install homebrew, the missing package manager for OS X
	$(info --> Install homebrew)
	@mkdir -m 0700 -p ~/.homebrew
	@[[ -f ~/.homebrew/bin/brew ]] \
		|| curl -L https://github.com/Homebrew/brew/tarball/master \
		| tar xz --strip 1 -C ~/.homebrew

install-base16: ## Install base16, the color schemes for hackers
	$(info --> Install base16)
	@[[ -d ~/.base16-shell ]] \
		|| git clone https://github.com/chriskempson/base16-shell ~/.base16-shell
	@[[ -d ~/.base16-iterm2 ]] \
		|| git clone https://github.com/chriskempson/base16-iterm2 ~/.base16-iterm2
	$(info --> Update base16)
	@pushd ~/.base16-shell &>/dev/null \
		&& git pull --quiet \
		&& popd &>/dev/null
	@pushd ~/.base16-iterm2 &>/dev/null \
		&& git pull --quiet \
		&& popd &>/dev/null

install-tpm: ## Install tpm, the Tmux Plugin Manager
	$(info --> Install tpm)
	@mkdir -p ~/.tmux/plugins
	@[[ -d ~/.tmux/plugins/tpm ]] \
		|| git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

install-vundle: ## Install Vundle, the plug-in manager for Vim
	$(info --> Install Vundle)
	@mkdir -p ~/.vim/bundle/ ~/.vimswap ~/.vimundo ~/.tmp
	@[[ -d ~/.vim/bundle/Vundle.vim ]] \
		|| git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	@vim +PluginInstall +qall &>/dev/null

run-brew: ## Run ./.brew
	@bash -x .brew

uninstall: uninstall-dotfiles ## Uninstall all the things

uninstall-dotfiles: ## Uninstall dotfiles
	@stow -D . -t "$(HOME)" -v \
		--ignore='README.md' \
		--ignore='LICENCE' \
		--ignore='Makefile'
