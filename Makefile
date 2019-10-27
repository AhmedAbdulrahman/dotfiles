# use zsh
SHELL:=/bin/zsh

# This can be overriden by doing `make DOTFILES=some/path <task>`
DOTFILES="$(HOME)/dotfiles"
SCRIPTS="$(DOTFILES)/scripts"
INSTALL="$(DOTFILES)/installer.sh"
file=not_override

link:
	sh $(DOTFILES)/$(file)/setup.sh

	@printf "Symlinking files/folders...\\n"
	/usr/local/bin/stow --restow -vv --ignore ".DS_Store" --target="$(HOME)/.$(file)" --dir="$(DOTFILES)" $(file)
	
unlink:
	@printf "Removing Symlink files/folders...\\n"
	stow --delete -vv --ignore ".DS_Store" --target="$(HOME)/.$(file)" --dir="$(DOTFILES)" $(file)