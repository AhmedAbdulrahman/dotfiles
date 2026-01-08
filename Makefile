# use zsh
SHELL:=/bin/zsh

# Detect DOTFILES location
# Can be overridden: make DOTFILES=/custom/path <target>
# Uses ~/Projects/personal/dotfiles if it exists, otherwise ~/dotfiles
ifneq ($(wildcard $(HOME)/Projects/personal/dotfiles),)
    DOTFILES := $(HOME)/Projects/personal/dotfiles
else
    DOTFILES := $(HOME)/dotfiles
endif

SCRIPTS := $(DOTFILES)/scripts
INSTALL := $(DOTFILES)/installer.sh
dir=not_override

# Detect stow path (Homebrew on Apple Silicon vs Intel)
STOW := $(shell command -v stow 2>/dev/null || echo "/opt/homebrew/bin/stow")
ifeq ($(wildcard $(STOW)),)
    STOW := /usr/local/bin/stow
endif

# This is to symlink all files when All is selected in prompt
CANDIDATES = $(wildcard hammerspoon tmux vim zsh newsboat)
EXCLUSIONS := .DS_Store .git .gitmodules .travis.yml
DIRS   := $(filter-out $(EXCLUSIONS), $(CANDIDATES))

all: node python macos

# ┌──────────────────────────────────────────────────────────────────┐
# │ Individual symlink targets (cleaner, explicit)                   │
# └──────────────────────────────────────────────────────────────────┘

symlink-zsh:
	@echo "→ Setting up ZSH"
	@sh $(DOTFILES)/zsh/setup.sh

symlink-nvim:
	@echo "→ Setting up Neovim"
	@sh $(DOTFILES)/nvim/.install/run.sh

symlink-hammerspoon:
	@echo "→ Setting up Hammerspoon"
	@mkdir -p $(HOME)/.hammerspoon
	@sh $(DOTFILES)/hammerspoon/setup.sh
	@$(STOW) --restow -vv --ignore ".DS_Store" --ignore ".+.local" --target="$(HOME)/.hammerspoon" --dir="$(DOTFILES)" hammerspoon

symlink-tmux:
	@echo "→ Setting up Tmux"
	@mkdir -p $(HOME)/.tmux
	@[ -f $(DOTFILES)/tmux/setup.sh ] && sh $(DOTFILES)/tmux/setup.sh || true
	@$(STOW) --restow -vv --ignore ".DS_Store" --ignore ".+.local" --target="$(HOME)/.tmux" --dir="$(DOTFILES)" tmux

symlink-newsboat:
	@echo "→ Setting up Newsboat"
	@mkdir -p $(HOME)/.newsboat
	@sh $(DOTFILES)/newsboat/setup.sh
	@$(STOW) --restow -vv --ignore ".DS_Store" --ignore ".+.local" --target="$(HOME)/.newsboat" --dir="$(DOTFILES)" newsboat

symlink-files:
	@echo "→ Symlinking files to HOME"
	@$(STOW) --restow -vv --ignore ".DS_Store" --ignore ".+.local" --target="$(HOME)" --dir="$(DOTFILES)" files

# ┌──────────────────────────────────────────────────────────────────┐
# │ Symlink everything at once                                       │
# └──────────────────────────────────────────────────────────────────┘

symlink-all: symlink-zsh symlink-nvim symlink-hammerspoon symlink-tmux symlink-newsboat symlink-files
	@echo "✓ All symlinks created!"

# Legacy target for backwards compatibility
symlink:
	@echo "→ Setup Environment Settings"
ifeq "$(dir)" "all"
	@$(MAKE) symlink-all
else ifeq "$(dir)" "files"
	@$(MAKE) symlink-files
else ifeq "$(dir)" "nvim"
	@$(MAKE) symlink-nvim
else ifeq "$(dir)" "zsh"
	@$(MAKE) symlink-zsh
else
	@echo "→ Symlinking $(dir) dir"
	@$(MAKE) symlink-$(dir)
endif

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

composer:
	sh $(SCRIPTS)/composer-packages.sh

node:
	sh $(SCRIPTS)/nodejs.sh

macos:
	sh $(DOTFILES)/extras/macos/setup.sh

.PHONY: all symlink symlink-all symlink-zsh symlink-nvim symlink-hammerspoon symlink-tmux symlink-newsboat symlink-files gpg homebrew homebrew-personal homebrew-work node python macos
