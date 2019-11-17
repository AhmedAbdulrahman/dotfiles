#!/usr/bin/env zsh

# Safer bash scripts with 'set -euxo pipefail'
set -Eueo pipefail
trap on_error SIGKILL SIGTERM

e='\033'
RESET="${e}[0m"
BOLD="${e}[1m"
CYAN="${e}[0;96m"
RED="${e}[0;91m"
YELLOW="${e}[0;93m"
GREEN="${e}[0;92m"

# Success reporter
info() {
  echo -e "${CYAN}${*}${RESET}"
}

ask() {
  printf "${YELLOW}${*} [y/N]: ${RESET}"
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

on_start() {
  if [[ $(uname) == 'Darwin' ]]; then
    exit 1
  fi

  info "                        ____   _____   "
  info "                        / __ \ / ____| "
  info "  _ __ ___   __ _  ___| |  | | (___    "
  info "  | '_ ` _ \ / _` |/ __| |  | |\___ \  "
  info "  | | | | | | (_| | (__| |__| |____) | "
  info "  |_| |_| |_|\__,_|\___|\____/|_____/  "
  info "                                       "
  info "This script will guide you through installing linux applications and cli tools."
  echo "It will not install anything without your direct agreement!"
  echo
  ask "Do you want to proceed with installation?" && read answer
  echo
  if [[ "${answer}" != "y" ]]; then
    exit 1
  fi
}

brew_install() {
  local cask=$1 program=$2

  [[ -z $program ]] && program=$cask

  ask "Do you agree to install $(info $program)?" && read answer
  if [[ ${answer} != "y" ]]; then
    success "Skipping..."
    return
  fi

    info "Installing $program..."
    brew install $program

  finish
}

on_finish() {
  echo
  success "Linux applications was successfully installed!"
  echo
}

on_error() {
  echo
  error "Wow... Something serious happened!"
  error "Though, I don't know what really happened :("
  echo
  exit 1
}

main() {
  # Start
  on_start
  # Make sure we’re using the latest Linuxbrew.
  brew update
  # Upgrade any already-installed formulae.
  brew upgrade --all

  # CLI Tools
  brew_install coreutils
  brew_install tree
  brew_install wget
  brew_install yarn
  # Alternative to 'find' command
  brew install fd
  brew install ripgrep

  # Programming Languages
  brew install go
  brew install ruby


  # A cat(1) clone with syntax highlighting and Git integration.
  brew install bat

  #A code-searching tool similar to ack, but faster. 
  brew install the_silver_searcher
  
  # Install `wget` with IRI support.
  brew install wget --with-iri
  
  # Install GnuPG to enable PGP-signing commits.
  brew install gnupg
  
  # Install more recent versions of some linux tools.
  brew install vim --with-override-system-vi
  brew install grep
  brew install openssh
  brew install screen
  
  # z hopping around folders
  brew install z
  
  # Install font tools.
  brew tap bramstein/webfonttools
  brew install sfnt2woff
  brew install sfnt2woff-zopfli
  brew install woff2
  
  # Install other useful binaries
  brew install the_silver_searcher
  brew install zsh
  brew install git
  brew install imagemagick --with-webp
  brew install pv
  brew install rename
  brew install tree
  brew install zopfli
  brew install ffmpeg --with-libvpx
  brew install speedtest_cli
  brew install ssh-copy-id
  brew install testssl
  brew install openssh
  brew install rsync
  brew install gcc --enable-all-languages
  brew install htop
  brew install nmap
  brew install gzip
  brew install terminal-notifier
  brew install jq
  brew install lsd

  # corrects your previous console command
  brew install thefuck
  # find where your diskspace went
  brew install ncdu
  # Mysql CLI autoCompletion and syntax highlighting
  brew install mycli
  # Postgres CLI autocompletion and syntax highlighting
  brew install pgcli
  
  # Universal command-line interface for SQL databases
  # 1- Add xo tap
  brew tap xo/xo
  # 2- Install usql with "most" drivers
  brew install usql

  # Remove outdated versions from the cellar
  brew cleanup
  
  # Finish
  on_finish
}

main "$*"
