#!/usr/bin/env bash
################################################################################
#  Author: Ahmed Abdulrahman
#  Email: a.kasapbashi@gmail.com
#  Created: 2018-12-30 09:25
################################################################################

# get the dir of the current script
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SCRIPT_DIR" || return 1

mkdir -p ~/.vim

ln -sf  "$SCRIPT_DIR/vimrc"             ~/.vimrc
ln -sf  "$SCRIPT_DIR/vim_plugins"       ~/.vim_plugins
ln -sf  "$SCRIPT_DIR/UltiSnips"         ~/.vim/UltiSnips

# # Check If Vundle doesn't exist, install it
[[ ! -a ~/.vim/bundle/Vundle.vim ]] && git clone --depth=1 https://github.com/VundleVim/Vundle.vim ~/.vim/bundle/Vundle.vim
