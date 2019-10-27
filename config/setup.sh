#!/usr/bin/env bash
################################################################################
#  Author: Ahmed Abdulrahman
#  Email: a.kasapbashi@gmail.com
#  Created: 2019-10-12 22:20
################################################################################

# get the dir of the current script
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SCRIPT_DIR" || return 1

echo "→ Creating ~/.config folder..\\n"
mkdir -p $HOME/.config

echo "⏳Symlink .gitconfig, .gitconfig.local, .gitignore files"
stow --restow -vv --target="$HOME" --dir=$SCRIPT_DIR git

echo "⏳Symlink taskwarrior config"
stow --restow -vv --target="$HOME" --dir=$SCRIPT_DIR taskwarrior

echo "→ Creating timewarrior folder...\\n"
mkdir -p $HOME/.timewarrior

echo "⏳Symlink timewarrior config"
stow --restow -vv --target="$HOME/.timewarrior" --dir=$SCRIPT_DIR timewarrior