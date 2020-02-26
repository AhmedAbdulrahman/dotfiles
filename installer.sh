#!/bin/bash

declare -r GITHUB_REPOSITORY="AhmedAbdulrahman/dotfiles"
declare -r GITHUB_REPO_URL_BASE="https://github.com/$GITHUB_REPOSITORY"
declare -r HOMEBREW_INSTALLER_URL="https://raw.githubusercontent.com/Homebrew/install/master/install"
declare -r LINUXBREW_INSTALLER_URL="https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh"
declare -r DOTFILES_UTILS_URL="https://raw.githubusercontent.com/$GITHUB_REPOSITORY/master/scripts/utils.sh"

declare -r DOTFILES="$HOME/dotfiles"

download() {
    local url="$1"
    local output="$2"

    if command -v "curl" &> /dev/null; then
        curl -LsSo "$output" "$url" &> /dev/null
        return $?

    elif command -v "wget" &> /dev/null; then
        wget -qO "$output" "$url" &> /dev/null
        return $?
    fi
    return 1
}

download_utils() {
    local tmpFile=""
    tmpFile="$(mktemp /tmp/XXXXX)"

    download "$DOTFILES_UTILS_URL" "$tmpFile" \
        && . "$tmpFile" \
        && rm -rf "$tmpFile" \
        && return 0
   return 1
}

print_prompt() {
  print_question "What you want to do?\n"

  PS3="Enter your choice (must be a number): "
  
  MENU_OPTIONS=("All" "Install package manager" "Clone Ahmed's dotfiles" "Symlink files" "Install macOS Apps" "Override macOS System Settings" "Change shell" "Install XCode tools" "Quit")

  select opt in "${MENU_OPTIONS[@]}"; do
    case $opt in
    "All")
      all
      break
      ;;
    "Install package manager")
      install_package_manager
      break
      ;;
    "Clone Ahmed's dotfiles")
      clone_dotfiles
      break
      ;;
    "Symlink files")
      install_package_manager
      symlink_files
      break
      ;;
    "Install macOS Apps")
      install_package_manager
      bootstrap_macOS_apps
      break
      ;;
    "Override macOS System Settings")
      override_macOS_system_settings
      break
      ;;
    "Change shell")
      ask_for_sudo_permission
      install_package_manager
      install_zsh
      break
      ;;
    "Install XCode tools")
      install_git
      install_cli_tools
      break
      ;;
    "Quit")
      break
      ;;
    *)
       print_error "Invalid option!"
       PS3=$( echo -e $BLUE"Enter a valid choice? ") # this displays the common prompt
       ;;
     esac
  done
}

on_start() {

  print_header

  print_repo_info $DOTFILES

  print_info "This script will guide you through installing essentials for your (Mac/Linux/Windows WIP)OS."
  print_info "It won't install anything without your agreement!"

  ask_for_confirmation "Do you want to proceed with installation?"

  if ! answer_is_yes; then
    exit 1
  fi

}

install_cli_tools() {
  # Install Cli Tools. 
  # Note:There's not need to install XCode tools on Linux
  if [ `uname` == 'Linux' ]; then
    return
  fi

  print_info "Trying to detect installed Command Line Tools..." 

  install_xcode_command_line_tools
  install_xcode
  set_xcode_developer_directory
  agree_with_xcode_licence

  finish
}

