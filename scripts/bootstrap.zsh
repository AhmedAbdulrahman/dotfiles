#!/usr/bin/env zsh

# Bootstrap script for installing applications and tools

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

cd $DOTFILES/scripts

# macOS
if [ `uname` == 'Darwin' ]; then
    . ./brew.zsh
    . ./nodejs.zsh
    cd -
# linux
elif [ `uname` == 'Darwin' ]; then
    . ./linuxbrew.zsh
    cd -
# Windows OS
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]; then
    info "Checking if Scoop is installed..."
    $DOTFILES/scripts/scoop.ps1
    cd -
fi