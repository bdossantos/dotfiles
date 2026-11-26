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
	@mise install --locked --dry-run
	@if [[ "$$(uname)" == 'Darwin' ]]; then \
		$(MAKE) install-homebrew; \
	fi
	@MISE_LOCKED=1 mise bootstrap --force-dotfiles

bootstrap-dry-run: link-mise-config ## Preview what `mise bootstrap` would change
	@mise bootstrap --dry-run

link-mise-config: ## Link ~/.config/mise so mise can load this repo's config
	@command -v mise >/dev/null || { echo 'CAN I HAZ MISE ?'; exit 1; }
	@mkdir -p ~/.config/mise/conf.d
	@ln -sf "$(CURDIR)/.config/mise/config.toml" ~/.config/mise/config.toml
	@if [[ -f "$(CURDIR)/.config/mise/mise.lock" ]]; then \
		ln -sf "$(CURDIR)/.config/mise/mise.lock" ~/.config/mise/mise.lock; \
	fi
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
	@set -eu; if [[ ! -x /opt/homebrew/bin/brew ]]; then \
		tmp="$$(mktemp -d)"; trap 'rm -rf "$$tmp"' EXIT; \
		commit=bc63375ac3a4d6debb1ceb441ae6e22854f0909a; \
		sha=c1dfbc7074f4a1c9799cf5c228df4def0d2de2645fbe1e3402810e0410fe161c; \
		curl -fsSL "https://codeload.github.com/Homebrew/brew/tar.gz/$$commit" \
			-o "$$tmp/brew.tar.gz"; \
		if command -v shasum >/dev/null; then \
			printf '%s  %s\n' "$$sha" "$$tmp/brew.tar.gz" | shasum -a 256 -c; \
		else \
			printf '%s  %s\n' "$$sha" "$$tmp/brew.tar.gz" | sha256sum -c; \
		fi; \
		if [[ ! -d /opt/homebrew ]]; then \
			sudo mkdir -p /opt/homebrew; \
			sudo chown "$$(id -un)" /opt/homebrew; \
		fi; \
		tar xzf "$$tmp/brew.tar.gz" --strip-components 1 -C /opt/homebrew; \
	fi

install-mise: ## Install mise, the polyglot tool manager
	$(info --> Install mise)
	@set -eu; if ! command -v mise >/dev/null; then \
		case "$$(uname -s)-$$(uname -m)" in \
			Darwin-arm64) platform=macos-arm64; \
				sha=7a7f9342559cc4ca670054337ecf497e69d832a05f66e531628381dc92b88f48 ;; \
			Darwin-x86_64) platform=macos-x64; \
				sha=355729a12f3d3b23059ad372855a82f5c8720d1d3fb63dbe5068bc9b4952201c ;; \
			Linux-x86_64) platform=linux-x64; \
				sha=d2d5a46f507bba772686e2c8f2316b3a4439dac49a37a30db5c0e7bb077c5431 ;; \
			Linux-aarch64) platform=linux-arm64; \
				sha=b36da3c4892380325d44dee3678ba618de191254d8a4aed8011ee66b28a6cbd7 ;; \
			*) echo 'Unsupported platform for pinned mise release' >&2; exit 1 ;; \
		esac; \
		tmp="$$(mktemp -d)"; trap 'rm -rf "$$tmp"' EXIT; \
		archive="mise-v2026.11.8-$$platform.tar.gz"; \
		curl -fsSL "https://github.com/jdx/mise/releases/download/v2026.11.8/$$archive" \
			-o "$$tmp/mise.tar.gz"; \
		if command -v shasum >/dev/null; then \
			printf '%s  %s\n' "$$sha" "$$tmp/mise.tar.gz" | shasum -a 256 -c; \
		else \
			printf '%s  %s\n' "$$sha" "$$tmp/mise.tar.gz" | sha256sum -c; \
		fi; \
		tar xzf "$$tmp/mise.tar.gz" -C "$$tmp" mise/bin/mise; \
		mkdir -p "$(HOME)/.local/bin"; \
		install -m 755 "$$tmp/mise/bin/mise" "$(HOME)/.local/bin/mise"; \
	fi

install-packages: ## Install brew formulae, casks and tools with mise
	$(info --> Install packages)
	@command -v mise >/dev/null || { echo 'CAN I HAZ MISE ?'; exit 1; }
	@mise install --locked --dry-run
	@mise bootstrap packages apply
	@mise install --locked

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
