#!/usr/bin/env bash

# Get the dir of the current script
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SCRIPT_DIR" || return 1

echo "→ Creating ZSH folder in root directory \\n"
mkdir -p $HOME/.zsh

echo "→ Symlinking ~/.zshenv \\n"
ln -nfs "$SCRIPT_DIR/.zshenv"         "$HOME/.zshenv"