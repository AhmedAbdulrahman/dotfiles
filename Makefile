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

link:
	@echo "→ Setup Environment Settings"

    ifeq "$(dir)" "all"
		@echo "→ Symlinking $(DIRS) files"
		@$(foreach val, $(DIRS), sh $(DOTFILES)/$(val)/setup.sh && /usr/local/bin/stow --restow -vv --ignore ".DS_Store" --target="$(HOME)/.$(val)" --dir="$(DOTFILES)" $(val);)
    else ifeq "$(dir)" "files"
		@echo "→ Symlinking $(dir) dir"
		/usr/local/bin/stow --restow -vv --ignore ".DS_Store" --target="$(HOME)" --dir="$(DOTFILES)" $(dir)
    else
		@echo "→ Symlinking $(dir) dir"
		sh $(DOTFILES)/$(dir)/setup.sh
		/usr/local/bin/stow --restow -vv --ignore ".DS_Store" --target="$(HOME)/.$(dir)" --dir="$(DOTFILES)" $(dir)
    endif

bootstrap:
	$(SCRIPTS)/brew.zsh
	$(SCRIPTS)/nodejs.zsh

python:
	$(SCRIPTS)/python-packages.zsh