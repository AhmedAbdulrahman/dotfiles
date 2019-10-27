#!/usr/bin/env bash

# Safer bash scripts with 'set -euxo pipefail'
set -Eueo pipefail
trap on_error SIGKILL SIGTERM

DOTFILES="$HOME/dotfiles"
GITHUB_REPO_URL_BASE="https://github.com/AhmedAbdulrahman/dotfiles"
HOMEBREW_INSTALLER_URL="https://raw.githubusercontent.com/Homebrew/install/master/install"
LINUXBREW_INSTALLER_URL="https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh"

e='\033'
RESET="${e}[0m"
BOLD="${e}[1m"
CYAN="${e}[0;96m"
RED="${e}[0;91m"
YELLOW="${e}[0;93m"
GREEN="${e}[0;92m"

_exists() {
  command -v $1 > /dev/null 2>&1
}

# Success reporter
info() {
  echo -e "${CYAN}${*}${RESET}"
}

# Error reporter
error() {
  echo -e "${RED}${*}${RESET}"
}

# Success reporter
success() {
  echo -e "${GREEN}${*}${RESET}"
}

# End section
finish() {
  success "Done!"
  echo
  sleep 1
}

get_permission() {
  # Ask for the administrator password upfront.
  sudo -v
  # Keep-alive: update existing `sudo` time stamp until the script has finished.
  while true; do
    sudo -n true
    sleep 60
    kill -0 "$$" || exit
  done 2>/dev/null &
}

print_prompt() {
  echo "What you want to do?"

  PS3="Enter your choice (must be a number): "
  options=("All" "Install package manager" "Clone Ahmed's dotfiles" "Symlink files" "Install macOS Apps" "Change shell" "Install XCode tools" "Quit")

  select opt in "${options[@]}"; do
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
      get_permission
      install_package_manager
      install_zsh
      break
      ;;
    "Install XCode tools")
      install_cli_tools
      break
      ;;
    "Quit")
      break
      ;;
    *)
      echo "Invalid option"
      break
      ;;
    esac
  done
}

on_start() {

  info  "   _____   ____ _______ ______ _____ _      ______  _____  "
  error "  |  __ \ / __ \__   __|  ____|_   _| |    |  ____|/ ____| "
  info  "  | |  | | |  | | | |  | |__    | | | |    | |__  | (___   "
  error "  | |  | | |  | | | |  |  __|   | | | |    |  __|  \___ \  "
  info  "  | |__| | |__| | | |  | |     _| |_| |____| |____ ____) | "
  error "  |_____/ \____/  |_|  |_|    |_____|______|______|_____/  "
  error "                                                           "
  info  "                  by @AhmedAbdulrahman                     "


  if [ -d "$DOTFILES/.git" ]; then
command cat <<EOF
      *******************************************
              $(git --git-dir "$DOTFILES/.git" --work-tree "$DOTFILES" log -n 1 --pretty=format:'%C(yellow)Last commit SHA:  %h')
              $(git --git-dir "$DOTFILES/.git" --work-tree "$DOTFILES" log -n 1 --pretty=format:'%C(red)Commit date:    %ad' --date=short)
              $(git --git-dir "$DOTFILES/.git" --work-tree "$DOTFILES" log -n 1 --pretty=format:'%C(cyan)Author:  %an')
      ********************************************
EOF
  fi

  info "This script will guide you through installing essentials for your (Mac/Linux/Windows WIP)OS."
  info "It won't install anything without your agreement!"
  echo
  read -p "Do you want to proceed with installation? [y/N] " -n 1 answer
  echo
  if [ ${answer} != "y" ]; then
    exit 1
  fi

}

