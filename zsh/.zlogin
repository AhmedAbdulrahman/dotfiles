(
  local config
  setopt LOCAL_OPTIONS EXTENDED_GLOB
  autoload -U zrecompile

  # zcompile the completion cache; siginificant speedup
  zcompdump="${ZDOTDIR:-${HOME}/dotfiles/zsh}/.zcompdump"
  if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then
    zcompile "$zcompdump"
  fi
  # zcompile .zprofile
  zprofile="${ZDOTDIR:-${HOME}/dotfiles/zsh}/.zprofile"
  if [[ -s "$zprofile" && (! -s "${zprofile}.zwc" || "$zprofile" -nt "${zprofile}.zwc") ]]; then
    zcompile "$zprofile"
  fi
  # zcompile .zshrc
  zshrc="${ZDOTDIR:-${HOME}/dotfiles/zsh}/.zshrc"
  if [[ -s "$zshrc" && (! -s "${zshrc}.zwc" || "$zshrc" -nt "${zshrc}.zwc") ]]; then
      zcompile "$zshrc"
  fi

  #zcompile configurations
  for config in ${ZDOTDIR:-${HOME}/dotfiles/zsh}/config/^*.zwc*; do
      zrecompile -pq ${config}
  done;

  # zcompile custom completions
  zrecompile -pq ${ZDOTDIR:-${HOME}/dotfiles/zsh}/completions/completions.zwc ${ZDOTDIR:-${HOME}/dotfiles/zsh}/completions/^(*.*)(-.N)

  # zcompile autoloaded functions
  zrecompile -pq ${ZDOTDIR:-${HOME}/dotfiles/zsh}/functions/functions.zwc ${ZDOTDIR:-${HOME}/dotfiles/zsh}/functions/^(*.*)(-.N)
) &!
