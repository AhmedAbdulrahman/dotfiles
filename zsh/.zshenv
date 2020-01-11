# ---------------------------------------------
# Profile
# ---------------------------------------------
# Uncomment the line below and start a new shell. Don't forget to uncomment the
# `zprof` on .zshrc
# zmodload zsh/zprof

# set -o noclobber

# # True color
# export COLORTERM=truecolor

# ---------------------------------------------
# Environment
# ---------------------------------------------
# export ZDOTDIR="${${(%):-%N}:A:h}"
export ZDOTDIR="$HOME/.zsh"
export ZPLUG_HOME="${HOME}/.zplug"
export ZPLUG_THREADS=32
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_DATA_HOME=${XDG_DATA_HOME_HOME:-$HOME/.local/share}
# export ZSH=$HOME/.oh-my-zsh

# ---------------------------------------------
# Homebrew
# ---------------------------------------------
export HOMEBREW_PREFIX=${HOMEBREW_PREFIX:-"/usr/local"}
export HOMEBREW_CELLAR=${HOMEBREW_CELLAR:-"/usr/local/Cellar"}
export HOMEBREW_REPOSITORY=${HOMEBREW_REPOSITORY:-"/usr/local/Homebrew"}

# ---------------------------------------------
# Ripgrep
# ---------------------------------------------
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

# ---------------------------------------------
# Other useful environment settings
# ---------------------------------------------
export OSTYPE=$(uname -s)
export HOSTNAME=$(hostname)
export DOTFILES="${HOME}/dotfiles"
export GOPATH="${HOME}/.go"
export GOBIN="${GOPATH}/bin"
export PROJECTS="${HOME}/Projects"
export NOTES_DIR="${HOME}/Documents/notes"

# Ensure that a non-login, non-interactive shell has a defined environment.
# (Only once) if it was not sourced before, becuase .zshenv is always sourced
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi
