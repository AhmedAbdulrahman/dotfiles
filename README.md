# Ahmed’s dotfiles adapted for ZSH

> Running [**iTerm2**](https://www.iterm2.com/) with [**oh-my-zsh**](https://github.com/robbyrussell/oh-my-zsh) and [**Spaceship-zsh-theme**](https://github.com/denysdovhan/spaceship-zsh-theme).

The color scheme is [**iTerm2 - Snazzy**](https://github.com/sindresorhus/iterm2-snazzy) for _iTerm2_ and the font is [**Danke Mono**](https://dank.sh/)

![Screenshot](screenshot.png)

There are tons of useful things in here:

- ⚡️ Power up and beautify terminal with [“Oh My ZSH!”](http://ohmyz.sh/) is already built–in.
- [🚀 Spaceships ZSH](https://github.com/denysdovhan/spaceship-prompt) as a prompt.
- [🌺 zplug](https://zplug.sh) for dependency management.
- 💄 Syntax highlighting of commands.
- ⌨️ Autosuggestions for most of commands.
- 🕵️‍ Fuzzy Search for VIM, Git and history
- 🏎 Useful [aliases](./lib/aliases.zsh).
- Git config, global `.gitignore` file and aliases.

Missing feature? 🍴 Fork this repo and make it better!

## Installation

Dotfiles are installed by running one of the following commands in your terminal:

via `curl`

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/AhmedAbdulrahman/zsh-dotfiles/master/installer.sh)"
```

via `wget`

```bash
bash -c "$(wget https://raw.githubusercontent.com/AhmedAbdulrahman/zsh-dotfiles/master/installer.sh -O -)"
```

You will be prompt with few questions, answer based on your need then type what config file you want to install see below:

```bash
Enter files you would like to install separated by 'space' : zsh tmux vim
```

## License

MIT © [Ahmed Abdulrahman](https://github.com/AhmedAbdulrahman)
