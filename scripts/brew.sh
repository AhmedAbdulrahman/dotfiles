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

  brew_tap "homebrew/cask-fonts" # You only need to do this once!
  brew_tap "homebrew/cask-versions"
  brew_tap "homebrew/bundle"
  brew_tap "homebrew/services"
  brew_tap "xo/xo"

  print_in_purple "\n   Core\n"
  brew_install "Openssl" "openssl"
  brew_install "Cmake" "cmake"
  brew_install "Git" "git"
  brew_install "GitHub CLI" "gh"
  brew_install "Git Delta" "git-delta"
  brew_install "Git Tig" "tig"
  brew_install "Exiftool" "exiftool"
  brew_install "Glow -> Render markdown on the CLI, with pizzazz!" "glow"
#   brew_install "Python3" "python3"

  brew_install "Gawk" "gawk"
  # GNU File Shell and Text utilities
  brew_install "Coreutils" "coreutils"
  # Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
  brew_install "Findutils" "findutils"
  # Install some other useful utilities like `sponge`.
  brew_install "Moreutils -> A collection of tools that nobody wrote when UNIX was young" "moreutils"
  brew_install "CURL -> get a file from an HTTP, HTTPS or FTP server" "curl"
  brew_install "Httpie -> A User-friendly cURL replacement (command-line HTTP client)" "httpie"

  print_in_purple "\n   GPG\n\n"
  brew_install "GNU-sed" "gnu-sed"  # Install GNU `sed`, overwriting the built-in `sed`.
  brew_install "GNUPG" "gnupg"  # Install GnuPG to enable PGP-signing commits.
  brew_install "Pinentry" "pinentry-mac"
  brew_install "Starship Prompt" "starship"
  brew_install "Transcrypt  -> Configure transparent encryption of files in a Git repo" "transcrypt"
#   brew_install "Yarn" "yarn"
  print_in_purple "\n   Languages\n"
  brew_install "Rustup -> Rust toolchain installer" "rustup-init"
  brew_install "Rust Analyzer -> Experimental Rust compiler front-end for IDEs" "rust-analyzer"
  brew_install "Perl -> Highly capable, feature-rich programming language" "perl"
  brew_install "Kotlin" "kotlin"
  brew_install "Ktlint -> Anti-bikeshedding Kotlin linter with built-in formatter" "ktlint"

