#!/usr/bin/env bash

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SCRIPT_DIR" || return 1

echo "→ Creating TMUX folder in root directory \\n"
mkdir -p $HOME/.tmux

echo "→ Symlinking ~/.tmux.conf \\n"
ln -nfs "$SCRIPT_DIR/.tmux.conf"         "$HOME/.tmux.conf"

if [[ $(uname) == *Darwin* ]]; then
    echo "→ Symlinking ~/.tmux_osx.conf \\n"
    ln -nfs "$SCRIPT_DIR/.tmux_osx.conf" "$HOME/.tmux_osx.conf"
fi

echo "Copying Cache \\n"
mkdir -p $HOME/.tmux/cache
cp -a "$SCRIPT_DIR/cache/." $HOME/.tmux/cache/