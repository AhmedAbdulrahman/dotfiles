#!/usr/bin/env bash

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SCRIPT_DIR" || return 1

echo "\\n → Creating TMUX folder in root directory..."
mkdir -p $HOME/.tmux
echo "✓ TMUX folder created successfully!\\n"

echo "→ Symlinking ~/.tmux.conf..."
ln -nfs "$SCRIPT_DIR/.tmux.conf"   "$HOME/.tmux.conf"
echo "✓ ~/.tmux.conf linked successfully! \\n"

if [[ $(uname) == *Darwin* ]]; then
    echo "→ Symlinking ~/.tmux_osx.conf..."
    ln -nfs "$SCRIPT_DIR/.tmux_osx.conf" "$HOME/.tmux_osx.conf"
    echo "✓ ~/.tmux_osx.conf linked successfully! \\n"
fi

echo "→ Creating TMUX cache folder..."
mkdir -p $HOME/.tmux/cache
echo "✓ TMUX folder created successfully!\\n"

echo "→ Copying TMUX cache folders..."
cp -a "$SCRIPT_DIR/cache/." $HOME/.tmux/cache/
echo "✓ TMUX cache copied successfully!\\n"