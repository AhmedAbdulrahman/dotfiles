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
  if [[ $(uname) != 'Darwin' ]]; then
    exit 1
  fi

  info "                        ____   _____   "
  info "                        / __ \ / ____| "
  info "  _ __ ___   __ _  ___| |  | | (___    "
  info "  | '_ ` _ \ / _` |/ __| |  | |\___ \  "
  info "  | | | | | | (_| | (__| |__| |____) | "
  info "  |_| |_| |_|\__,_|\___|\____/|_____/  "
  info "                                       "
  info "This script will guide you through installing macOS applications and cli tools."
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

  if [[ $cask == 'cask' ]]; then
    info "Installing $program with cask..."
    brew cask install $program
  else
    info "Installing $program..."
    brew install $program
  fi

  finish
}

on_finish() {
  echo
  success "macOS applications was successfully installed!"
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
  # Make sure we’re using the latest Homebrew.
  brew update
  # Upgrade any already-installed formulae.
  brew upgrade --all

  brew tap homebrew/cask-fonts
  brew tap homebrew/cask-versions
  brew tap homebrew/bundle
  brew tap homebrew/services
  brew tap neomutt/homebrew-neomutt
  brew tap tavianator/tap
  brew tap universal-ctags/universal-ctags
  brew tap sachaos/todoist
  brew tap dbcli/tap
  brew tap zegervdv/zathura
  brew tap xo/xo
  brew tap dandavison/delta https://github.com/dandavison/delta
  # Core
  brew_install openssl
  brew_install git
  brew_install hub                              # an extension to command-line git that helps you do everyday GitHub tasks without ever leaving the terminal.
  brew_install python
  brew_install python@2
  brew_install gawk
  brew_install gnu-sed
  brew_install coreutils                        # GNU File Shell and Text utilities
  brew_install findutils
  brew_install curl
  brew_install wget --with-iri # Install `wget` with IRI support.
  brew_install pinentry-mac
  brew_install gnupg           # Install GnuPG to enable PGP-signing commits.
  brew_install zsh
  brew_install transcrypt

  # Languages
  brew_install node
  brew_install n
  brew_install yarn
  brew_install ruby
  brew_install cask java

  # CLI Tools
  brew_install tree
  brew_install n                              # Interactively Manage Your Node.js Versions
  brew_install hub                            # an extension to command-line git that helps you do everyday GitHub tasks without ever leaving the terminal.
  brew_install fd                             # Alternative to 'find' command
  brew_install ripgrep                        # Search tool like grep and The Silver Searcher
  brew_install bat                            # A cat(1) clone with syntax highlighting and Git integration.
  brew_install highlight                      # Convert source code to formatted text with syntax highlighting
  brew_install pandoc                         # Swiss-army knife of markup format conversion
  brew_install urlview                        # A utility is used to extract URL from text files
  brew_install cloc                           # Statistics utility to count lines of code
  brew_install loc                            # Count lines of code quickly
  brew_install tokei                          # A program that allows you to count your code, quickly.
  brew_install the_silver_searcher            # A code-searching tool similar to ack, but faster. 
  brew_install diff-so-fancy
  brew_install dandavison/delta/git-delta
  brew_install z                              # z hopping around folders
  brew_install imagemagick --with-webp
  brew_install rename
  brew_install tree
  brew_install ranger                         # A console file manager with VI key bindings.
  brew_install zathura
  brew_install zathura-pdf-poppler
  brew_install yq
  brew_install jq
  brew_install w3m
  brew_install htop                           # Improved top (interactive process viewer) for OS X
  brew_install namespace                      # Port scanning utility for large networks
  brew_install ffmpeg --with-libvpx
  brew_install terminal-notifier
  brew_install exa
  brew_install grep
  brew_install testssl
  brew_install exiftool
  brew_install rsync
  brew_install task
  brew_install tasksh
  brew_install timewarrior
  brew_install thefuck                         # corrects your previous console command
  brew_install ncdu                            # find where your diskspace went
  brew_install mycli                           # Mysql CLI autoCompletion and syntax highlighting
  brew_install pgcli                           # Postgres CLI autocompletion and syntax highlighting
  brew_install usql                            # Universal command-line interface for SQL databases, install usql with "most" drivers
  brew_install reattach-to-user-namespace      # In order for tmux-yank to work on MacOS, we need to install reattach-to-user-namespace
  brew_install tldr
  brew_install font-fira-code
  brew_install font-hack-nerd-font

  # Desktop applications
  brew_install cask firefox
  brew_install cask google-chrome
  brew_install cask iterm2                      # iTerm2 is a replacement for Terminal and the successor to iTerm.
  brew_install cask visual-studio-code          # code editor
  brew_install cask alfred                      # An app helps you do a lot more things quicker, without having to leave the keyboard.
  brew_install cask karabiner                   # A powerful and stable keyboard customizer for macOS.
  brew_install cask karabiner-elements          # A powerful and stable keyboard customizer for macOS.
  brew_install cask spectacle                   # Move and resize windows with ease
  brew_install cask hammerspoon                 # Staggeringly powerful OS X desktop automation with Lua. Making the runtime, funtime.
  brew_install cask insomnia                    # Insomnia is a cross-platform GraphQL and REST client
  brew_install cask transmission                # Insomnia is a cross-platform GraphQL and REST client
  brew_install cask handbrake                   # HandBrake is a tool for converting video from nearly any format to a selection of modern, widely supported codecs.
  brew_install cask dashlane                    # the safe, simple way to store and fill passwords and personal information.
  brew_install cask slack
  brew_install cask discord                     # A Free Voice and Text Chat app for Gamers
  brew_install cask vlc                         # A free and open source cross-platform multimedia player
  brew_install cask utorrent
  brew_install cask teamviewer                  # A handy tool for connecting remote devices
  brew_install cask telegram                    # A cloud-based instant messaging and voice over IP app
  brew_install cask steam                       # A video game digital distribution platform
  brew_install cask docker
  brew_install cask virtualbox
  brew_install cask vagrant
  brew_install cask vagrant-manager             # Vagrant-Manager helps you manage all your virtual machines in one place directly from the menubar
  brew_install cask flux
  brew_install cask now
  brew_install cask sequel-pro
  brew_install cask visual-studio-code
  brew_install cask kap
  brew_install cask abstract
  brew_install cask zoomus

  # Remove outdated versions from the cellar
  brew cleanup
  
  # Finish
  on_finish
}

main "$*"
