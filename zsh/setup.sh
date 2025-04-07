#!/usr/bin/env bash

# Get the dir of the current script
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SCRIPT_DIR" || return 1

confdir="$HOME/.config/zsh"

echo "\\n → Creating ZSH .config directory..."
mkdir -p "$confdir"

echo "✓ ZSH folder created successfully! \\n"

echo "→ Symlinking files..."
ln -sf "$SCRIPT_DIR/zshrc"  ~/.zshrc
ln -sf "$SCRIPT_DIR/zshenv" ~/.zshenv
ln -sf "$SCRIPT_DIR/spaceshiprc" ~/.spaceshiprc

# Make sure target directory exists
mkdir -p "$confdir/config"
mkdir -p "$confdir/bin"

ln -sf {"$SCRIPT_DIR/config","$confdir/config"}/completion
ln -sf {"$SCRIPT_DIR/config","$confdir/config"}/aliases
ln -sf {"$SCRIPT_DIR/config","$confdir/config"}/keybindings
ln -sf {"$SCRIPT_DIR/config","$confdir/config"}/custom
ln -sf {"$SCRIPT_DIR/config","$confdir/config"}/fzf_extra
ln -sf {"$SCRIPT_DIR/config","$confdir/config"}/local_secret
ln -sf {"$SCRIPT_DIR/config","$confdir/config"}/history
ln -sf {"$SCRIPT_DIR/config","$confdir/config"}/widget
# ln -sf {"$SCRIPT_DIR/config","$confdir/config"}/zsh_theme

# for f in theme/*.zsh; do
#     ln -sf {"$SCRIPT_DIR","$confdir"}/"$f"
#     echo "Created symlink for $f"
# done

for f in bin/*; do
    ln -sf {"$SCRIPT_DIR","$confdir"}/"$f"
    echo "Created symlink for $f"
done

rm -rf ~/.config/sheldon && ln -snf "$SCRIPT_DIR/sheldon" ~/.config/sheldon
# ln -sf "$SCRIPT_DIR/starship.toml" ~/.config/starship.toml

[[ "$SHELL" =~ "zsh" ]] || chsh -s "$(command -v zsh)"

echo "✓ ~/.zshenv linked successfully! \\n"

zsh -ic 'exit'

# zsh source order:
# https://medium.com/@rajsek/zsh-bash-startup-files-loading-order-bashrc-zshrc-etc-e30045652f2e
# +----------------+-----------+-----------+------+
# |                |Interactive|Interactive|Script|
# |                |login      |non-login  |      |
# +----------------+-----------+-----------+------+
# |/etc/zshenv     |    A      |    A      |  A   |
# +----------------+-----------+-----------+------+
# |~/.zshenv       |    B      |    B      |  B   |
# +----------------+-----------+-----------+------+
# |/etc/zprofile   |    C      |           |      |
# +----------------+-----------+-----------+------+
# |~/.zprofile     |    D      |           |      |
# +----------------+-----------+-----------+------+
# |/etc/zshrc      |    E      |    C      |      |
# +----------------+-----------+-----------+------+
# |~/.zshrc        |    F      |    D      |      |
# +----------------+-----------+-----------+------+
# |/etc/zlogin     |    G      |           |      |
# +----------------+-----------+-----------+------+
# |~/.zlogin       |    H      |           |      |
# +----------------+-----------+-----------+------+
# |                |           |           |      |
# +----------------+-----------+-----------+------+
# |                |           |           |      |
# +----------------+-----------+-----------+------+
# |~/.zlogout      |    I      |           |      |
# +----------------+-----------+-----------+------+
# |/etc/zlogout    |    J      |           |      |
# +----------------+-----------+-----------+------+
