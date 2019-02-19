##!/usr/bin/env bash
################################################################################
#  Author: Ahmed Abdulrahman
#  Email: a.kasapbashi@gmail.com
#  Created: 2019-01-27 07:00
################################################################################

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

mkdir -p ~/.pip
ln -sf "$SCRIPT_DIR/pip.conf" ~/.pip/pip.conf # No pynvim package
pip install --upgrade pip

# Formatter / Repl
pip install yapf ptpython virtualenv virtualenvwrapper numpy

# Config for ptpython
mkdir -p ~/.ptpython
ln -sf "$SCRIPT_DIR/ptpythonrc" ~/.ptpython/config.py
ln -sf "$SCRIPT_DIR/style.yapf" ~/.style.yapf