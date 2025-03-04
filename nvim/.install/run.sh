#!/usr/bin/bash

# COLORS
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
NC=$(tput sgr0)
BOLD=$(tput bold)

declare -r NVIM_DIR="${NVIM_DIR:-"$(which nvim)"}"
declare -r XDG_DATA_HOME="${XDG_DATA_HOME:-"$HOME/.local/share"}"
declare -r XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-"$HOME/.config"}"
declare -r RUNTIME_DIR="${RUNTIME_DIR:-"$XDG_DATA_HOME/nvim"}"
declare -r CONFIG_DIR="${CONFIG_DIR:-"$XDG_CONFIG_HOME/nvim"}"
declare DOTFILES_DIR="$HOME/dotfiles"

[ ! -d "$DOTFILES_DIR" ] && DOTFILES_DIR="$PROJECTS/personal/dotfiles"

# MAIN
function main() {
	check_tput_install

	detect_platform
	check_system_deps

	 echo -e "${BOLD}${YELLOW}Installation will override your $CONFIG_DIR directory!${NC}\n"

	while [ true ]; do
		msg
		read -p $'Do you wish to install Nvim config now? \e[33m[y/n]\e[0m: ' yn
		case $yn in
			[Yy]* ) break;;
			[Nn]* ) exit;;
			* ) echo "${BOLD}Please answer ${YELLOW}y${NC}${BOLD} or ${YELLOW}n${NC}${BOLD}.${NC}";;
		esac
	done

	remove_current_config
	create_nvim_config_dir
	install_lazy
	setup
	finish
}

function msg() {
  local text="$1"
  local flag="$2"
  local line="$3"
  local div_width="80"

  # Render line
  if [ "$line" != "0" ]; then
    printf "%${div_width}s\n" ' ' | tr ' ' -
  fi

  # Render text
  if [ "$flag" == "1" ]; then
    echo -e "$text"
  else
    echo -n "$text"
  fi
}

function check_tput_install() {
  if ! command -v tput &>/dev/null; then
    print_missing_dep_msg "tput"
    exit 1
  fi
}

function detect_platform() {
  msg "${BOLD}Detecting platform for managing any additional neovim dependencies... ${NC}"
  OS="$(uname -s)"
  case "$OS" in
    Linux)
      if [ -f "/etc/arch-release" ] || [ -f "/etc/artix-release" ]; then
        RECOMMEND_INSTALL="sudo pacman -S"
      elif [ -f "/etc/fedora-release" ] || [ -f "/etc/redhat-release" ]; then
        RECOMMEND_INSTALL="sudo dnf install -y"
      elif [ -f "/etc/gentoo-release" ]; then
        RECOMMEND_INSTALL="emerge install -y"
      else # assume debian based
        RECOMMEND_INSTALL="sudo apt install -y"
      fi
      ;;
    FreeBSD)
      RECOMMEND_INSTALL="sudo pkg install -y"
      ;;
    NetBSD)
      RECOMMEND_INSTALL="sudo pkgin install"
      ;;
    OpenBSD)
      RECOMMEND_INSTALL="doas pkg_add"
      ;;
    Darwin)
      RECOMMEND_INSTALL="brew install"
      ;;
    *)
      echo -e "${BOLD}OS $OS is not currently supported.${NC}"
      exit 1
      ;;
  esac
  echo -e "${GREEN}${BOLD}Done${NC}"
}

function print_missing_dep_msg() {
  if [ "$#" -eq 1 ] && [ "$1" == "neovim" ] && [ "$OS" == "Darwin" ]; then
    echo -e "${BOLD}${RED}[ERROR]: Unable to find neovim dependency${NC}"
    echo -e "${BOLD}Please install it first and re-run the installer.${NC}"
    echo -e "${BOLD}You need to install latest nightly version. Use: brew install --HEAD neovim${NC}\n"
  elif [ "$#" -eq 1 ]; then
    echo -e "${BOLD}${RED}[ERROR]: Unable to find dependency [$1]${NC}"
    echo -e "${BOLD}Please install it first and re-run the installer. Try: $RECOMMEND_INSTALL $1${NC}\n"
  else
    local cmds
    cmds=$(for i in "$@"; do echo "$RECOMMEND_INSTALL $i"; done)
    printf "${BOLD}${RED}[ERROR]: Unable to find dependencies [%s]${NC}" "$@"
    printf "Please install any one of the dependencies and re-run the installer. Try: \n%s\n" "$cmds"
  fi
}

function check_tput_install() {
  if ! command -v tput &>/dev/null; then
    print_missing_dep_msg "tput"
    exit 1
  fi
}

function check_system_deps() {
  if ! command -v npm &>/dev/null; then
    print_missing_dep_msg "npm"
    exit 1
  fi
  if ! command -v git &>/dev/null; then
    print_missing_dep_msg "git"
    exit 1
  fi
  if ! command -v nvim &>/dev/null; then
    print_missing_dep_msg "neovim"
    exit 1
  fi
  if ! command -v fzf &>/dev/null; then
    print_missing_dep_msg "fzf"
    exit 1
  fi
}

function remove_current_config() {
  cd $HOME
  msg "${BOLD}Removing current Neovim configuration... ${NC}"
  rm -rf "$CONFIG_DIR"
  echo -e "${GREEN}${BOLD}Done${NC}"
}

function create_nvim_config_dir() {
  cd $HOME
  msg "${BOLD}Creating Nvim folder in root directory... ${NC}"
  mkdir -p "$CONFIG_DIR"
  echo -e "${GREEN}${BOLD}✓ Done${NC}"

  msg "${BOLD}Symlinking all Nvim config... ${NC}"
  stow --restow -vv --ignore ".DS_Store" --ignore ".+.local" --ignore='^README.*' --target="$CONFIG_DIR" --dir="$DOTFILES_DIR" nvim
  echo -e "${GREEN}${BOLD}✓ Done${NC}"
}

function install_lazy() {
  if [ -e "$RUNTIME_DIR/lazy/lazy.nvim" ]; then
    msg "${BOLD}${GREEN}Lazy.nvim already installed!${NC}"
    echo -e
  else
    if ! git clone --filter=blob:none --single-branch "https://github.com/folke/lazy.nvim.git" \
      "$RUNTIME_DIR/lazy/lazy.nvim"; then
      msg "${BOLD}${RED}Failed to clone Lazy.nvim. Installation failed.${NC}"
      exit 1
    fi
  fi
}

function setup() {
  cd $CONFIG_DIR/.install

  msg "${BOLD}Installing plugins...${NC}" 1
  nvim --headless "+Lazy! sync" +qa

  msg "${BOLD}${GREEN}Done${NC}" 1 0

  msg "${BOLD}${GREEN}Plugin installation completed!${NC}" 1
}


function finish () {
  touch /tmp/first-nvim-run
  msg "${BOLD}${GREEN}Thank you for installing my ${BLUE}Nvim${NC}${BOLD}${GREEN} config! Please support me by giving a star :)${NC}" 1
  echo -e "${BOLD}${GREEN}Do not forget to use a font with glyphs (icons) support [https://github.com/ryanoasis/nerd-fonts].\nI recommend Fira Code for Nvim setup.${NC}"
}

main