install_cli_tools() {
  # Install Cli Tools. 
  # Note:There's not need to install XCode tools on Linux
  if [ `uname` == 'Linux' ]; then
    return
  fi

  info "Trying to detect installed Command Line Tools..."

  if ! [ $(xcode-select -p) ]; then
    echo "You don't have Command Line Tools installed!"
    read -p "Do you agree to install Command Line Tools? [y/N] " -n 1 answer
    echo
    if [ ${answer} != "y" ]; then
      exit 1
    fi

    info "Installing Command Line Tools..."
    echo "Please, wait until Command Line Tools will be installed, before continue."

    xcode-select --install
  else
    success "You already have Command Line Tools installed, nothing to do here skipping ... 💨"
  fi

  finish
}

install_package_manager() {
  local BREW_PATH="/usr/local/bin/brew"
  # macOS 
  if [ `uname` == 'Darwin' ]; then

    info "Checking if Homebrew is installed..."
    
    if ! _exists $BREW_PATH; then
      echo "Seems like you don't have Homebrew installed!"
      read -p "Do you agree to proceed with Homebrew installation? [y/N] " -n 1 answer
      echo

      if [ ${answer} != "y" ]; then
        exit 1
      fi

      info "Installing Homebrew..."
      echo "This may take a while"
      
      ruby -e "$(curl -fsSL ${HOMEBREW_INSTALLER_URL})"
      # Make sure we’re using the latest Homebrew.
      $BREW_PATH update
      $BREW_PATH install stow
    else
      success "You already have Homebrew installed, nothing to do here skipping ... 💨"
      $BREW_PATH -v
    fi

  # Linux 
  elif [ `uname` == 'Linux' ]; then
    # You can choose something else for linux specifc like Linuxbrew, apt-get, yum, etc...
    info "Checking if Linuxbrew is installed..."

    if [! -d "$HOME/.linuxbrew" ]; then
      echo "Seems like you don't have Linuxbrew installed!"
      read -p "Do you agree to proceed with Linuxbrew installation? [y/N] " -n 1 answer
      echo

      if [ ${answer} != "y" ]; then
        exit 1
      fi

      info "Installing Linuxbrew..."
      echo "This may take a while"

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
      success "You already have Linuxbrew installed, nothing to do here skipping... 💨"
    fi
  
  fi

  finish
}

install_zsh() {
  
  #Install ZSH
  info "Trying to detect installed Zsh..."

  if ! _exists zsh; then
    echo "Seems like you don't have Zsh installed!"
    read -p "Do you agree to proceed with Zsh installation? [y/N] " -n 1 answer
    echo
    if [ ${answer} != "y" ]; then
      exit 1
    fi

    info "Installing Zsh..."

    if [ `uname` == 'Darwin' ] || [ `uname` == 'Linux' ]; then
      brew install zsh
    else
      error "Error: Failed to install Zsh!"
      exit 1
    fi
  else
    success "You already have Zsh installed, nothing to do here skipping ... 💨"
  fi

  if _exists zsh; then
    info "Setting up Zsh as default shell..."
    local BREW_ZSH_PATH="/usr/local/bin/zsh"

    echo "The script will ask you the password for sudo when changing your default shell via chsh -s"
    echo

    if ! grep -q "$BREW_ZSH_PATH" /etc/shells; then
      info "Switching shell to zsh..."
      local ZSH_PATH=$(which zsh)

      if [ -x "$BREW_ZSH_PATH" ]; then
        ZSH_PATH="$BREW_ZSH_PATH"
      else
        info "Using system (outdated) zsh...."
      fi
      echo "$ZSH_PATH" | sudo tee -a /etc/shells >/dev/null
      chsh -s "$ZSH_PATH" "$(whoami)"
      echo "You'll need to log out for this to take effect"
    else
        info "No need to switch ZSH shell!"
    fi
  fi

  finish
}