install_package_manager() {
  # macOS 
  if [ `uname` == 'Darwin' ]; then

    print_info "Trying to detect if Homebrew is installed..."
    
    if ! cmd_exists "brew"; then
      print_warning "Seems like you don't have Homebrew installed!"
      print_info "Installing Homebrew...This may take a while"
      
      printf "\n" | ruby -e "$(curl -fsSL ${HOMEBREW_INSTALLER_URL})" &> /dev/null

      print_result $? "Homebrew"

      brew_opt_out_of_analytics

      # Make sure we’re using the latest Homebrew.
      brew_update
      brew_install "Stow" "stow"

    else
      print_info "You already have Homebrew installed, nothing to do here skipping ... 💨"
    fi

  # Linux 
  elif [ `uname` == 'Linux' ]; then
    # You can choose something else for linux specifc like Linuxbrew, apt-get, yum, etc...
    print_info "Checking if Linuxbrew is installed..."

    if [! -d "$HOME/.linuxbrew" ]; then
      print_info "Seems like you don't have Linuxbrew installed!"
      ask_for_confirmation "Do you agree to proceed with Linuxbrew installation?"

      if ! answer_is_yes; then
        exit 1
      fi

      print_info "Installing Linuxbrew..."
      print_info "This may take a while"

      ruby -e "$(curl -fsSL ${LINUXBREW_INSTALLER_URL})"
      # Make sure we’re using the latest Homebrew.
      brew update
      brew install stow
      brew doctor || true

      mkdir $HOME/.linuxbrew/lib
      ln -s lib $HOME/.linuxbrew/lib64
      ln -s $HOME/.linuxbrew/lib $HOME/.linuxbrew/lib64
      ln -s /usr/lib64/libstdc++.so.6 /lib64/libgcc_s.so.1 $HOME/.linuxbrew/lib/

    else
      print_info "You already have Linuxbrew installed, nothing to do here skipping... 💨"
    fi
  
  fi

  finish
}

install_git() {
  print_info "Trying to detect installed Git..."

  if ! cmd_exists "git"; then
    print_info "Seems like you don't have Git installed!"

    ask_for_confirmation "Do you agree to proceed with Git installation?"

    if ! answer_is_yes; then
      return
    fi

    print_in_purple "\n • Installing Git\n\n"

    if [ `uname` == 'Darwin' ]; then
      brew_install "Git" "git"
    elif [ `uname` == 'Linux' ]; then
      sudo apt-get install git
    else
      print_error "Failed to install Git!"
      exit 1
    fi

    print_in_purple "\n • Set up GitHub SSH keys\n\n"
    if ! is_git_repository; then
        print_error "Not a Git repository"
        exit 1
    fi
    ssh -T git@github.com &> /dev/null

    if [ $? -ne 1 ]; then
        set_github_ssh_key
    fi

    print_result $? "Set up GitHub SSH keys"
  else
    print_info "You already have Git installed. Skipping..."
  fi

  finish
}

install_zsh() {
  
  #Install ZSH
  print_info "Trying to detect installed Zsh..."

  if ! cmd_exists "zsh"; then
    print_info "Seems like you don't have Zsh installed!"
    ask_for_confirmation "Do you agree to proceed with Zsh installation?"

    if ! answer_is_yes; then
      return
    fi

    print_info "Installing Zsh..."

    if [ `uname` == 'Darwin' ] || [ `uname` == 'Linux' ]; then
      brew install zsh
    else
      print_error "Failed to install Zsh!"
      return
    fi
  else
    print_info "You already have Zsh installed, nothing to do here skipping ... 💨"
  fi

  if cmd_exists "zsh"; then
    local BREW_ZSH_PATH="/usr/local/bin/zsh"
    local ZSH_PATH=$(which zsh)

    print_info "Setting up Zsh as default shell..."

    print_info "The script will ask you the password for sudo when changing your default shell via chsh -s"

    if ! grep -q "$BREW_ZSH_PATH" /etc/shells; then
      print_info "Switching shell to zsh..."

      if [ -x "$BREW_ZSH_PATH" ]; then
        ZSH_PATH="$BREW_ZSH_PATH"
      else
        print_info "Using system (outdated) zsh...."
      fi

      echo "$ZSH_PATH" | sudo tee -a /etc/shells >/dev/null
      chsh -s "$ZSH_PATH" "$(whoami)"
      print_info "You'll need to log out for this to take effect"

    else
      print_info "No need to switch ZSH shell!"
    fi
  fi

  finish
}

