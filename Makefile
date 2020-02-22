# use zsh
SHELL:=/bin/zsh

# This can be overriden by doing `make DOTFILES=some/path <task>`
DOTFILES="$(HOME)/dotfiles"
SCRIPTS="$(DOTFILES)/scripts"
INSTALL="$(DOTFILES)/installer.sh"
dir=not_override

# This is to symlink all files when All is selected in prompt
CANDIDATES = $(wildcard hammerspoon tmux vim zsh newsboat)
EXCLUSIONS := .DS_Store .git .gitmodules .travis.yml
DIRS   := $(filter-out $(EXCLUSIONS), $(CANDIDATES))

all: node python macos

symlink:
	@echo "→ Setup Environment Settings"
	@echo "→ Symlinking $(DIRS) files"

	@$(foreach val, $(DIRS), sh $(DOTFILES)/$(val)/setup.sh && stow --restow -vv --ignore ".DS_Store" --ignore ".+.local" --target="$(HOME)/.$(val)" --dir="$(DOTFILES)" $(val);)
	stow --restow -vv --ignore ".DS_Store" --ignore ".+.local" --target="$(HOME)" --dir="$(DOTFILES)" files

gpg: symlink
	# Fix gpg folder/file permissions after symlinking
	chmod 700 $(HOME)/.gnupg && chmod 600 $(HOME)/.gnupg/*

homebrew:
	sh $(SCRIPTS)/brew.sh

homebrew-personal: homebrew
	sh $(SCRIPTS)/brew-personal.sh

homebrew-work: homebrew
	sh $(SCRIPTS)/brew-work.sh

python:
	sh $(SCRIPTS)/python-packages.sh

node:
	sh $(SCRIPTS)/nodejs.sh

macos:
	sh $(DOTFILES)/extras/macos/setup.sh

.PHONY: all symlink homebrew homebrew-personal homebrew-work node python macos