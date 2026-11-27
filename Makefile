OS = "$(uname)"
SHELL := /usr/bin/env bash

.DEFAULT_GOAL := help

# Ensure mise.run installs (~/.local/bin) are found in the same run, and
# keep brew-cask apps in ~/Applications, recorded in a user-owned prefix
# (the default, /opt/homebrew, needs sudo), before .profile is sourced
export PATH := $(HOME)/.local/bin:$(PATH)
export MISE_BREW_CASK_OPT_APPDIR ?= $(HOME)/Applications
export MISE_SYSTEM_BREW_PREFIX ?= $(HOME)/.local/share/mise-casks

help:
	@grep -E '^[a-zA-Z1-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN { FS = ":.*?## " }; { printf "\033[36m%-30s\033[0m %s\n", $$1, $$2 }'

install: ## Bootstrap the machine with mise
	@$(MAKE) install-mise link-mise-config
	@mise install --locked --dry-run
	@MISE_LOCKED=1 mise bootstrap --force-dotfiles

bootstrap-dry-run: link-mise-config ## Preview what `mise bootstrap` would change
	@mise bootstrap --dry-run

macos-status: link-mise-config ## Show macOS defaults drift (exit 1 if anything differs)
	@mise bootstrap macos defaults status --missing

macos-apply: link-mise-config ## Apply macOS defaults and restart Dock/Finder/SystemUIServer
	@mise bootstrap macos defaults apply
	@killall Dock Finder SystemUIServer 2>/dev/null || true

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

install-mise: ## Install mise, the polyglot tool manager
	$(info --> Install mise)
	@set -eu; if ! command -v mise >/dev/null; then \
		case "$$(uname -s)-$$(uname -m)" in \
			Darwin-arm64) platform=macos-arm64; \
				sha=76ff289e5ef2ffdeec54ad75275795d3e05699cb74b9f2f656652d3d1ddd7d11 ;; \
			Darwin-x86_64) platform=macos-x64; \
				sha=4ad598c502813f63cb9a82518f60e66f25d2c715e5bd5b949ca66323e94bd154 ;; \
			Linux-x86_64) platform=linux-x64-musl; \
				sha=86a5c3d8cf3d62b45a10ddd6afe8225bada9423e517ec8df7d589aa7d02c171d ;; \
			Linux-aarch64) platform=linux-arm64-musl; \
				sha=bf73525892d7942b881b885867bb028cab98ed528356c4490364eb1001ef9deb ;; \
			*) echo 'Unsupported platform for pinned mise release' >&2; exit 1 ;; \
		esac; \
		tmp="$$(mktemp -d)"; trap 'rm -rf "$$tmp"' EXIT; \
		archive="mise-v2026.11.14-$$platform.tar.gz"; \
		curl -fsSL "https://github.com/jdx/mise/releases/download/v2026.11.14/$$archive" \
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

install-packages: ## Install apps, fonts and tools with mise
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

test-mise: link-mise-config ## Validate the mise config and lockfile (no changes applied)
	$(info --> Validate mise config)
	@mise install --locked --dry-run
	@mise bootstrap --dry-run

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
