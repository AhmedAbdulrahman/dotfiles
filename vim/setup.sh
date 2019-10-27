#!/usr/bin/env bash
################################################################################
#  Author: Ahmed Abdulrahman
#  Email: a.kasapbashi@gmail.com
#  Created: 2018-12-30 09:25
################################################################################

# get the dir of the current script
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SCRIPT_DIR" || return 1

echo "Create some required folders...\\n"
mkdir -p $HOME/.vim
mkdir -p $HOME/.config/nvim

echo "Copying init.vim file -> ~/.config/nvim \\n"
cp "$SCRIPT_DIR/init.vim" $HOME/.config/nvim/init.vim

echo "Create COC directory & Symlink extensions \\n"
mkdir -p $HOME/.config/coc
# stow --restow -vv --target="$HOME/.config/coc" --dir=$SCRIPT_DIR coc
cp -a "$SCRIPT_DIR/snippets/." $HOME/.config/coc/ultisnips/

echo "Copying Cache \\n"
mkdir -p $HOME/.vim/cache
cp -a "$SCRIPT_DIR/cache/." $HOME/.vim/cache/