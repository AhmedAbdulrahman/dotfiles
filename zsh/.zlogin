(
  local config
  setopt LOCAL_OPTIONS EXTENDED_GLOB
  autoload -U zrecompile

  # zcompile the completion cache; siginificant speedup
  zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
  if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then
    zcompile "$zcompdump"
  fi
  # zcompile .zprofile
  zprofile="${ZDOTDIR:-$HOME}/.zprofile"
  if [[ -s "$zprofile" && (! -s "${zprofile}.zwc" || "$zprofile" -nt "${zprofile}.zwc") ]]; then
    zcompile "$zprofile"
  fi
  # zcompile .zshrc
  zshrc="${ZDOTDIR:-$HOME}/.zshrc"
  if [[ -s "$zshrc" && (! -s "${zshrc}.zwc" || "$zshrc" -nt "${zshrc}.zwc") ]]; then
      zcompile "$zshrc"
  fi

  #zcompile configurations
  for config in ${ZDOTDIR-$HOME}/config/^*.zwc*; do
      zrecompile -pq ${config}
  done;

  # zcompile custom completions
  zrecompile -pq ${ZDOTDIR:-$HOME}/completions/completions.zwc ${ZDOTDIR:-$HOME}/completions/^(*.*)(-.N)

  # zcompile autoloaded functions
  # zrecompile -pq ${ZDOTDIR:-$HOME}/functions/functions.zwc ${ZDOTDIR:-$HOME}/functions/^(*.*)(-.N)
) &!