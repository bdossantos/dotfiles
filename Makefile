OS = "$(uname)"
SHELL := /usr/bin/env bash
SYSTEM := $(shell uname -m)-$(shell uname -s | tr '[:upper:]' '[:lower:]')

# Map uname output to Nix system identifiers
ifeq ($(SYSTEM),arm64-darwin)
  NIX_SYSTEM := aarch64-darwin
else ifeq ($(SYSTEM),x86_64-darwin)
  NIX_SYSTEM := x86_64-darwin
else ifeq ($(SYSTEM),x86_64-linux)
  NIX_SYSTEM := x86_64-linux
else ifeq ($(SYSTEM),aarch64-linux)
  NIX_SYSTEM := aarch64-linux
else
  NIX_SYSTEM := x86_64-linux
endif

.DEFAULT_GOAL := help

help:
	@grep -E '^[a-zA-Z1-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN { FS = ":.*?## " }; { printf "\033[36m%-30s\033[0m %s\n", $$1, $$2 }'

install: ## Install all the things
	@make install-dotfiles \
		install-vundle \
		install-nvim-deps
	@if [[ $OS == 'Darwin' ]]; then \
		make run-darwin; \
	else \
		make run-nix; \
	fi

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
		--ignore='flake.nix' \
		--ignore='flake.lock' \
		--ignore='home.nix' \
		--ignore='darwin.nix' \
		--override='.bashrc' \
		--override='.profile' \
		--override='.bash_profile'

install-vundle: ## Install Vundle, the plug-in manager for Vim
	$(info --> Install Vundle)
	@mkdir -p ~/.vim/bundle/ ~/.vimswap ~/.vimundo ~/.tmp
	@[[ -d ~/.vim/bundle/Vundle.vim ]] \
		|| git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	@vim +PluginInstall +qall &>/dev/null

install-nvim-deps: ## Install/setup Neovim dependencies
	$(info --> Setup Neovim directories)
	@mkdir -p ~/.vimswap ~/.vimundo ~/.tmp

install-rubies: ## Install Ruby versions via ruby-install
	$(info --> Install Ruby versions)
	@mkdir -p ~/.rubies
	@for ruby in 3.4.1 3.3.6 3.2.6; do \
		if [[ ! -f "$$HOME/.rubies/ruby-$$ruby/bin/ruby" ]]; then \
			ruby-install ruby "$$ruby"; \
		fi; \
	done

pre-commit: ## Run pre-commit tests
	$(info --> Run pre-commit)
	@pre-commit run --all-files

run-darwin: ## Apply nix-darwin configuration (macOS — includes home-manager + Homebrew casks)
	$(info --> Apply nix-darwin configuration for $(NIX_SYSTEM))
	@command -v darwin-rebuild >/dev/null && { \
		darwin-rebuild switch --flake '.#$(NIX_SYSTEM)'; \
	} || { \
		echo 'Bootstrapping nix-darwin for the first time...'; \
		nix run nix-darwin -- switch --flake '.#$(NIX_SYSTEM)'; \
	}

run-nix: ## Apply Nix home-manager configuration (Linux)
	$(info --> Apply home-manager configuration for $(NIX_SYSTEM))
	@command -v home-manager >/dev/null || { \
		echo 'home-manager not found. Install Nix and home-manager first:'; \
		echo '  curl --proto "=https" --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install'; \
		echo '  nix run home-manager -- switch --flake .#$(NIX_SYSTEM)'; \
		exit 1; \
	}
	@home-manager switch --flake '.#$(NIX_SYSTEM)'

test: ## Run tests suite
	@$(MAKE) pre-commit

uninstall: uninstall-dotfiles ## Uninstall all the things

uninstall-dotfiles: ## Uninstall dotfiles
	@stow -D . -t "$(HOME)" -v \
		--ignore='.github' \
		--ignore='README.md' \
		--ignore='LICENCE' \
		--ignore='Makefile' \
		--ignore='flake.nix' \
		--ignore='flake.lock' \
		--ignore='home.nix' \
		--ignore='darwin.nix'
