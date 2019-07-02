##!/usr/bin/env bash
################################################################################
#  Author: Ahmed Abdulrahman
#  Email: a.kasapbashi@gmail.com
#  Created: 2019-01-27 07:06
################################################################################

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SCRIPT_DIR" || exit 1

mkdir -p ~/.config/bat
ln -sf "$SCRIPT_DIR/config" ~/.config/bat/config

# Themes
mkdir -p "$(bat --config-dir)/themes"
cd "$(bat --config-dir)/themes" || exit 1
test ! -d TwoDark &&
    git clone --depth=1 https://github.com/erremauro/TwoDark.git
bat cache --build
