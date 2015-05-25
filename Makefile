SHELL := /usr/bin/env bash
PREZTO := ~/.zprezto

install: install-dotfiles

install-dotfiles:
	@[[ -d $(PREZTO) ]] || \
		git clone -q --depth 1 --recursive \
			https://github.com/sorin-ionescu/prezto.git $(PREZTO)
	@git pull -q && git submodule update --init --recursive -q
	@which stow >/dev/null || { echo 'CAN I HAZ STOW ?'; exit 1; }
	@stow -S . -t "$(HOME)" -v \
		--ignore='README.md' \
		--ignore='LICENCE' \
		--ignore='Makefile'

uninstall: uninstall-dotfiles

uninstall-dotfiles:
	@stow -D . -t "$(HOME)" -v \
		--ignore='README.md' \
		--ignore='LICENCE' \
		--ignore='Makefile'
