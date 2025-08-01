OS = "$(uname)"
SHELL := /usr/bin/env bash

.DEFAULT_GOAL := help

help:
	@grep -E '^[a-zA-Z1-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN { FS = ":.*?## " }; { printf "\033[36m%-30s\033[0m %s\n", $$1, $$2 }'

install: ## Install all the things
	@make install-dotfiles \
		install-vundle \
		install-nvim-deps \
	@[[ $OS == 'Darwin' ]] \
		&& make install-homebrew run-brew

install-dotfiles: ## Pull and Install dotfiles
	@git pull -q && git submodule update --init --recursive -q
	@mkdir -m 0700 -p ~/.ssh && touch ~/.ssh/allowed_signers
	@command -v stow >/dev/null || { echo 'CAN I HAZ STOW ?'; exit 1; }
	@stow -S . -t "$(HOME)" -v \
		--ignore='.pre-commit-config.yaml' \
		--ignore='.travis.yml' \
		--ignore='requirements.txt' \
		--ignore='README.md' \
		--ignore='LICENCE' \
		--ignore='Makefile' \
		--override='.bashrc' \
		--override='.profile' \
		--override='.bash_profile'

install-homebrew: ## Install homebrew, the missing package manager for OS X
	$(info --> Install homebrew)
	@mkdir -m 0700 -p ~/.homebrew
	@if [[ ! -f ~/.homebrew/bin/brew ]]; then \
		curl -L https://github.com/Homebrew/brew/tarball/master \
			| tar xz --strip 1 -C ~/.homebrew; \
	fi

install-vundle: ## Install Vundle, the plug-in manager for Vim
	$(info --> Install Vundle)
	@mkdir -p ~/.vim/bundle/ ~/.vimswap ~/.vimundo ~/.tmp
	@[[ -d ~/.vim/bundle/Vundle.vim ]] \
		|| git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	@vim +PluginInstall +qall &>/dev/null

install-nvim-deps: ## Install/setup Neovim dependencies
	$(info --> Setup Neovim directories)
	@mkdir -p ~/.vimswap ~/.vimundo ~/.tmp

install-alacritty-theme:
	$(info --> Install Alacritty themes)
	@[[ -d ~/.config/alacritty/themes ]] \
		|| git clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes
	@pushd ~/.config/alacritty/themes && git pull && popd

pre-commit: ## Run pre-commit tests
	$(info --> Run pre-commit)
	@pre-commit run --all-files

run-brew: ## Run ./.brew
	@bash -x .brew

test: ## Run tests suite
	@$(MAKE) pre-commit

uninstall: uninstall-dotfiles ## Uninstall all the things

uninstall-dotfiles: ## Uninstall dotfiles
	@stow -D . -t "$(HOME)" -v \
		--ignore='.github' \
		--ignore='README.md' \
		--ignore='LICENCE' \
		--ignore='Makefile'
