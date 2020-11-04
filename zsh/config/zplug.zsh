# ---------------------------------------------
# ZPLUG Initialization
# ---------------------------------------------
# Install zplug if it's doesn't exist, install it
if [[ ! -d ~/.zplug ]]; then
    if (( $+commands[git] )); then
        echo "Installing zplug"
        git clone --recursive --depth 1  https://github.com/zplug/zplug.git ~/.zplug
        source ~/.zplug/init.zsh
        zplug update
    else
        echo 'Git not found! Please install git to make this work.' >&2
        exit 1
    fi
else
    source ~/.zplug/init.zsh
fi
# ------------------------------------------------------------------------------
# Dependencies
# ------------------------------------------------------------------------------

# source "$ZPLUG_HOME/init.zsh"
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# For installing, updating and loading NVM
zplug "lukechilds/zsh-nvm"

# Toggle "sudo" before the current/previous command by pressing [ESC][ESC]
zplug "hcgraf/zsh-sudo", from:github
zplug "zsh-users/zsh-completions", from:github
zplug "hlissner/zsh-autopair", defer:2, from:github
zplug "zsh-users/zsh-history-substring-search", from:github
zplug 'bobthecow/git-flow-completion', from:github
# Command-line translator using Google Translate, Bing Translator, Yandex.Translate
zplug 'soimort/translate-shell', at:'develop', from:github
# Colorifies man pages
zplug "ael-code/zsh-colored-man-pages", from:github
# Extracts archive file
zplug "thetic/extract", from:github
# Add npm aliases
zplug "igoradamenko/npm.plugin.zsh", from:github
# Adds tab completion for npm
zplug "lukechilds/zsh-better-npm-completion", defer:2, from:github
# Add autocompletions for yarn add, yarn remove and yarn run.
zplug "g-plane/zsh-yarn-autocompletions", hook-build:"./zplug.zsh", defer:2, from:github
# Generates a GitHub short URL using git.io
zplug "denysdovhan/gitio-zsh", as:command, use:"gitio.zsh", rename-to:"gitio", from:github
# People ask you for the Wi-Fi password. Answer quickly. macOS only
if [ "$(uname)" = "Darwin" ]; then
    zplug "rauchg/wifi-password", as:command, use:"wifi-password.sh", rename-to:"wifi-password", from:github
fi
# Desktop notifications for long-running commands in zsh.
zplug "marzocchi/zsh-notify", from:github
# Adds fuzzy search to tab completion of z
zplug "changyuheng/fz", defer:1, from:github
# Tracks your most used directories, based on 'frecency'
zplug "rupa/z", use:z.sh, from:github
# Helps remembering those shell aliases and Git aliases
zplug "djui/alias-tips", from:github
# Clears previous command output every time before new command executed in shell
zplug "Valiev/almostontop", from:github
zplug "wfxr/emoji-cli", as:command, use:'emojify|fuzzy-emoji', from:github
# httpstat visualizes curl(1) statistics in a way of beauty and clarity.
zplug "reorx/httpstat", as:command, use:'(httpstat).py', rename-to:'$1', from:github

# The best-lookin' diffs. 🎉
# zplug 'so-fancy/diff-so-fancy', \
#     as:command, use:diff-so-fancy, \
#     hook-build:'git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"'

zplug 'wfxr/zplug-rm', lazy:yes, from:github
zplug 'wfxr/iconful', as:command, use:'(iconful).sh', rename-to:'$1', from:github
# Utility tool for git taking advantage of fuzzy finder fzf.
zplug 'wfxr/forgit', defer:1
forgit_log=log
forgit_diff=diff
forgit_add=add
forgit_reset_head=grh
forgit_ignore=ignore
forgit_restore=cof
# forgit_stash_show=stash, Create custom stash function
FORGIT_FZF_DEFAULT_OPTS="
--exact
--border
--cycle
--reverse
--height '100%'
--preview-window 'down:20:wrap'
"

# Syntax highlighting for the shell ZSH
zplug "zsh-users/zsh-syntax-highlighting", defer:2, from:github
typeset -ga ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
typeset -gA ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[alias]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=green,underline'
ZSH_HIGHLIGHT_STYLES[function]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[command]='fg=green'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=green,underline'
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=green,italic'
ZSH_HIGHLIGHT_STYLES[path]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[path_pathseparator]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[path_prefix]='none'
ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]='none'
ZSH_HIGHLIGHT_STYLES[globbing]='bg=black'
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='none'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='none'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=blue'
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=blue'
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=blue'
ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]='fg=blue'
ZSH_HIGHLIGHT_STYLES[assign]='none,underline'
ZSH_HIGHLIGHT_STYLES[redirection]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[comment]='fg=black'
ZSH_HIGHLIGHT_STYLES[arg0]='default'
ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]='bg=black'	# brackets

# Suggests commands as you type based on history and completions.
zplug "zsh-users/zsh-autosuggestions", from:github
ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS=(vi-forward-word)
ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=(vi-forward-char)
ZSH_AUTOSUGGEST_EXECUTE_WIDGETS=()
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
ZSH_AUTOSUGGEST_ORIGINAL_WIDGET_PREFIX='autosuggest-orig-'
ZSH_AUTOSUGGEST_STRATEGY=('history')
ZSH_AUTOSUGGEST_CLEAR_WIDGETS=(
        history-search-forward
        history-search-backward
        history-beginning-search-forward
        history-beginning-search-backward
        history-substring-search-up
        history-substring-search-down
        up-line-or-beginning-search
        down-line-or-beginning-search
        up-line-or-history
        down-line-or-history
        accept-line
    )
ZSH_AUTOSUGGEST_IGNORE_WIDGETS=(
        orig-\*
        beep
        run-help
        set-local-history
        which-command
        yank
        yank-pop
    )

    # Manage local plugins/completions/etc
    # zplug "$ZDOTDIR/aliases", from:local

# Conditionally Install plugins
(( $+commands[docker]     )) && zplug "webyneter/docker-aliases", use:docker-aliases.plugin.zsh
(( $+commands[tmuxinator] )) && zplug "plugins/tmuxinator", from:oh-my-zsh, lazy:yes
(( $+commands[jq]         )) && zplug "stedolan/jq", as:command, from:gh-r, rename-to:jq

# Apply ZPLUG
# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install ZSH plugins? [y/N]: "
    read -q && echo && zplug install
fi

# Then, source plugins and add commands to $PATH
zplug load
