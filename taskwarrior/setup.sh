#!/usr/bin/env bash
################################################################################
#  Author: Ahmed Abdulrahman
#  Email: a.kasapbashi@gmail.com
#  Created: 2019-02-09 11:40
################################################################################

# get the dir of the current script
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SCRIPT_DIR" || return 1

# Install Taskwarrior, assumes brew is installed.
brew="/usr/local/bin/brew"

packages=(
"task"
"tasksh"
)

for package in "${packages[@]}"
do
  brew install $package
  echo "---------------------------------------------------------"
done

ln -sf  "$SCRIPT_DIR/taskrc"           ~/.taskrc