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
mkdir -p "$(bat cache --config-dir)/themes"
cd "$(bat cache --config-dir)/themes" || exit 1
test ! -d TwoDark &&
    git clone --depth=1 https://github.com/erremauro/TwoDark.git

mkdir -p "$(bat cache --config-dir)/syntaxes"
cd "$(bat cache --config-dir)/syntaxes"
# Put new '.sublime-syntax' language definition files
# in this folder (or its subdirectories), for example:
test ! -d sublime-purescript-syntax &&
    git clone https://github.com/tellnobody1/sublime-purescript-syntax

bat cache --init