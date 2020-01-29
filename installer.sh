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
  print_question "What you want to do?"

  PS3="Enter your choice (must be a number): "
  
  MENU_OPTIONS=("All" "Install package manager" "Clone Ahmed's dotfiles" "Symlink files" "Install macOS Apps" "Change shell" "Install XCode tools" "Quit")

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

  if ! [ $(xcode-select -p) ]; then
    print_info "You don't have Command Line Tools installed!"
    read -p "Do you agree to install Command Line Tools? [y/N] " -n 1 answer
    ask_for_confirmation "Do you agree to install Command Line Tools?"

    if ! answer_is_yes; then
      exit 1
    fi

    print_info "Installing Command Line Tools..."
    print_info "Please, wait until Command Line Tools will be installed, before continue."

    xcode-select --install
  else
    print_info "You already have Command Line Tools installed, nothing to do here skipping ... 💨"
  fi

  finish
}

install_package_manager() {
  local BREW_PATH="/usr/local/bin/brew"
  # macOS 
  if [ `uname` == 'Darwin' ]; then

    print_info "Checking if Homebrew is installed..."
    
    if ! cmd_exists $BREW_PATH; then
      print_warning "Seems like you don't have Homebrew installed!"
      ask_for_confirmation "Do you agree to proceed with Homebrew installation?"

      if ! answer_is_yes; then
        exit 1
      fi

      print_info "Installing Homebrew..."
      print_info "This may take a while"
      
      ruby -e "$(curl -fsSL ${HOMEBREW_INSTALLER_URL})"
      # Make sure we’re using the latest Homebrew.
      $BREW_PATH update
      $BREW_PATH install stow
    else
      print_info "You already have Homebrew installed, nothing to do here skipping ... 💨"
      $BREW_PATH -v
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
  local BREW_PATH="/usr/local/bin/brew"

  if ! cmd_exists "git"; then
    print_info "Seems like you don't have Git installed!"

    ask_for_confirmation "Do you agree to proceed with Git installation?"

    if ! answer_is_yes; then
      exit 1
    fi

    print_info "Installing Git..."

    if [ `uname` == 'Darwin' ]; then
      $BREW_PATH install git
    elif [ `uname` == 'Linux' ]; then
      sudo apt-get install git
    else
      print_error "Error: Failed to install Git!"
      exit 1
    fi
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
      exit 1
    fi

    print_info "Installing Zsh..."

    if [ `uname` == 'Darwin' ] || [ `uname` == 'Linux' ]; then
      brew install zsh
    else
      print_error "Failed to install Zsh!"
      exit 1
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
    print_info "Seems like you don't have Ahmed's dotfiles installed!"

    ask_for_confirmation "Do you agree to proceed with Ahmed's dotfiles installation?"

    if ! answer_is_yes; then
      exit 1
    fi

    print_info "Cloning Ahmed's dotfiles"
    git clone --recursive "$GITHUB_REPO_URL_BASE.git" $DOTFILES

    # Setup repo origin & mirrors
    cd "$DOTFILES" &&
      git remote set-url origin git@github.com:AhmedAbdulrahman/dotfiles.git

  else
    print_info "You already have Ahmed's dotfiles installed. Skipping..."
    print_info "Pulling latest update..."
    # cd "$DOTFILES" &&
    #   git stash -u &&
    #   git checkout master &&
    #   git reset --hard origin/master &&
    #   git submodule update --init --recursive &&
    #   git checkout - &&
    #   git stash pop
  fi

  finish
}

symlink_files() {
  print_info "Trying to detect if you have already cloned Ahmed's dotfiles..."

  if [[ -d $DOTFILES ]]; then
    print_info "Seems like you have Ahmed's dotfiles installed!"
    print_info "What files you want to Symlink?"

    PS3="Enter your choice (must be a number): "
    files=("All" "ZSH" "VIM" "TMUX" "FILES" "HAMMERSPOON" "Quit")

    select file in "${files[@]}"; do
      case $file in
      All|ZSH|VIM|TMUX|FILES|HAMMERSPOON)
        cd "$DOTFILES" && make --ignore-errors link file="$(echo "$file" | tr '[:upper:]' '[:lower:]')"
        break
        ;;
      "Quit")
        break
        ;;
      *)
        print_error "Invalid option!"
        PS3="Enter a valid choice? " # this displays the common prompt
        ;;
      esac
    done
  else
    print_info "You don't Ahmed's dotfiles $DOTFILES in your machine!"
  fi
}

bootstrap_macOS_apps() {
  if [[ -d $DOTFILES ]]; then
    print_info "Seems like you have Ahmed's dotfiles installed!"

    ask_for_confirmation "Would you like to bootstrap your environment by installing Homebrew formulae?"

    if ! answer_is_yes; then
      exit 1
    fi

    cd "$DOTFILES" && make --ignore-errors bootstrap
  else
    print_info "You don't  Ahmed's dotfiles $DOTFILES in your machine!"
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

  FAILED_COMMAND=$(fc -ln -1)

  if [ $? -eq 0 ]; then
    print_success "Done."
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