# ---------------------------------------------
# Profile
# ---------------------------------------------
# Uncomment the line below and start a new shell. Don't forget to uncomment the
# `zprof` on .zshrc
# zmodload zsh/zprof

# set -o noclobber

# True color
export COLORTERM='truecolor'

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
export HOMEBREW_INSTALL_BADGE="🍄"
export HOMEBREW_PREFIX=${HOMEBREW_PREFIX:-"/usr/local"}
export HOMEBREW_CELLAR=${HOMEBREW_CELLAR:-"/usr/local/Cellar"}
export HOMEBREW_REPOSITORY=${HOMEBREW_REPOSITORY:-"/usr/local/Homebrew"}
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_FORCE_BREWED_GIT=1

# ---------------------------------------------
# Telemetry
# ---------------------------------------------
export DO_NOT_TRACK=1
export GATSBY_TELEMETRY_DISABLED=1

# ---------------------------------------------
# Python
# ---------------------------------------------
export PYTHONSTARTUP="${HOME}/.pyrc.py"

# ---------------------------------------------
# Direnv
# ---------------------------------------------
if [ $(command -v direnv) ]; then
   export NODE_VERSIONS="${HOME}/.node-versions"
   export NODE_VERSION_PREFIX=""
   eval "$(direnv hook zsh)"
fi

# ---------------------------------------------
# PYENV
# ---------------------------------------------
if [ $(command -v pyenv) ]; then
	export PYENV_ROOT="${HOME}/.pyenv"
	eval "$(pyenv init - zsh)"
fi

# ---------------------------------------------
# HUB
# ---------------------------------------------
if [ $(command -v hub) ]; then
	eval "$(hub alias -s)"
fi

# ---------------------------------------------
# Others
# ---------------------------------------------
export BAT_CONFIG_PATH="${HOME}/.batrc"
export RIPGREP_CONFIG_PATH="${HOME}/.rgrc"


# ---------------------------------------------
# Environment settings
# ---------------------------------------------
export OSTYPE=$(uname -s)
export HOSTNAME=$(hostname)
export DOTFILES="${HOME}/dotfiles"
export GOPATH="${HOME}/.go"
export GOBIN="${GOPATH}/bin"
export PROJECTS="${HOME}/Projects"
export NOTES_DIR="${HOME}/Documents/notes"
export GPG_TTY=`tty`

# Ensure that a non-login, non-interactive shell has a defined environment.
# (Only once) if it was not sourced before, becuase .zshenv is always sourced
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi
