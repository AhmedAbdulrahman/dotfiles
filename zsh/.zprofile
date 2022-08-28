# ---------------------------------------------
# .zprofile
# ---------------------------------------------
# This file should be used to set up the paths for the shell. This file
# should not produce any output.

# PATH Glob Options
# (N-/).... do not register if the directory does not exists
# N........ NULL_GLOB option (ignore path if it does not match the glob)
# n........ sort the output
# [-1]..... select the last item in the array
# -........ follow the symbol links
# /........ ignore files

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath manpath path

fpath=(
  ${ZDOTDIR:-$HOME}/functions(N-/)
  ${ZDOTDIR:-$HOME}/completions(N-/)
  /usr/local/share/zsh/site-functions(N-/)
  ${fpath}
)


autoload -Uz ${ZDOTDIR:-$HOME}/functions/**/*(N:t) promptinit
promptinit # enables prompt command which is useful to list installed prompts

# Get the original manpath, then modify it.
(( $+commands[manpath] )) && MANPATH="`manpath`"
manpath=(
    ${HOMEBREW_PREFIX:-/usr/local}/opt/*/libexec/gnuman(N-/)
    "$manpath[@]"
)

infopath=(
 /usr/local/share/info
 $infopath
)

# Set the the list of directories that cd searches.
cdpath=(
  $cdpath
)

# Set the list of directories that Zsh searches for programs.
path=(
  ${DOTFILES}/extras/bin(N-/)
  # ${CARGO_HOME}/bin(N-/)
  ${GOBIN}(N-/)
  $path
  /usr/local/{bin,sbin}
)

# NVM
# This is here because it needs to be set before NVM is loaded
NVM_LAZY_LOAD=true
NVM_COMPLETION=true

# Configurations
# The array is used to load the settings in the desired order
zconfig=(
	zplug
	aliases
	completion
	compdefs
	environment
	history
	widgets
	mappings
	prompt
)

for config (${ZDOTDIR:-${DOTFILES}/zsh}/config/${^zconfig}.zsh) source $config && unset config