clone_dotfiles() {
  info "Trying to detect if Ahmed's dotfiles is installed in $DOTFILES..."

  if [ ! -d $DOTFILES ]; then
    echo "Seems like you don't have Ahmed's dotfiles installed!"
    read -p "Do you agree to proceed with Ahmed's dotfiles installation? [y/N] " -n 1 answer
    echo
    if [ ${answer} != "y" ]; then
      exit 1
    fi

    echo "Cloning Ahmed's dotfiles"
    git clone --recursive "$GITHUB_REPO_URL_BASE.git" $DOTFILES

    # Setup repo origin & mirrors
    cd "$DOTFILES" &&
      git remote set-url origin git@github.com:AhmedAbdulrahman/dotfiles.git

  else
    success "You already have Ahmed's dotfiles installed. Skipping..."
    echo "Pulling latest update..."
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
  info "Trying to detect if you have already cloned Ahmed's dotfiles..."

  if [[ -d $DOTFILES ]]; then

    echo "What files you want to Symlink?"

    PS3="Enter your choice (must be a number): "
    files=("ZSH" "VIM" "TMUX" "CONFIG" "HAMMERSPOON" "Quit")

    select file in "${files[@]}"; do
      case $file in
      "ZSH")
        echo "Symlinking ZSH files"
        
        cd "$DOTFILES" && make --ignore-errors link file=zsh
        break
        ;;
      "VIM")
        echo "Symlinking VIM files"
        cd "$DOTFILES" && make --ignore-errors link file=vim
        break
        ;;
      "TMUX")
        echo "Symlinking TMUX files"
        cd "$DOTFILES" && make --ignore-errors link file=tmux
        break
        ;;
      "CONFIG")
        echo "Symlinking CONFIG files"
        cd "$DOTFILES" && make --ignore-errors link file=config
        break
        ;;
      "HAMMERSPOON")
        echo "Symlinking HAMMERSPOON files"
        cd "$DOTFILES" && make --ignore-errors link file=hammerspoon
        break
        ;;
      "Quit")
        break
        ;;
      *)
        echo "Invalid option"
        break
        ;;
      esac
    done
  else
    error "You don't  Ahmed's dotfiles $DOTFILES in your machine!"
  fi
}

bootstrap_macOS_apps() {
  if [[ -d $DOTFILES ]]; then
    echo "Seems like you have Ahmed's dotfiles installed!"
    read -p "Would you like to bootstrap your environment by installing Homebrew formulae? [y/N] " -n 1 answer
    echo
    if [ ${answer} != "y" ]; then
      return
    fi

    $DOTFILES/scripts/bootstrap.zsh
  else
    error "You don't  Ahmed's dotfiles $DOTFILES in your machine!"
  fi

  finish
}

on_finish() {
  echo
  success "Setup was successfully done!"
  success "Happy Coding!"
  echo
  echo -ne $RED'-_-_-_-_-_-_-_-_-_-_-_-_-_-_'
  echo -e  $RESET$BOLD',------,'$RESET
  echo -ne $YELLOW'-_-_-_-_-_-_-_-_-_-_-_-_-_-_'
  echo -e  $RESET$BOLD'|   /\_/\\'$RESET
  echo -ne $GREEN'-_-_-_-_-_-_-_-_-_-_-_-_-_-'
  echo -e  $RESET$BOLD'~|__( ^ .^)'$RESET
  echo -ne $CYAN'-_-_-_-_-_-_-_-_-_-_-_-_-_-_'
  echo -e  $RESET$BOLD'""  ""'$RESET
  echo
  info "P.S: Don't forget to restart your terminal ;)"
  echo "Cheers"
  echo
}

on_error() {
  echo
  error "Wow... Something serious happened!"
  error "In case if you need any help, raise an issue -> ${CYAN}${GITHUB_REPO_URL_BASE}issues/new${RESET}"
  echo
  exit 1
}

all() {
  get_permission
  install_package_manager
  install_cli_tools
  clone_dotfiles
  install_zsh
  symlink_files
  bootstrap_macOS_apps

  FAILED_COMMAND=$(fc -ln -1)

  if [ $? -eq 0 ]; then
    success "Done."
  else
    error "Something went wrong, [ Failed on: $FAILED_COMMAND ]"
  fi
}

main() {
  on_start
  print_prompt
  on_finish
}

main