clone_dotfiles() {
  print_question "Trying to detect if Ahmed's dotfiles is installed in $DOTFILES..."

  if [ ! -d $DOTFILES ]; then
    print_info "Seems like you don't have Ahmed's dotfiles clone!"

    ask_for_confirmation "Do you agree to proceed with Ahmed's dotfiles installation?"

    if ! answer_is_yes; then
      return
    fi

    print_info "Cloning Ahmed's dotfiles"
    git clone --recursive "$GITHUB_REPO_URL_BASE.git" $DOTFILES

    # Setup repo origin & mirrors
    cd "$DOTFILES" &&
      git remote set-url origin git@github.com:AhmedAbdulrahman/dotfiles.git

  else
    print_info "You already have Ahmed's dotfiles installed. Skipping..."
    print_info "Pulling latest update..."

    cd "$DOTFILES" &&
      git stash -u &&
      git checkout master &&
      git reset --hard origin/master &&
      git submodule update --init --recursive &&
      git checkout - &&
      git stash pop
  fi

  finish
}

symlink_files() {
  print_info "Trying to detect if you have already cloned Ahmed's dotfiles..."

  if [[ -d $DOTFILES ]]; then
    print_info "Seems like you have Ahmed's dotfiles installed!"

    print_in_purple "\n • Create local config files\n\n"

    create_gitconfig_local
    create_zshrc_local
    create_vimrc_local

    print_in_purple "\n • Symlinking files/folders\n\n"
    cd "$DOTFILES" &&
      make symlink &&
      make gpg

  else
    print_info "You don't Ahmed's dotfiles $DOTFILES in your machine!"
  fi
}

bootstrap_macOS_apps() {
  if [[ -d $DOTFILES ]]; then
    ask_for_confirmation "Would you like to bootstrap your environment by installing Homebrew formulae?"

    if ! answer_is_yes; then
      break
    fi

    if [ "$(uname)" = "Darwin" ]; then

      if [ "$(echo "$0" | tr '[:upper:]' '[:lower:]')" == "work"  ]; then
        cd "$DOTFILES" && make --ignore-errors homebrew-work
      else
        cd "$DOTFILES" && make --ignore-errors homebrew-personal
      fi

    else
      print_info "Install Linux packages here..."
    fi

  else
    print_info "Skipping ... 💨!"
  fi

  finish
}

override_macOS_system_settings() {
  if [[ -d $DOTFILES ]]; then

    ask_for_confirmation "Would you like to Override macOS System Settings?"

    if ! answer_is_yes; then
      break
    fi

    cd "$DOTFILES" && make --ignore-errors macos
    restart
  else
    print_info "Skipping ... 💨!"
  fi

  finish
}

all() {
  ask_for_sudo_permission
  install_package_manager
  install_git
  install_cli_tools
  clone_dotfiles
  install_zsh
  symlink_files
  bootstrap_macOS_apps
  override_macOS_system_settings

  FAILED_COMMAND=$(fc -ln -1)

  if [ $? -eq 0 ]; then
    print_success "Done."
    print_info "Open a new tab & change to \"cd ~/dotfiles, then type make\" to Install Node packages, Python packages & macOS Settings" \
      "Don't forget to generate SSH keys & import gpg keys"
      command vim -u NONE $HOME/.{gitconfig,zshrc}.local
  else
    print_error "Something went wrong, [ Failed on: $FAILED_COMMAND ]"
  fi
}

main() {

  # Ensure that the following actions
  # are made relative to this file's path.

  cd "$(dirname "${BASH_SOURCE[0]}")" \
      || exit 1
  
  # Load utils

    if [ -x "scripts/utils.sh" ]; then
        . "scripts/utils.sh" || exit 1
    else
        download_utils || exit 1
    fi

  on_start
  print_prompt
  on_finish
}

main