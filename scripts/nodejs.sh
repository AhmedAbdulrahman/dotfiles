#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "./utils.sh"

on_start() {

  print_node_header

  print_info "This script will guide you through installing NPM config, global packages..etc"
  print_info "It will not install anything without your direct agreement!"

  ask_for_confirmation "Do you want to proceed with installation?"

  if ! answer_is_yes; then
    exit 1
  fi

}

configure_npm() {
  # Ask required parameters
  print_info "NPM Configuration\n"

  local name=""
  local email=""

  ask "What is your name: " && printf "\n"
  name="$(get_answer)"

  ask "What is your email: " && printf "\n"
  email="$(get_answer)"

  print_success "Author name set as: $name \n"
  npm set init.author.name "$name"

  print_success "\n Author email set as: $email \n"
  npm set init.author.email "$email"

  finish
}

install_global_packages() {

	type yarn >/dev/null 2>&1 || {
		echo >&2 "# yarn and node must be installed."
		echo >&2 "# Please, install node and yarn and try again"
		echo >&2 "# Skipping node packages installation…"
		exit 1
	}

	print_info "Installing NPM global packages"

	NPM_PACKAGES=(
	"bash-language-server"
	"dockerfile-language-server"
	"netlify-cli"
	"vercel@latest"
	"prettier"
	"svgo"
	"dependency-cruiser"
	"npkill"
	"expo"
	"nodemon"
	"gatsby-cli"
	"sanity@latest"
	"typescript-language-server"
	"source-map-explorer"
	"typescript"
	"vim-language-server"
	# "neovim"
	"vscode-langservers-extracted"
	"pyright"
	"yaml-language-server"
	"@tailwindcss/language-server"
	"vls" # Vue language server
	"@volar/vue-language-server" # Vue language server
	)

	npm install --global "${NPM_PACKAGES}"
	unset -v NPM_PACKAGES

  finish
}


main() {
#   on_start
#   configure_npm
  install_global_packages

  print_success "\n Done with NPM global packages and Configuration \n\n"
}

main
