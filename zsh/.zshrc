# ---------------------------------------------
# .zshrc
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
    ${ZDOTDIR:-$HOME}/functions/functions.zwc(N-)
    ${ZDOTDIR:-$HOME}/completions/completions.zwc(N-)
    ${ZDOTDIR:-$HOME}/functions(N-/)
    ${ZDOTDIR:-$HOME}/completions(N-/)
    ${ZDOTDIR:-$HOME}/prompt/prompt.zwc(N-)
    ${ZDOTDIR:-$HOME}/prompt/functions(N-/)
    /opt/homebrew/share/zsh/site-functions(N-/)
    ${fpath}
)

() {
    setopt EXTENDED_GLOB
    autoload -Uz ${ZDOTDIR:-$HOME}/functions/^*.zwc*
    autoload -Uz ${ZDOTDIR:-$HOME}/completions/^*.zwc*

    autoload -U promptinit; promptinit
    # Set Spaceship ZSH as a prompt
    prompt spaceship
}

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
    ./bin(N-/)
    ./node_modules/.bin
    ${ZDOTDIR}/bin(N-/)
    ${HOME}/.bin/local(N-/)
    ${HOME}/.bin(N-/)
    ${HOME}/.cargo/bin(N-/)
    ${HOME}/.volta/bin(N-/) # https://volta.sh
    ${XDG_CONFIG_HOME}/yarn/global/node_modules/.bin(N-/)
    ${GOPATH}/bin(N-/)
    ${HOMEBREW_PREFIX:-/opt/homebrew}/opt/coreutils/libexec/gnubin(N-/)
    ${HOMEBREW_PREFIX:-/opt/homebrew}/opt/python/libexec/bin(N-/)
    ${HOMEBREW_PREFIX:-/opt/homebrew}/opt/findutils/libexec/gnubin(N-/)
    ${HOMEBREW_PREFIX:-/opt/homebrew}/opt/curl/bin(N-/)
    $HOME/Library/Python/3.*/bin(Nn[-1]-/)
    ${HOMEBREW_PREFIX:-/opt/homebrew}/{bin,sbin}(N-/)
    $path
)

# ┌────────────────┐
# │ Configurations │
# └────────────────┘
#
# The array is used to load the settings in the desired order
zconfig=(
    zplug
    completion
    compdefs
    environment
    gpg
    history
    mappings
    prompt
    editor
    aliases
    fzf
    direnv
)

for config (${ZDOTDIR:-$HOME}/config/${^zconfig}.zsh) source $config && unset config

# ┌────┐
# │ FZ │
# └────┘
export FZ_HISTORY_CD_CMD="_zlua"

#  ┌────────────────────────────────────────────────────────┐
#  │ Make sure git completions are the good ones            │
#  │ For reference: https://github.com/github/hub/pull/1962 │
#  └────────────────────────────────────────────────────────┘
if [ "$(uname)" = "Darwin" ]; then
    if [[ -d /opt/homebrew ]]; then
        (
        if [ -e /opt/homebrew/zsh/site-functions/_git ]; then
            command mv -f /opt/homebrew/share/zsh/site-functions/{,disabled.}_git 2>/dev/null
            command mv -f /opt/homebrew/share/zsh/site-functions/{,disabled.}git-completion.bash 2>/dev/null
        fi
        ) &!
    fi

    if [[ -d /usr/local ]]; then
        (
        if [ -e /usr/local/share/zsh/site-functions/_git ]; then
            command mv -f /usr/local/share/zsh/site-functions/{,disabled.}_git 2>/dev/null
            command mv -f /usr/local/share/zsh/site-functions/{,disabled.}git-completion.bash 2>/dev/null
        fi
        ) &!
    fi


fi

# ┌────────────────────┐
# │ Load local configs │
# └────────────────────┘

if [[ -f ${HOME}/.zshrc.local ]]; then
    source $HOME/.zshrc.local
else
    [[ -z "${HOMEBREW_GITHUB_API_TOKEN}" ]] && echo "⚠ HOMEBREW_GITHUB_API_TOKEN not set." && _has_unset_config=yes
    [[ -z "${GITHUB_TOKEN}" ]] && echo "⚠ GITHUB_TOKEN not set." && _has_unset_config=yes
    [[ ${_has_unset_config:-no} == "yes" ]] && echo "Set the missing configs in ~/.zshrc"
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
