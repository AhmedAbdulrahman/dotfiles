#!/usr/bin/env bash
################################################################################
#  Author: Ahmed Abdulrahman
#  Email: a.kasapbashi@gmail.com
#  Created: 2019-10-12 22:20
################################################################################

# get the dir of the current script
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SCRIPT_DIR" || return 1

echo "\\n → Creating ~/.config folder in root directory..."
mkdir -p $HOME/.config
echo "✓ ~/.config folder created successfully! \\n"

echo "→ Symlinking ~/.gitconfig & ~/.gitconfig.local ..."
ln -nfs "$SCRIPT_DIR/.gitconfig"   "$HOME/.gitconfig"
ln -nfs "$SCRIPT_DIR/.gitconfig.local"   "$HOME/.gitconfig.local"
echo "✓ git files linked successfully! \\n"

echo "→ Symlinking ~/.pyrc.py ..."
ln -nfs "$SCRIPT_DIR/.pyrc.py"   "$HOME/.pyrc.py"
echo "✓ pyrc file linked successfully! \\n"

echo "→ Symlinking taskwarrior files..."
stow --restow -vv --target="$HOME" --dir=$SCRIPT_DIR taskwarrior
echo "✓ taskwarrior files linked successfully! \\n"

echo "→ Creating ~/.timewarrior folder in root directory..."
mkdir -p $HOME/.timewarrior
echo "✓ ~/.timewarrior files linked successfully! \\n"

echo "→ Symlinking ~/.timewarrior files..."
stow --restow -vv --target="$HOME/.timewarrior" --dir=$SCRIPT_DIR timewarrior
echo "✓ ~/.timewarrior/timewarrior.cfg files linked successfully! \\n"

echo "→ Symlinking ~/.ripgreprc..."
ln -nfs "$SCRIPT_DIR/.ripgreprc"   "$HOME/.ripgreprc"
echo "✓ ripgreprc file linked successfully! \\n"
