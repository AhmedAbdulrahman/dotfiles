#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "./utils.sh"

main() {

  print_in_purple "\n • Installing Work related Apps and CLI Utils\n\n"

  brew_install "Virtualbox" "virtualbox" "homebrew/cask" "cask"
  brew_install "Vagrant" "vagrant" "homebrew/cask" "cask"
  # Vagrant-Manager helps you manage all your virtual machines in one place directly from the menubar
  brew_install "Vagrant Manager" "vagrant-manager" "homebrew/cask" "cask"

  # Remove outdated versions from the cellar
  brew cleanup

  # Finish
  print_in_green "\n  Applications & CLI Tools were successfully installed on your macOS machine! \n\n"
}

main
