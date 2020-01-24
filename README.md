# Ahmed’s dotfiles

> Running [**iTerm2**](https://www.iterm2.com/) with custom [**Spaceship-zsh**](https://github.com/denysdovhan/spaceship-zsh-theme) theme.

The color scheme is [**Aylin**](https://github.com/AhmedAbdulrahman/aylin-iterm-theme) for _iTerm2_ and the font is [**Recursive**](https://www.recursive.design/) with [**DroidSansMono Nerd Font**](https://github.com/ryanoasis/nerd-fonts) as Non-ASCII Font

![Screenshot](assets/intro.png)

* [❓What's it](#whats-it)
* [📦 What's inside](#whats-in-it)
* [🔧 Setup Environment](#setup)
* [📚Resources](#setup)
* [📄 License](#license)

What's it
----------
This is where I keep all my configs and automated scripts that I use when I set up a new environment for macOS.

What's inside
-------------
A lot of stuff and you can check them out in the file browser above. Main components are:

- [`Homebrew`](https://brew.sh/): Used for managing and installing macOS dependencies and [`Cask`](https://github.com/caskroom/homebrew-cask) for managing and installing GUI apps like Chrome, Firefox, VSCode,...etc.
- [`Tmux`](http://tmux.sourceforge.net/): Used for pane and window management, copy-mode for navigating output, and session management make it a no-brainer for those who live in the terminal (and especially vim)
  ![Screenshot](assets/tmux.png)
- [`Neovim`](https://neovim.io): A drop-in replacement for Vim with my own customizations applied.
- [`ZSH`](http://www.zsh.org/): Shell with various customization:
  - [`🚀Spaceships ZSH`](https://github.com/denysdovhan/spaceship-prompt) as a prompt.
  - [`🌺ZPLUG`](https://zplug.sh) for dependency management.
  - ⚡️ Power up and beautify terminal with ZSH completions.
  - 💄 Syntax highlighting of commands.
  - ⌨️  Autosuggestions for most of commands.
  - 🕵️‍ Fuzzy Finder for VIM, Git and ZSH
  - 🏎 ZSH [`VIM`](./zsh/config/mappings.zsh) bindings for VIM nerds.
  - 🏎 Useful [`aliases`](./zsh/config/aliases.zsh).
  - 🛠 Custom [`Git config`](./files/.gitconfig), global [`.gitignore`](./files/.config/git/.gitignore) file and aliases.
- [`Hammerspoon`](https://www.hammerspoon.org/): a MacOS automation solution  using Lua to solve interesting problems in an easy way
- [`Newsboat`](https://newsboat.org/): an **RSS** feed reader for the text terminals.
- [`Files`]: directory where all extra configs live that will be symlink intoyour `$HOME`.
- [`Extras/bin`]: Anything in bin will get added to your `$PATH` and be made available everywhere.

Missing feature? 🍴 Fork this repo and make it better ❤️

Setup
-----

#### ⚠️ Disclaimer! ⚠️
These are **my** dotfiles, so **DO NOT** just run the `installer` snippet if you do not fully understand
[what it does](./installer.sh). Seriously, **DON'T**!

To set up the my `dotfiles`, run the appropriate snippet in the terminal:

| OS     | Snippet                                                                                                   |
| :----- | :-------------------------------------------------------------------------------------------------------- |
| `curl` | `bash -c "$(curl -fsSL https://raw.githubusercontent.com/AhmedAbdulrahman/dotfiles/master/installer.sh)"` |
| `wget` | `bash -c "$(wget https://raw.githubusercontent.com/AhmedAbdulrahman/dotfiles/master/installer.sh -O -)"`  |
| `git`  | `git clone git@github.com:AhmedAbdulrahman/dotfiles.git ~/dotfiles && source ~/dotfiles/installer.sh`     |

That's it! 🎉. When `installer` is run, you are prompted to choose one option from the list as seen below:
    ```bash
    What you want to do?

    1) All                      5) Install macOS Apps
    2) Install package manager  6) Change shell
    3) Clone Ahmeds dotfiles    7) Install XCode tools
    4) Symlink files            8) Quit

    Enter your choice (must be a number):               # Choose a number
    ```
The installer attempts to only select relevant script based on your choice. Say you choose `1` for `All`, then the process does a few things:

* Download `Homebrew` our main macOS dependency manager.
* Install Git if it's not installed in your machine.
* Install `ZSH` shell and set it as primary shell for your terminal.
* Clone my `dotfiles` repo on your computer (by default it will suggest `~/dotfiles`).
* Create some additional [directories][dirs].
* Symlink [`zsh`](zsh), [`vim`](vim), [`tmux`](tmux), [`files`](files), [`newsboat`](newsboat), [`extras/bin`](extras/bin) files.
* Install applications and command-line tools for [`macOS`](scripts/brew.zsh), [`Nodejs`](scripts/nodejs.zsh) including global packages, and [`Python`](scripts/python-packages.zsh) packages.
* Set custom [`macOS`](extras/macos/.macos) preferences.
* Install [`vim` plugins](vim/pack/bundle/start) as [`Git Submodules`](https://git-scm.com/book/en/v2/Git-Tools-Submodules).

## Essentials 👩‍💻☕️ - ZSH (Plugins)

### Theme
- [`spaceship`](https://github.com/denysdovhan/spaceship-prompt) — Minimalistic, powerful and extremely customizable Zsh prompt. It combines everything you may need for convenient work, without unnecessary complications, like a real spaceship.
- [`zsh-colored-man-pages`](https://github.com/ael-code/zsh-colored-man-pages) — colorize the man page

### Aliases
- [`npm`](https://github.com/igoradamenko/npm.plugin.zsh) — Provides completion as well as adding many useful aliases.
- [`yarn`](https://github.com/g-plane/zsh-yarn-autocompletions) — the same as for `npm`, but for `yarn`
- [`docker-aliases`](https://github.com/webyneter/docker-aliases) — Docker aliases
- [`alias-tips`](https://github.com/djui/alias-tips) — Cool utility that helps remembering those aliases you defined once ;)

### Completion & Autosuggestions
- [`zsh-better-npm-completion`](https://github.com/lukechilds/zsh-better-npm-completion) — Better completion utility for npm
- [`zsh-syntax-highlighting`](https://github.com/zsh-users/zsh-syntax-highlighting) — Provides syntax highlighting for the shell zsh. It enables highlighting of commands whilst they are typed at a zsh prompt into an interactive terminal
- [`zsh-completions`](https://github.com/zsh-users/zsh-completions) — Additional completion definitions for Zsh.
- [`zsh-autopair`](https://github.com/hlissner/zsh-autopair) — simple plugin that auto-closes, deletes and skips over matching delimiters in zsh intelligently
- [`zsh-history-substring-search`](https://github.com/zsh-users/zsh-history-substring-search) — Provides a history search where you can type in any part of any command from history and then press chosen keys, such as the UP and DOWN arrows, to cycle through matches.
- [`zsh-autosuggestions`](https://github.com/zsh-users/zsh-autosuggestions) — fast autosuggestions for zsh, It suggests commands as you type, based on command history.
- [`git-flow`](https://github.com/bobthecow/git-flow-completion) — Completion support for [git-flow](https://github.com/nvie/gitflow)

### Utils
- [`zsh-nvm`](https://github.com/lukechilds/zsh-nvm) — For installing, updating and loading NVM.
- [`zsh-sudo`](https://github.com/hcgraf/zsh-sudo) — `[Esc] [Esc]` to re-run previous command with sudo.
- [`forgit`](https://github.com/wfxr/forgit) — utility tool for git taking advantage of fuzzy finder fzf.
- [`wifi-password`](https://github.com/rauchg/wifi-password) — Small utility to get the password of the wifi you're on _macOS only_.
- [`translate-shell`](https://github.com/soimort/translate-shell) — Command-line translator using Google Translate, Bing Translator, Yandex.Translate.
- [`extract`](https://github.com/thetic/extract) — Extracts the archive file
- [`gitio`](https://github.com/denysdovhan/gitio-zsh) — A zsh plugin for generating a GitHub short URL using git.io
- [`z`](https://github.com/rupa/z) — Smart jump around plugin that tracks your most used directories, based on 'frecency'. After a short learning phase, z will take you to the most 'frecent' directory that matches ALL of the regexes given on the command line, in order.
- [`k`](https://github.com/supercrabtree/k) — Makes directory listings more readable, adding a bit of color and some git status information on files and directories.
- [`zsh-notify`](https://github.com/marzocchi/zsh-notify) — Desktop notifications for long-running commands in zsh.
- [`httpstat`](https://github.com/reorx/httpstat) — Visualizes curl(1) statistics in a way of beauty and clarity.
- [`almostontop`](https://github.com/Valiev/almostontop) — Utility that clears previous command output every time before new command executed in shell
- [`emoji-cli`](https://github.com/wfxr/emoji-cli) — CLI Emoji for FZF.
- [`iconful`](https://github.com/wfxr/emoji-cli) — Adds font icons (glyphs ★♨☢) to filetypes via ZSH FZF

Resources
---------

This repo is inspired and influenced by

- GitHub 💞 [`dotfiles`](http://dotfiles.github.io/)
- Niclas Pahlfer’s [`dotfiles`](https://github.com/Npahlfer)
- Mathias Bynens’ [`dotfiles`](https://github.com/mathiasbynens/dotfiles)
- Paul Irish’s [`dotfiles`](https://github.com/paulirish/dotfiles)
- Denys Dovhan’s [`dotfiles`](https://github.com/denysdovhan/dotfiles)
- Adam Eivy’s [`dotfiles`](https://github.com/atomantic/dotfiles)
- Matthew J Morrison’s [`dotfiles`](https://github.com/mattjmorrison/dotfiles)

License
-------

MIT © [`Ahmed Abdulrahman`](LICENSE.txt)
