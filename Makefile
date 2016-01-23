SHELL := /usr/bin/env bash
PREZTO := ~/.zprezto

install: install-dotfiles \
	install-prezto \
	install-homebrew \
	install-base16 \
	install-tpm \
	install-vundle \
	install-tmuxline

install-dotfiles:
	@git pull -q && git submodule update --init --recursive -q
	@which stow >/dev/null || { echo 'CAN I HAZ STOW ?'; exit 1; }
	@stow -S . -t "$(HOME)" -v \
		--ignore='README.md' \
		--ignore='LICENCE' \
		--ignore='Makefile'

install-prezto:
	$(info --> Install prezto)
	@[[ -d $(PREZTO) ]] || \
		git clone -q --depth 1 --recursive \
			https://github.com/sorin-ionescu/prezto.git $(PREZTO)
	$(info --> Update prezto + submodules)
	@pushd $(PREZTO) &>/dev/null \
		&& git pull --quiet \
		&& git submodule update --init --recursive --quiet \
		&& popd &>/dev/null

install-homebrew:
	$(info --> Install homebrew)
	@which brew &>/dev/null \
		|| ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	@./.brew

install-base16:
	$(info --> Install base16)
	@[[ -d ~/.base16-shell ]] \
		|| git clone https://github.com/chriskempson/base16-shell ~/.base16-shell
	@[[ -d ~/.base16-iterm2 ]] \
		|| git clone https://github.com/chriskempson/base16-iterm2 ~/.base16-iterm2

install-tpm:
	$(info --> Install tpm)
	@mkdir -p ~/.tmux/plugins
	@[[ -d ~/.tmux/plugins/tpm ]] \
		|| git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

install-vundle:
	$(info --> Install Vundle)
	@mkdir -p ~/.vim/bundle/ ~/.vimswap ~/.vimundo ~/.tmp
	@[[ -d ~/.vim/bundle/Vundle.vim ]] \
		|| git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	@vim +PluginInstall +qall &>/dev/null

install-tmuxline:
	$(info --> Create tmuxline snapshot)
	@vim +Tmuxline +"TmuxlineSnapshot! ~/.tmuxline.conf" +qall

uninstall: uninstall-dotfiles

uninstall-dotfiles:
	@stow -D . -t "$(HOME)" -v \
		--ignore='README.md' \
		--ignore='LICENCE' \
		--ignore='Makefile'
