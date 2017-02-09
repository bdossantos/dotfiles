SHELL := /usr/bin/env bash
PREZTO := ~/.zprezto

.DEFAULT_GOAL := help

help:
	@grep -E '^[a-zA-Z1-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN { FS = ":.*?## " }; { printf "\033[36m%-30s\033[0m %s\n", $$1, $$2 }'

install: ## Install all the things
	@make install-dotfiles \
		install-prezto \
		install-homebrew \
		install-base16 \
		install-tpm \
		install-vundle

install-dotfiles: ## Pull and Install dotfiles
	@git pull -q && git submodule update --init --recursive -q
	@mkdir -m 0700 -p ~/.ssh
	@which stow >/dev/null || { echo 'CAN I HAZ STOW ?'; exit 1; }
	@stow -S . -t "$(HOME)" -v \
		--ignore='README.md' \
		--ignore='LICENCE' \
		--ignore='Makefile'

install-prezto: ## Clone and pull Prezto, the configuration framework for Zsh
	$(info --> Install prezto)
	@[[ -d $(PREZTO) ]] || \
		git clone -q --depth 1 --recursive \
			https://github.com/sorin-ionescu/prezto.git $(PREZTO)
	$(info --> Update prezto + submodules)
	@pushd $(PREZTO) &>/dev/null \
		&& git pull --quiet \
		&& git submodule update --init --recursive --quiet \
		&& popd &>/dev/null

install-homebrew: ## Install homebrew, the missing package manager for OS X
	$(info --> Install homebrew)
	@mkdir -p ~/.homebrew
	@test -f ~/.homebrew/bin/brew &>/dev/null \
		|| curl -L https://github.com/Homebrew/brew/tarball/master \
		| tar xz --strip 1 -C ~/.homebrew
	@./.brew

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

install-tmuxline: ## Install tmuxline, a Simple Tmux statusline generator
	$(info --> Create tmuxline snapshot)
	@vim +Tmuxline +"TmuxlineSnapshot! ~/.tmuxline.conf" +qall

uninstall: uninstall-dotfiles ## Uninstall all the things

uninstall-dotfiles: ## Uninstall dotfiles
	@stow -D . -t "$(HOME)" -v \
		--ignore='README.md' \
		--ignore='LICENCE' \
		--ignore='Makefile'
