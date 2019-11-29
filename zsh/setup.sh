#!/usr/bin/env bash

# Get the dir of the current script
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SCRIPT_DIR" || return 1

echo "\\n → Creating ZSH folder in root directory..."
mkdir -p $HOME/.zsh
echo "✓ ZSH folder created successfully! \\n"

echo "→ Symlinking ~/.zshenv..."
ln -nfs "$SCRIPT_DIR/.zshenv"   "$HOME/.zshenv"
echo "✓ ~/.zshenv linked successfully! \\n"