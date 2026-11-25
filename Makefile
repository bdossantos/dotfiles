OS = "$(uname)"
SHELL := /usr/bin/env bash

.DEFAULT_GOAL := help

# Ensure mise.run installs (~/.local/bin) are found in the same run, and
# keep brew-cask apps in ~/Applications before .profile is sourced
export PATH := $(HOME)/.local/bin:$(PATH)
export MISE_BREW_CASK_OPT_APPDIR ?= $(HOME)/Applications

help:
	@grep -E '^[a-zA-Z1-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN { FS = ":.*?## " }; { printf "\033[36m%-30s\033[0m %s\n", $$1, $$2 }'

install: ## Bootstrap the machine with mise
	@$(MAKE) install-mise link-mise-config
	@if [[ "$$(uname)" == 'Darwin' ]]; then \
		$(MAKE) install-homebrew; \
	fi
	@mise bootstrap --force-dotfiles

bootstrap-dry-run: link-mise-config ## Preview what `mise bootstrap` would change
	@mise bootstrap --dry-run

link-mise-config: ## Link ~/.config/mise so mise can load this repo's config
	@command -v mise >/dev/null || { echo 'CAN I HAZ MISE ?'; exit 1; }
	@mkdir -p ~/.config/mise/conf.d
	@ln -sf "$(CURDIR)/.config/mise/config.toml" ~/.config/mise/config.toml
	@for f in "$(CURDIR)"/.config/mise/conf.d/*.toml; do \
		ln -sf "$$f" ~/.config/mise/conf.d/; \
	done

install-dotfiles: link-mise-config ## Pull and deploy dotfiles with mise
	@git pull -q && git submodule update --init --recursive -q
	@mise dot apply --force --yes

install-homebrew: ## Install homebrew in /opt/homebrew (Apple Silicon)
	$(info --> Install homebrew)
	@[[ "$$(uname)" == 'Darwin' && "$$(uname -m)" == 'arm64' ]] \
		|| { echo 'Homebrew install is only supported on Apple Silicon'; exit 1; }
	@if [[ ! -x /opt/homebrew/bin/brew ]]; then \
		sudo mkdir -p /opt/homebrew && sudo chown -R "$$USER" /opt/homebrew; \
		curl -fsSL https://github.com/Homebrew/brew/tarball/master \
			| tar xz --strip 1 -C /opt/homebrew; \
	fi

install-mise: ## Install mise, the polyglot tool manager
	$(info --> Install mise)
	@command -v mise >/dev/null || curl -fsSL https://mise.run | sh

install-packages: ## Install brew formulae, casks and tools with mise
	$(info --> Install packages)
	@command -v mise >/dev/null || { echo 'CAN I HAZ MISE ?'; exit 1; }
	@mise bootstrap packages apply
	@mise install

pre-commit: ## Run pre-commit tests
	$(info --> Run pre-commit)
	@pre-commit run --all-files

test: ## Run tests suite
	@$(MAKE) pre-commit

uninstall: uninstall-dotfiles ## Uninstall all the things

uninstall-dotfiles: ## Uninstall dotfiles
	@mise dot unapply

migrate-from-stow: ## One-off: remove the symlinks created by GNU Stow
	@command -v stow >/dev/null || { echo 'CAN I HAZ STOW ?'; exit 1; }
	@stow -D . -t "$(HOME)" -v \
		--ignore='.github' \
		--ignore='README.md' \
		--ignore='LICENCE' \
		--ignore='Makefile'
