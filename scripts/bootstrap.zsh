#!/usr/bin/env zsh

# Bootstrap script for installing applications and tools

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

export ZSH_DOTFILES=${ZSH_DOTFILES:="$HOME/.zsh-dotfiles"}

cd $ZSH_DOTFILES/scripts
. ./brew.zsh
. ./nodejs.zsh
cd -