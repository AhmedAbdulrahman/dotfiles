
# if it's a dumb terminal, return.
if [[ ${TERM} == 'dumb' ]]; then
  return 1
fi

# load and initialize the completion system
autoload -Uz compinit && compinit -C -d "${XDG_CACHE_HOME:-${HOME}}/${zcompdump_file:-.zcompdump}"

# ZSH options
setopt ALWAYS_TO_END    # If a completion is performed with the cursor within a word, and a full completion is inserted, the cursor is moved to the end of the word
setopt AUTO_MENU        # Automatically use menu completion after the second consecutive request for completion
setopt AUTO_LIST        # Automatically list choices on an ambiguous completion.
setopt PATH_DIRS        # Perform a path search even on command names with slashes in them.
setopt COMPLETE_ALIASES # Prevent aliases from being substituted before completion is attempted.
setopt COMPLETE_IN_WORD # Attempt to start completion from both ends of a word.
setopt GLOB_COMPLETE    # Don't insert anything resulting from a glob pattern, show completion menu.
setopt LIST_PACKED      # Try to make the completion list smaller by drawing smaller columns.
setopt MENU_COMPLETE    # Instead of listing possibilities, select the first match immediately.
unsetopt CASE_GLOB      # Make globbing (filename generation) not sensitive to case.
unsetopt LIST_BEEP      # Don't beep on an ambiguous completion.
# Pass bad arguments directly to commands, so ZSH won't complain
# https://github.com/robbyrussell/oh-my-zsh/issues/449#issuecomment-6973326
unsetopt NOMATCH

# Completing Groping
# Use completion menu for completion when available.
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:matches' group yes
zstyle ':completion:*' rehash true # When new programs is installed, auto update without reloading.
zstyle ':completion:*:options' description yes
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format '%F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format '%F{purple}-- %d --%f'
zstyle ':completion:*:warnings' format '%F{red}-- no matches found --%f'
zstyle ':completion:*' format '%F{yellow}-- %d --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
# zstyle ':completion:*:descriptions' format '%F{yellow}Completing %B%d%b%f'

# Completing misc
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list
zstyle ':completion:*:*files' ignored-patterns '*?.o' '*?~' '*\#'
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec)|prompt_*)' # ignore useless commands and functions
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters # completion sorting

# enable caching
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path "${ZDOTDIR:-${HOME}}/.zcompcache"

# history
zstyle ':completion:*:history-words' stop yes
zstyle ':completion:*:history-words' remove-all-dups yes
zstyle ':completion:*:history-words' list false
zstyle ':completion:*:history-words' menu yes

# Directory
zstyle ':completion:*:cd:*' ignore-parents parent pwd
# directories
if (( ! ${+LS_COLORS} )); then
  # Locally use same LS_COLORS definition from utility module, in case it was not set
  local LS_COLORS='di=1;34:ln=35:so=32:pi=33:ex=31:bd=1;36:cd=1;33:su=30;41:sg=30;46:tw=30;42:ow=30;43'
fi
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS} # Match dircolors with completion schema.
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'expand'
zstyle ':completion:*' squeeze-slashes true

# Man
zstyle ':completion:*' list-separator '->'
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true

# ignore multiple entries.
zstyle ':completion:*:(rm|kill|diff):*' ignore-line other
zstyle ':completion:*:rm:*' file-patterns '*:all-files'

# ignore specific files when autocompleting for specific commands
#...package-lock.json and yarn.lock
zstyle ':completion:*:*:(nvim|vim|e|l|less):*' file-patterns '^(package-lock.json|yarn.lock):source-files' '*:all-files'

zstyle ':notify:*' error-icon "https://media3.giphy.com/media/10ECejNtM1GyRy/200_s.gif"
zstyle ':notify:*' error-title "wow such #fail"
zstyle ':notify:*' success-icon "https://s-media-cache-ak0.pinimg.com/564x/b5/5a/18/b55a1805f5650495a74202279036ecd2.jpg"
zstyle ':notify:*' success-title "very #success. wow"
zstyle ':notify:*' error-sound "Glass"
zstyle ':notify:*' success-sound "default"
zstyle ':notify:*' activate-terminal yes
zstyle ':notify:*' blacklist-regex 'find|git'
zstyle ':notify:*' enable-on-ssh yes
zstyle ':notify:*' always-check-active-window yes



# Menu select
zmodload -i zsh/complist
