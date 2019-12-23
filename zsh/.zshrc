# vim:ft=zsh:

# Anonymous function to create a closure to no leak local variables
() {

    # ---------------------------------------------
    # Z
    # ---------------------------------------------
    [[ -f "${HOMEBREW_PREFIX}/etc/profile.d/z.sh" ]] && source "${HOMEBREW_PREFIX}/etc/profile.d/z.sh"

    # ---------------------------------------------
    # FZF
    # ---------------------------------------------

    if [[ -f "${HOME}/.fzf.zsh" ]]; then
        source "${HOME}/.fzf.zsh"
    else
        echo "y" | "${HOMEBREW_PREFIX}/opt/fzf/install" --xdg --no-update-rc
    fi

    export VIM_FZF_LOG=$(git config --get alias.l 2>/dev/null | awk '{$1=""; print $0;}' | tr -d '\r')
    FZF_FILE_HIGHLIGHTER='cat {}'
    (( $+commands[rougify]   )) && FZF_FILE_HIGHLIGHTER='rougify'
    (( $+commands[coderay]   )) && FZF_FILE_HIGHLIGHTER='coderay'
    (( $+commands[highlight] )) && FZF_FILE_HIGHLIGHTER='highlight -O ansi -l {}'
    (( $+commands[bat]       )) && FZF_FILE_HIGHLIGHTER='bat --theme="OneHalfDark" --style=numbers,changes --wrap never --color always {}'
    export FZF_FILE_HIGHLIGHTER

    FZF_DIR_HIGHLIGHTER='ls -l --color=always'
    (( $+commands[tree] )) && FZF_DIR_HIGHLIGHTER='tree -CtrL2'
    (( $+commands[lsd]  )) && FZF_DIR_HIGHLIGHTER='lsd --color=always'
    export FZF_DIR_HIGHLIGHTER

    (( $+commands[iconful] )) && FZF_PATH_LOC='2..' || FZF_PATH_LOC=''
    export FZF_PATH_LOC

    typeset -AU __FZF
    if (( $+commands[fd] )); then
        __FZF[CMD]='fd --hidden --follow --no-ignore-vcs --exclude ".git/*" --exclude ".git" --exclude "node_modules/*" --exclude "tags"'
        __FZF[DEFAULT]="${__FZF[CMD]} --type f"
        __FZF[ALT_C]="${__FZF[CMD]} --type d ."
        __FZF[ALT_E]="${__FZF[CMD]} --type f"
    elif (( $+commands[rg] )); then
        __FZF[CMD]='rg --no-messages --no-ignore-vcs'
        __FZF[DEFAULT]="${__FZF[CMD]} --files"
    else
        __FZF[DEFAULT]='git ls-tree -r --name-only HEAD || find .'
    fi

    export FZF_DEFAULT_COMMAND="${__FZF[DEFAULT]}"  # FZF DEFAULT CMD
    export FZF_CTRL_T_COMMAND="${__FZF[CMD]} | iconful -f "    # FZF: Ctrl + T
    export FZF_ALT_C_COMMAND="${__FZF[ALT_C]} | iconful -d"  # FZF: ALT + C
    export FZF_ALT_E_COMMAND="${__FZF[ALT_E]} | iconful -f"  # FZF: ALT + E

    export FZF_DEFAULT_OPTS="
    --height 80%
    --tabstop 2 
    --extended
    --ansi
    --reverse
    --cycle
    --bind ctrl-s:toggle-sort
    --bind ?:toggle-preview
    --bind \"ctrl-y:execute-silent(ruby -e 'puts ARGV' {+} | pbcopy)+abort\"
    --bind 'alt-e:execute($EDITOR {} >/dev/tty </dev/tty)'
    --preview \"($FZF_FILE_HIGHLIGHTER {} || $FZF_DIR_HIGHLIGHTER {}) 2>/dev/null | head -200\"
    --preview-window right:60%
    --color=fg:#d0d0d0,bg:#25262e,hl:#d7005f
    --color=fg+:#d0d0d0,bg+:#25262e,hl+:#5fd7ff
    --color=info:#afaf87,prompt:#d7005f,pointer:#7edbca
    --color=marker:#ffa7c4,spinner:#ffa7c4
    "

    export FZF_CTRL_T_OPTS="
    --min-height 30 
    --preview \"($FZF_FILE_HIGHLIGHTER {$FZF_PATH_LOC} || $FZF_DIR_HIGHLIGHTER {$FZF_PATH_LOC}) 2>/dev/null | head -200\"
    --bind 'enter:execute(echo {$FZF_PATH_LOC})+abort'
    --bind 'alt-e:execute($EDITOR {$FZF_PATH_LOC} >/dev/tty </dev/tty)'
    --bind \"ctrl-y:execute-silent(ruby -e 'puts ARGV' {+$FZF_PATH_LOC} | pbcopy)+abort\"
    --preview-window right:70%
    --color=bg+:24
    --color=fg:#d0d0d0,bg:#25262e,hl:#5f87af
    --color=fg+:#d0d0d0,bg+:#25262e,hl+:#5fd7ff
    --color=info:#afaf87,prompt:#d7005f,pointer:#7edbca
    --color=marker:#ffa7c4,spinner:#ffa7c4
    "

    export FZF_CTRL_R_OPTS="
    --preview 'echo {}'
    --preview-window 'down:2:wrap'
    --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
    --header 'Press CTRL-Y to copy command into clipboard'
    --exact
    --expect=ctrl-x
    --border
    "
    export FZF_ALT_C_OPTS="
    --exit-0
    --bind 'enter:execute(echo {$FZF_PATH_LOC})+abort'
    --preview 'tree -C {} 2> /dev/null'
    --preview-window=right:60%
    "

    export FZF_ALT_E_OPTS="
    --preview \"($FZF_FILE_HIGHLIGHTER {$FZF_PATH_LOC} || $FZF_DIR_HIGHLIGHTER {$FZF_PATH_LOC}) 2>/dev/null | head -200\"
    --bind 'alt-e:execute($EDITOR {$FZF_PATH_LOC} >/dev/tty </dev/tty)'
    --bind \"ctrl-y:execute-silent(ruby -e 'puts ARGV' {+$FZF_PATH_LOC} | pbcopy)+abort\"
    --preview-window=down:60%
    "

    # ---------------------------------------------
    # HOMEBREW
    # ---------------------------------------------
    export HOMEBREW_INSTALL_BADGE="🏎"
    export HOMEBREW_NO_ANALYTICS=1
    export HOMEBREW_FORCE_BREWED_GIT=1

    # ---------------------------------------------
    # Direnv
    # ---------------------------------------------
    if [ $(command -v direnv) ]; then
    export NODE_VERSIONS="${HOME}/.node-versions"
    export NODE_VERSION_PREFIX=""
    eval "$(direnv hook zsh)"
    fi

    # ---------------------------------------------
    # Others
    # ---------------------------------------------
    export SSH_KEY_PATH="$HOME/.ssh/id_rsa"
    export BAT_CONFIG_PATH="${HOME}/.config/bat/config" # Bat
    # export RIPGREP_CONFIG_PATH="${HOME}/.rgrc"

    # ------------------------------------------------------
    # Make sure git completions are the good ones
    # For reference: https://github.com/github/hub/pull/1962
    # ------------------------------------------------------
    (
    if [ -e /usr/local/share/zsh/site-functions/_git ]; then
        command mv -f /usr/local/share/zsh/site-functions/{,disabled.}_git
    fi
    ) &!

    (( $+commands[thefuck] )) && source <(thefuck --alias 2>/dev/null)
    (( $+commands[pyenv]   )) && source <(pyenv init -)

    # Profile
    # Uncomment the line below and start a new shell. Don't forget to uncomment the
    # `zprof` portion on .zshenv
    # zprof
}