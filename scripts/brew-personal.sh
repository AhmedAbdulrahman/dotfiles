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
  brew_install "Composer" "composer"
  brew_install "Youtube Downloader" "youtube-dl"
  brew_install "Quickjs interpreter for VIM Codi" "quickjs"
  brew_install "Adopt Open JDK 8" "adoptopenjdk8" "homebrew/cask" "cask"
  #   GUI
  brew_install "Chrome Canary" "google-chrome-canary" "homebrew/cask-versions" "cask"
  brew_install "Chromium" "chromium" "homebrew/cask" "cask"
  brew_install "Firefox Developer" "firefox-developer-edition" "homebrew/cask-versions" "cask"
  brew_install "Firefox Nightly" "firefox-nightly" "homebrew/cask-versions" "cask"
  brew_install "Insomnia" "insomnia" "homebrew/cask" "cask"
  brew_install "Discord" "discord" "homebrew/cask" "cask"
  brew_install "Sequel Pro" "sequel-pro" "homebrew/cask" "cask"
  brew_install "Kap" "kap" "homebrew/cask" "cask"
  brew_install "Figma" "figma" "homebrew/cask" "cask"
  brew_install "ImageOptim" "imageoptim" "homebrew/cask" "cask"
  brew_install "Karabiner Elements" "karabiner-elements" "homebrew/cask" "cask"
  brew_install "Hammerspoon" "hammerspoon" "homebrew/cask" "cask"
  brew_install "MPV" "mpv" "homebrew/cask" "cask"
  brew_install "INNA -> The modern media player for macOS" "iina" "homebrew/cask" "cask"
  brew_install "Raycast lets you control your tools with a few keystrokes" "raycast" "homebrew/cask" "cask"
  brew_install "VLC" "vlc" "homebrew/cask" "cask"
  brew_install "Utorrent" "utorrent" "homebrew/cask" "cask"
  brew_install "Docker" "docker" "homebrew/cask" "cask"
  brew_install "Transmit" "transmit" "homebrew/cask" "cask"
  brew_install "DB Browser for SQLite" "db-browser-for-sqlite" "homebrew/cask" "cask"
  brew_install "Android Studio" "android-studio" "homebrew/cask" "cask"
  brew_install "Flutter" "flutter" "homebrew/cask" "cask"
  brew_install "CoreLocationCLI gets the physical location of your device and prints it to standard output" "corelocationcli" "homebrew/cask" "cask"
#   Fonts
  brew_install "Fira Code Font" "font-fira-code" "homebrew/cask" "cask"
  brew_install "Hack Nerd Font" "font-hack-nerd-font" "homebrew/cask" "cask"
  brew_install "Jetbrains Mono" "font-jetbrains-mono" "homebrew/cask" "cask"
  brew_install "Jetbrains Mono Nerd Font" "font-jetbrainsmono-nerd-font" "homebrew/cask" "cask"
  brew_install "Jetbrains Mono Nerd Font Mono" "font-jetbrainsmono-nerd-font-mono" "homebrew/cask" "cask"
# Others
  brew_install "Xquartz Open-source version of the X.Org X Window System" "xquartz" "homebrew/cask" "cask"
  brew_install "Obsidian - Knowledge base" "obsidian" "homebrew/cask" "cask"
  print_in_purple "\n   Installing Apps from the App Store...\n"
  # Spark
  mas install 1176895641
  # Slack
  mas install 803453959
  # Dashlane
  mas install 552383089
  # Alfred
  mas install 405843582
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
  # Guidance
  mas install 412759995

  # Remove outdated versions from the cellar
  brew cleanup

  # Finish
  print_in_green "\n  Applications & CLI Tools were successfully installed on your macOS machine! \n\n"
}

main