#   brew_install "Ruby" "ruby"

  print_in_purple "\n   Core apps\n"
  brew_install "Tmux -> Terminal multiplexer" "tmux --HEAD"
  brew_install "Cpanminus -> get, unpack, build and install modules from CPAN" "cpanminus"
  brew_install "Newsboat -> RSS/Atom feed reader for text terminals" "newsboat"

  print_in_purple "\n   Core Utils\n"
  # Pyenv and Pipenv are necessary tools if you are working on different projects
  # that need to be deployed to production and maintain a clean codebase.
  brew_install "Pyenv -> Python version management" "pyenv"
  brew_install "Pip Env -> Python dependency management tool" "pipenv"
  brew_install "Tree" "tree"
  brew_install "Fzf" "fzf"
  brew_install "FD" "fd"
  brew_install "Ripgrep" "ripgrep"
  brew_install "bat" "bat"
  brew_install "URLview Extracts URLs from text" "urlview"
  brew_install "Tokei Count your code, quickly." "tokei"
  brew_install "Tig - text-mode interface for Git" "tig"
  brew_install "Z -> Tracks most-used directories to make cd smarter" "z"
  brew_install "Image Magick -> Provides tools and libraries to manipulate images in many formats" "imagemagick"
  brew_install "Rename -> renames files according to modification rules specified on the command line" "rename"
  brew_install "Universal Ctags" "universal-ctags/universal-ctags/universal-ctags --HEAD"
  brew_install "YAML -> Process YAML documents from the CLI" "yq"
  brew_install "JSON -> Process JSON documents from the CLI" "jq"
  brew_install "Pandoc  -> Markup File Converter" "pandoc"
  brew_install "ShellCheck, a static analysis tool for shell scripts" "shellcheck"
  brew_install "Generic Colouriser for beautifying logfiles or output of commands" "grc"
  brew_install "LS_COLORS generator with a rich filetype datebase" "vivid"
  brew_install "Difftastic -> A structural diff that understands syntax" "difftastic"
  brew_install "W3M -> A Pager/text based browser" "w3m"
  brew_install "Htop -> Improved top (interactive process viewer)" "htop"
  brew_install "Ffmpeg -> Play, record, convert, and stream audio and video" "ffmpeg"
  brew_install "Spaceship -> Minimalistic, powerful and extremely customizable Zsh prompt" "spaceship"
  brew_install "LSD" "lsd"
  brew_install "Streamlink -> Streamlink is a command-line utility which pipes video streams from various services into a video player" "streamlink"
  brew_install "YAML Lint" "yamllint"
  brew_install "Rsync -> Utility that provides fast incremental file transfer" "rsync"

  brew_install "Taskwarrior -> Manage your TODO list from your command line" "task"
  brew_install "Timewarrior -> Command-line time tracking application" "timewarrior"
  brew_install "Tasksh -> Shell wrapper for Taskwarrior commands" "tasksh"

  brew_install "Xclip -> Access X11 clipboards from the command-line" "xclip"
  brew_install "Ncdu -> A disk usage analyzer with an ncurses interface" "ncdu"

  brew_install "Xo" "xo"
  brew_install "Mycli -> CLI for MySQL with auto-completion and syntax highlighting" "mycli"
  brew_install "Pgcli -> CLI for Postgres with auto-completion and syntax highlighting" "pgcli"
  brew_install "Usql" "usql" # install usql with "most" drivers

  brew_install "Reattach Namespace -> Accessing the Mac OS X pasteboard in tmux" "reattach-to-user-namespace"
  brew_install "Tealdeer -> A very fast implementation of tldr in Rust." "tealdeer" # rust implementation of `tldr`
  brew_install "ZK - a plain text note-taking assistant" "zk"
  brew_install "Vale -> A command-line tool that brings code-like linting to prose" "vale"
  brew_install "Proselint -> A linter is a computer program that, like a spell checker, scans through a document and analyzes it" "proselint"
  brew_install "Bfs -> A breadth-first version of the UNIX find command" "tavianator/tap/bfs"
  #   LSPs
  brew_install "A Language Server for Clojure(script)" "clojure-lsp"
  brew_install "Graph Easy  -> Convert or render graphs (as ASCII, HTML, SVG or via Graphviz)" "graph-easy"

    # A simple command line interface for the Mac App Store
  brew_install "MAS  -> Mac App Store command line interface" "mas"

  print_in_purple "\n   Desktop applications\n"
#   GUI
  brew_install "Chrome" "google-chrome" "homebrew/cask" "--cask"
  brew_install "Firefox" "firefox" "homebrew/cask" "--cask"
  brew_install "Kitty -> GPU-based terminal emulator" "kitty" "homebrew/cask" "--cask"
  brew_install "VSCode" "visual-studio-code" "homebrew/cask" "--cask"
#   Quicklook plugins
  brew_install "Qlcolorcode -> QuickLook plug-in that renders source code with syntax highlighting" "qlcolorcode" "homebrew/cask" "--cask"
  brew_install "Qlmarkdown -> QuickLook generator for Markdown files" "qlmarkdown" "homebrew/cask" "--cask"
  brew_install "Quicklook JSON -> QuickLook generator for JSON files" "quicklook-json" "homebrew/cask" "--cask"
  brew_install "Quicklook CSV -> QuickLook generator for CSV files" "quicklook-csv" "homebrew/cask" "--cask"
  brew_install "Qlstephen -> QuickLook generator for plain text files" "qlstephen" "homebrew/cask" "--cask"
  brew_install "Qlimagesize -> QuickLook generator to display image info and preview unsupported formats in QuickLook" "qlimagesize" "homebrew/cask" "--cask"
  brew_install "Qlprettypatch -> QuickLook generator for patch files" "qlprettypatch" "homebrew/cask" "--cask"
  brew_install "Qlvideo -> QuickLook generator for video files" "qlvideo" "homebrew/cask" "--cask"
  brew_install "Webp Quicklook -> QuickLook generator for WebP image files" "webpquicklook" "homebrew/cask" "--cask"

  print_in_purple "\n   Installing Apps from the App Store...\n"
  # The Unarchiver
  mas install 425424353

  finish
}

main
