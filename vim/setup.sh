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
cp -r   "$SCRIPT_DIR/cache"             ~/.vim/cache

for dir in "$SCRIPT_DIR"/*/; do
  if [ ! $(basename "$dir") == "cache" ] ; then
    ln -sf "$SCRIPT_DIR/$(basename "$dir")" "$HOME/.vim/$(basename "$dir")"
  fi
  echo "$SCRIPT_DIR/$(basename "$dir")" "$HOME/.vim/$(basename "$dir")"
done