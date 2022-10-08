#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "./utils.sh"

main() {

  print_in_purple "\n • Installing Personal Preferred Apps and CLI Utils\n\n"

  brew_tap "zegervdv/zathura"

  brew_install "Ranger -> File browser" "ranger"
  brew_install "Asciinema -> Record and share terminal sessions" "asciinema"
  brew_install "Zathura" "zathura"
  brew_install "Zathura PDF Poppler" "zathura-pdf-poppler"
  brew_install "Youtube DLP -> A youtube-dl fork with additional features and fixes" "yt-dlp"
  brew_install "Quickjs interpreter for VIM Codi" "quickjs"
  brew_install "LuaRocks -> Package manager for Lua" "luarocks"
  #   GUI
  brew_install "Chrome Canary -> Experiment and test the raw browser," "google-chrome-canary" "homebrew/cask-versions" "--cask"
  brew_install "Chrome Beta -> Preview upcoming features before they’re released." "google-chrome-beta" "homebrew/cask-versions" "--cask"
  brew_install "Firefox Developer -> All the latest developer tools in beta" "firefox-developer-edition" "homebrew/cask-versions" "--cask"
  brew_install "Firefox Nightly -> For testing about-to-be-released features in the most stable pre-release build." "firefox-nightly" "homebrew/cask-versions" "--cask"
  brew_install "Insomnia -> HTTP and GraphQL Client" "insomnia" "homebrew/cask" "--cask"
  brew_install "Discord -> Voice and text chat software" "discord" "homebrew/cask" "--cask"
  brew_install "TablePlus -> Native GUI tool for relational databases" "tableplus" "homebrew/cask" "--cask"
  brew_install "Kap -> Screen recorder built with web technology" "kap" "homebrew/cask" "--cask"
  brew_install "ImageOptim -> Optimize images to a smaller size" "imageoptim" "homebrew/cask" "--cask"
  brew_install "Karabiner Elements -> The one & only Keyboard customizer" "karabiner-elements" "homebrew/cask" "--cask"
  brew_install "Hammerspoon -> Desktop automation application" "hammerspoon" "homebrew/cask" "--cask"
  brew_install "MPV -> Cross-platform media player" "mpv" "homebrew/cask" "--cask"
  brew_install "INNA -> The modern media player for macOS" "iina" "homebrew/cask" "--cask"
  brew_install "Raycast -> lets you control your tools with a few keystrokes" "raycast" "homebrew/cask" "--cask"
  brew_install "Alfred -> Application launcher and productivity software" "alfred" "homebrew/cask" "--cask"
  brew_install "VLC -> Multimedia player" "vlc" "homebrew/cask" "--cask"
  brew_install "Webtorrent -> Torrent streaming application" "webtorrent" "homebrew/cask" "--cask"
  brew_install "CoreLocation CLI -> Print location information from CoreLocation" "corelocationcli" "homebrew/cask" "--cask"
#   Fonts
  brew_install "Fira Code Font" "font-fira-code" "homebrew/cask" "--cask"
  brew_install "Hack Nerd Font" "font-hack-nerd-font" "homebrew/cask" "--cask"
  brew_install "Jetbrains Mono" "font-jetbrains-mono" "homebrew/cask" "--cask"
# Others
  brew_install "Xquartz Open-source version of the X.Org X Window System" "xquartz" "homebrew/cask" "--cask"
  brew_install "Obsidian - Knowledge base" "obsidian" "homebrew/cask" "--cask"
  brew_install "Background Music -> a macOS audio utility: automatically pause your music, set individual apps' volumes and record system audio." "background-music" "homebrew/cask" "--cask"

  print_in_purple "\n   Installing Apps from the App Store...\n"
  # Spark
  mas install 1176895641
  # Slack
  mas install 803453959
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
