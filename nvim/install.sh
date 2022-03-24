# COLORS
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
NC=$(tput sgr0)
BOLD=$(tput bold)

declare -r NVIM_DIR="${NVIM_DIR:-"$(which nvim)"}"
declare -r RUNTIME_DIR="${RUNTIME_DIR:-"$XDG_DATA_HOME/nvim"}"
declare -r CONFIG_DIR="${CONFIG_DIR:-"$XDG_CONFIG_HOME/nvim"}"
declare -r PACK_DIR="$RUNTIME_DIR/site/pack"

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

function install_packer() {
  if [ -e "$PACK_DIR/packer/start/packer.nvim" ]; then
    msg "${BOLD}${GREEN}Packer already installed!${NC}"
    echo -e
  else
    if ! git clone --depth 1 "https://github.com/wbthomason/packer.nvim" \
      "$PACK_DIR/packer/start/packer.nvim"; then
      msg "${BOLD}${RED}Failed to clone Packer. Installation failed.${NC}"
      exit 1
    fi
  fi
}

function finish () {
  touch /tmp/first-nvim-run
  msg "${BOLD}${GREEN}Thank you for installing my ${BLUE}Nvim${NC}${BOLD}${GREEN} config! Please support me by giving a star :)${NC}" 1
  echo -e "${BOLD}${GREEN}Do not forget to use a font with glyphs (icons) support [https://github.com/ryanoasis/nerd-fonts].\nI recommend Fira Code for Nvim setup.${NC}"
}

function setup() {
  msg "${BOLD}Installing telescope-fzf-native...${NC}" 1
  git clone https://github.com/nvim-telescope/telescope-fzf-native.nvim /tmp/telescope-fzf-native.nvim
  rm -rf /tmp/telescope-fzf-native.nvim/.git
  cp -r /tmp/telescope-fzf-native.nvim "$PACK_DIR/packer/start/packer.nvim"
  rm -rf /tmp/telescope-fzf-native.nvim
  [ -d "$PACK_DIR/packer/start/packer.nvim/telescope-fzf-native.nvim" ] && msg "${BOLD}${GREEN}Done${NC}" 1 0
  [ ! -d "$PACK_DIR/packer/start/packer.nvim/telescope-fzf-native.nvim" ] && msg "${BOLD}${RED}Error while installing telescope-fzf-native... Aborting" 1 && exit

  cd "$PACK_DIR/packer/start/packer.nvim/telescope-fzf-native.nvim"
  msg "${BOLD}Building telescope-fzf-native...${NC}"
  make
  [ ! -f "$PACK_DIR/packer/start/packer.nvim/telescope-fzf-native.nvim/build/libfzf.so" ] && msg "${BOLD}${RED}Error while building telescope-fzf-native... Aborting" 1 && exit
  [ -f "$PACK_DIR/packer/start/packer.nvim/telescope-fzf-native.nvim/build/libfzf.so" ] && msg "${BOLD}${GREEN}Done${NC}" 1 0
  cd $CONFIG_DIR/.install

  msg "${BOLD}Installing plugins...${NC}" 1
  "$NVIM_DIR" --headless -u installation_config.lua \
    -c 'autocmd User PackerComplete quitall' \
    -c 'PackerSync'
  msg "${BOLD}${GREEN}Done${NC}" 1 0

  msg "${BOLD}${GREEN}Packer setup complete!${NC}" 1
}

install_packer
setup
finish
