#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "./utils.sh"

main() {

  print_in_purple "\n • Installing Personal Preferred Apps and CLI Utils\n\n"

  brew_tap "zegervdv/zathura"

  # goes here ....
  brew_install "Ranger" "ranger"
  brew_install "Asciinema" "asciinema"
  brew_install "Zathura" "zathura"
  brew_install "Zathura PDF Poppler" "zathura-pdf-poppler"
  brew_install "Pip Env" "pipenv"
  brew_install "Pip Env" "pipenv"
  brew_install "Youtube Downloader" "youtube-dl"

  brew_install "Adopt Open JDK 8" "adoptopenjdk8" "homebrew/cask" "cask"
  brew_install "VLC" "vlc" "homebrew/cask" "cask"
  brew_install "INNA -> The modern media player for macOS" "iina" "homebrew/cask" "cask"
  brew_install "Utorrent" "utorrent" "homebrew/cask" "cask"
  brew_install "Teamviewer" "teamviewer" "homebrew/cask" "cask"
  brew_install "Docker" "docker" "homebrew/cask" "cask"
  brew_install "Steam" "steam" "homebrew/cask" "cask"
  brew_install "Transmission" "transmission" "homebrew/cask" "cask"
  brew_install "Transmit" "transmit" "homebrew/cask" "cask"
  brew_install "Zoom Conference" "zoomus" "homebrew/cask" "cask"
  brew_install "Notion" "notion" "homebrew/cask" "cask"
  brew_install "DB Browser for SQLite" "db-browser-for-sqlite" "homebrew/cask" "cask"

  print_in_purple "\n   Installing Apps from the App Store...\n"
  # Byword'
  mas install 420212497
  # Giphy Capture
  mas install 668208984
  # Tweetbot
  mas install 1384080005
  # TweetDeck
  mas install 485812721
  # WhatsApp
  mas install 1147396723
  # Telegram
  mas install 747648890

  # Remove outdated versions from the cellar
  brew cleanup

  # Finish
  print_in_green "\n  Applications & CLI Tools were successfully installed on your macOS machine! \n\n"
}

main
