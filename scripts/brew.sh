#!/usr/bin/env zsh

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

  info '                             ____  _____ '
  info '    ____ ___   ____ _ _____ / __ \/ ___/ '
  info '   / __ `__ \ / __ `// ___// / / /\__ \  '
  info '  / / / / / // /_/ // /__ / /_/ /___/ /  '
  info ' /_/ /_/ /_/ \__,_/ \___/ \____//____/   '
  info '                                         '
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

  # CLI Tools
  brew_install coreutils
  brew_install tree
  brew_install wget
  brew_install yarn
  # Install `wget` with IRI support.
  brew install wget --with-iri
  # Install GnuPG to enable PGP-signing commits.
  brew install gnupg
  # Install more recent versions of some macOS tools.
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
  brew install fzf
  brew install zsh
  brew install git
  brew install imagemagick --with-webp
  brew install node # This installs `npm` too using the recommended installation method
  brew install pv
  brew install rename
  brew install tree
  brew install zopfli
  brew install ffmpeg --with-libvpx
  brew install speedtest_cli
  brew install ssh-copy-id
  brew install testssl
  brew install ruby
  brew install openssh
  brew install rsync
  brew install gcc --enable-all-languages
  brew install htop
  brew install nmap
  brew install gzip
  brew install terminal-notifier
  # find where your diskspace went
  brew install ncdu 

  # Desktop applications
    brew_install cask java

  # daily used
  brew cask install slack
  brew cask install discord
  brew cask install dropbox

  # dev
  brew cask install iterm2
  brew cask install visual-studio-code
  brew cask install sequel-pro
  brew cask install now
  brew cask install docker

  # design
  brew cask install figma
  brew cask install abstract
  brew cask install zeplin
  brew tap caskroom/fonts 
  brew cask install font-fira-code

  # Less often
  brew cask install zoom
  brew cask install vlc
  brew cask install kap
  brew cask install utorrent
  brew cask install teamviewer
  brew cask install virtualbox
  brew_install cask telegram
  brew_install cask steam

  # browsers
  brew cask install google-chrome
  brew cask install firefox

  # Utils 
  brew cask install alfred
  brew cask install karabiner
  brew cask install karabiner-elements
  brew cask install spectacle
  brew cask install hammerspoon

  # Remove outdated versions from the cellar
  brew cleanup
  # Finish
  on_finish
}

main "$*"
