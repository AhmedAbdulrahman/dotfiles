#!/usr/bin/env bash

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
  printf "${YELLOW}${*}${RESET}"
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

  info  "   _   _           _           _  _____  "
  error "  | \ | |         | |         | |/ ____| "
  info  "  |  \| | ___   __| | ___     | | (___   "
  error "  | . ' |/ _ \ / _' |/ _ \_   | |\___ \  "
  info  "  | |\  | (_) | (_| |  __/ |__| |____) | "
  error "  |_| \_|\___/ \__,_|\___|\____/|_____/  "
  error "                                         "
  info "This script will guide you through installing NPM config, global packages..etc"

  echo
  read -p "Do you want to proceed with installation? [y/N] " -n 1 answer
  echo

  if [ ${answer} != "y" ]; then
    exit 1
  fi

}


configure_npm_init() {
  # Ask required parameters
  info "Configure NPM init..."

  # Defaults
  local name="Ahmed Abdulrahman"
  local email="a.kasapbashi@live.com"

  ask "What is your name? ($name): " && read NAME
  ask "What is your email? ($email): " && read EMAIL

  # If required parameters are not entered, set them default values
  : ${NAME:="$name"}
  : ${EMAIL:="$email"}

  echo "Author name set as: $NAME"
  npm set init.author.name "$NAME"
  echo "Author email set as: $EMAIL"
  npm set init.author.email "$EMAIL"
  echo

  finish
}

fix_npm_perm() {
  # Fixing npm permissions
  info "Fixing npm permissions..."

  NPM_PREFIX="$(npm config get prefix)"
  if [[ "${NPM_PREFIX}" = '/usr/local' ]]; then
    sudo chown -R $(whoami) $(npm config get prefix)/{lib/node_modules,bin,share}
  elif [ ! "$NPM_PREFIX" = '/usr' ]; then
    [ ! -d ~/.npm-global ] && mkdir ~/.npm-global
    npm config set prefix '~/.npm-global'
  fi

  finish
}

install_global_packages() {
	info "Installing NPM global packages"

	NPM_PACKAGES=(
	"bash-language-server"
	"dockerfile-language-server-nodejs"
	"netlify-cli"
	"now"
	"parker"
	"prettier"
	"serve"
	"source-map-explorer"
	"svgo"
	"overtime-cli"
	"dependency-cruiser"
	"neovim"
	"npkill"
	"expo-cli"
	"nodemon"
  "gatsby-cli"
	)

	yarn global add "${NPM_PACKAGES[@]}"
	unset -v NPM_PACKAGES
}

on_finish() {
  success "Done with NODE configurations1"
  echo
}

on_error() {
  error "Wow... Something serious happened!"
  error "Try to find it out ;)"
  exit 1
}

main() {
  on_start "$*"
  configure_npm_init "$*"
  fix_npm_perm "$*"
  install_global_packages "$*"
}

main "$*"
