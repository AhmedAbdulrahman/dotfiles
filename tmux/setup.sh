#!/usr/bin/env bash

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SCRIPT_DIR" || return 1

mkdir -p ~/.tmux
mkdir -p ~/.tmux/cache
# mkdir -p ~/.tmux/config

ln -sf "$SCRIPT_DIR/tmux.conf"  ~/.tmux.conf
# ln -sf "$SCRIPT_DIR/tmux/config/"  ~/.tmux/config/

[[ $(uname) == *Darwin* ]] && ln -sf "$SCRIPT_DIR/tmux_osx.conf" ~/.tmux_osx.conf

for dir in $(ls -d "$SCRIPT_DIR"/*/); do ln -s "$SCRIPT_DIR/$(basename "$dir")" "$HOME/.tmux/$(basename "$dir")"; done && ls -al "$HOME/.tmux/"
# for dir in "$SCRIPT_DIR"/*/; do
#   ln -sf "$SCRIPT_DIR/$(basename "$dir")" "$HOME/.tmux/$(basename "$dir")"
# done