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
  ${ZDOTDIR:-$HOME}/completions/completions.zwc(N-)
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
    ${HOMEBREW_ROOT:-/usr/local}/opt/*/libexec/gnuman(N-/)
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
  ./bin(N-/)
  ./node_modules/.bin
  ${ZDOTDIR:-$HOME}/bin(N-/)
  ${HOME}/.bin/local(N-/)
  ${HOME}/.bin(N-/)
  ${HOME}/.cargo/bin(N-/)
  ${HOMEBREW_PREFIX}/opt/python/libexec/bin(N-/)
  ${HOMEBREW_PREFIX}/{bin,sbin}(N-/)
  ${HOMEBREW_PREFIX}/opt/curl/bin(N-/)
  ${HOMEBREW_PREFIX}/opt/openssl@*/bin(Nn[-1]-/)
  ${HOMEBREW_PREFIX}/opt/gnu-sed/libexec/gnubin(N-/)
  ${HOMEBREW_PREFIX}/opt/coreutils/libexec/gnubin(N-/)
  ${XDG_CONFIG_HOME}/yarn/global/node_modules/.bin(N-/)
  ${GOBIN}(N-/)
  $HOME/Library/Python/3.*/bin(Nn[-1]-/)
  $HOME/Library/Python/2.*/bin(Nn[-1]-/)
  ${HOMEBREW_PREFIX}/opt/ruby/bin(N-/)
  ${HOMEBREW_PREFIX}/lib/ruby/gems/*/bin(Nn[-1]-/)
  ${HOMEBREW_CELLAR}/git/*/share/git-core/contrib/git-jump(Nn[-1]-/)
  $path
)

# NVM
# This is here because it needs to be set before NVM is loaded
NVM_LAZY_LOAD=true

# Configurations
# The array is used to load the settings in the desired order
zconfig=(
	aliases
	environment
	prompt
	completion
  compdefs
	history
  widgets
	mappings
  zplug
)

for config (${ZDOTDIR:-$HOME}/config/${^zconfig}.zsh) source $config && unset config