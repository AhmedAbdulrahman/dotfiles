#!/usr/bin/env bash
################################################################################
#  Author: Ahmed Abdulrahman
#  Email: a.kasapbashi@gmail.com
#  Created: 2018-12-30 09:25
################################################################################

# get the dir of the current script
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

# -p says to create the dir if it doesn't exist already.
mkdir -p ~/.hammerspoon

ln -sf "$SCRIPT_DIR/init.lua"       ~/.hammerspoon/init.lua
ln -sf "$SCRIPT_DIR/keyboard.lua"   ~/.hammerspoon/keyboard.lua
ln -sf "$SCRIPT_DIR/position.lua"   ~/.hammerspoon/position.lua
ln -sf "$SCRIPT_DIR/watcher.lua"    ~/.hammerspoon/watcher.lua