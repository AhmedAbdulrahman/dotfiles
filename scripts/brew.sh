#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "./utils.sh"

on_start() {
  print_macos_header

  print_info "This script will guide you through installing macOS applications and cli tools."
  print_info "It will not install anything without your direct agreement!"

  ask_for_confirmation "Do you want to proceed with installation?"

  if ! answer_is_yes; then
    exit 1
  fi
}


main() {
  # Start
  on_start

  print_in_purple "\n • Installing macOS Essential Apps and CLI Utils\n\n"

  # Make sure we’re using the latest Homebrew.
  brew_update
  # Upgrade any already-installed formulae.
  brew_upgrade

  brew_tap "homebrew/cask-fonts"
  brew_tap "homebrew/cask-versions"
  brew_tap "homebrew/bundle"
  brew_tap "homebrew/services"
  brew_tap "tavianator/tap"
  brew_tap "universal-ctags/universal-ctags"
  brew_tap "sachaos/todoist"
  brew_tap "dbcli/tap"
  brew_tap "xo/xo"
  brew_tap "homebrew-ffmpeg/ffmpeg"

  print_in_purple "\n   Core\n"
  brew_install "Openssl" "openssl"
  brew_install "Git" "git"
  brew_install "Git" "hub"
  brew_install "GitHub CLI" "gh"
  brew_install "Python" "python"
  brew_install "Gawk" "gawk"
  # Install GNU `sed`, overwriting the built-in `sed`.
  brew_install "GNU-sed" "gnu-sed"
  # Install GnuPG to enable PGP-signing commits.
  brew_install "GNUPG" "gnupg"
  # GNU File Shell and Text utilities
  brew_install "Coreutils" "coreutils"
  # Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
  brew_install "Findutils" "findutils"
  # Install some other useful utilities like `sponge`.
  brew_install "Moreutils" "moreutils"
  brew_install "CURL" "curl"
  brew_install "Httpie" "httpie"

  print_in_purple "\n   GPG\n\n"
  brew_install "GPG" "gpg"
  brew_install "Pinentry" "pinentry-mac"

  brew_install "Starship Prompt" "starship"

  brew_install "Transcrypt" "transcrypt"

  print_in_purple "\n   Languages\n"
  brew_install "Node" "node"
  brew_install "Yarn" "yarn"
  brew_install "Ruby" "ruby"

  print_in_purple "\n   Core apps\n"
  brew_install "Tmux" "tmux --HEAD"
  brew_install "Neovim" "neovim --HEAD"
  brew_install "VIM" "vim"
  brew_install "Perl" "perl"
  brew_install "Cpanminus - get, unpack, build and install modules from CPAN" "cpanminus"
  brew_install "Newsboat" "newsboat"

  print_in_purple "\n   Core Utils\n"
  brew_install "Pyenv" "pyenv"
  brew_install "Pip Env" "pipenv"
  brew_install "Tree" "tree"
  brew_install "Hub" "hub"
  brew_install "Fzf" "fzf"
  brew_install "FD" "fd"
  brew_install "Ripgrep" "ripgrep"
  brew_install "bat" "bat"
  brew_install "Highlight -> Convert source code to formatted text with syntax highlighting" "highlight"
  brew_install "Pandoc -> Markup File Converter" "pandoc"
  brew_install "URLview Extracts URLs from text" "urlview"
  brew_install "Cloc" "cloc"
  brew_install "Loc" "loc"
  brew_install "Tokei" "tokei"
  brew_install "Diff-So-Fancy" "diff-so-fancy"
  brew_install "Git Delta" "git-delta"
  brew_install "Z - jump around" "z"
  brew_install "Image Magick" "imagemagick"
  brew_install "Rename" "rename"
  brew_install "Universal Ctags" "universal-ctags/universal-ctags/universal-ctags --HEAD"
  brew_install "YAML processor" "yq"
  brew_install "JSON processor" "jq"
  brew_install "LS_COLORS generator with a rich filetype datebase" "vivid"
  brew_install "W3M" "w3m"
  brew_install "Htop" "htop"
  brew_install "Ffmpeg" "homebrew-ffmpeg/ffmpeg/ffmpeg --HEAD"
  brew_install "LSD" "lsd"
  brew_install "Grep" "grep"
  brew_install "Streamlink" "streamlink"
  brew_install "YAML Lint" "yamllint"
  brew_install "Grip" "grip"
  brew_install "Exiftool" "exiftool"
  brew_install "Proselint" "proselint"
  brew_install "Rsync" "rsync"
  brew_install "Task" "task"
  brew_install "Tasksh" "tasksh"
  brew_install "Timewarrior" "timewarrior"
  brew_install "The fuck" "thefuck"
  brew_install "Command line interface to the Xquartz11 clipboard" "xclip"
  brew_install "Ncdu" "ncdu"
  brew_install "Mycli" "mycli"
  brew_install "Pgcli" "pgcli"
  brew_install "Usql" "usql"
  brew_install "Reattach Namespace" "reattach-to-user-namespace"
  brew_install "Tldr" "tldr"
  brew_install "Experimental Rust compiler front-end for IDEs" "rust-analyzer"
  brew_install "ZK - a plain text note-taking assistant" "zk"
  #   LSPs
  brew_install "General purpose Language Server" "efm-langserver"
  brew_install "A Language Server for Clojure(script)" "clojure-lsp/brew/clojure-lsp-native"
  brew_install "Tldr" "tldr"

    # A simple command line interface for the Mac App Store
  brew_install "MAS -> Mac App Store command line interface" "mas"

  print_in_purple "\n   Desktop applications\n"
#   GUI
  brew_install "Chrome" "google-chrome" "homebrew/cask" "cask"
  brew_install "Firefox" "firefox" "homebrew/cask" "cask"
  brew_install "iTerm2" "iterm2" "homebrew/cask" "cask"
  brew_install "VSCode" "visual-studio-code" "homebrew/cask" "cask"
#   Quicklook plugins
  brew_install "Qlcolorcode" "qlcolorcode" "homebrew/cask" "cask"
  brew_install "Qlmarkdown" "qlmarkdown" "homebrew/cask" "cask"
  brew_install "Quicklook JSON" "quicklook-json" "homebrew/cask" "cask"
  brew_install "Quicklook CSV" "quicklook-csv" "homebrew/cask" "cask"
  brew_install "Qlstephen" "qlstephen" "homebrew/cask" "cask"
  brew_install "Qlimagesize" "qlimagesize" "homebrew/cask" "cask"
  brew_install "Qlprettypatch" "qlprettypatch" "homebrew/cask" "cask"
  brew_install "Qlvideo" "qlvideo" "homebrew/cask" "cask"
  brew_install "Webp Quicklook" "webpquicklook" "homebrew/cask" "cask"

  print_in_purple "\n   Installing Apps from the App Store...\n"
  # The Unarchiver
  mas install 425424353

  finish
}

main
