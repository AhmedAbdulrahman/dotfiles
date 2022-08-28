# vim:ft=zsh:

# zmodload zsh/zprof
# Anonymous function to create a closure to no leak local variables
() {

	typeset -AU __FZF

	# Set Spaceship ZSH as a prompt
	prompt spaceship

    # ---------------------------------------------
    # Z
    # ---------------------------------------------
    [[ -f "${HOMEBREW_PREFIX}/etc/profile.d/z.sh" ]] && source "${HOMEBREW_PREFIX}/etc/profile.d/z.sh"

    # ---------------------------------------------
    # FZF
    # ---------------------------------------------

    if [[ -f "${XDG_CONFIG_HOME}/fzf/fzf.zsh" ]]; then
        source "${XDG_CONFIG_HOME}/fzf/fzf.zsh"
    else
        echo "y" | "${HOMEBREW_PREFIX}/opt/fzf/install" --xdg --no-update-rc
    fi

    export VIM_FZF_LOG=$(git config --get alias.l 2>/dev/null | awk '{$1=""; print $0;}' | tr -d '\r')

    FZF_DIR_HIGHLIGHTER='ls -l --color=always'
    (( $+commands[tree] )) && FZF_DIR_HIGHLIGHTER='tree -CtrL2'
    (( $+commands[lsd]  )) && FZF_DIR_HIGHLIGHTER='lsd --color=always'
    export FZF_DIR_HIGHLIGHTER

    (( $+commands[iconful] )) && FZF_PATH_LOC='2..' || FZF_PATH_LOC=''
    export FZF_PATH_LOC

    if (( $+commands[fd] )); then
		__FZF[CMD]="fd --hidden --follow --no-ignore-vcs -E '*.git' -E '*node_modules' -E '*.next' -E '*tags' -E '*dist' -E '.DS_Store'"
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
	export FZF_DEFAULT_OPTS="--prompt='» '--pointer='▶' --marker='✓ ' --min-height 30 --bind esc:cancel --height 50% --reverse --tabstop 2 --multi --color=bg+:-1 --preview-window wrap --cycle --bind '?:toggle-preview'"
    export FZF_PREVIEW_COMMAND="bat --style=numbers,changes --wrap never --color always {} || cat {} || tree -C {}"

	export FZF_CTRL_T_COMMAND="${__FZF[CMD]} | iconful -f "    # FZF: Ctrl + T
    export FZF_CTRL_T_OPTS="--preview '($FZF_PREVIEW_COMMAND) 2> /dev/null'"


	export FZF_ALT_C_COMMAND="${__FZF[ALT_C]} | iconful -d"  # FZF: ALT + C
    export FZF_ALT_C_OPTS="--preview 'tree -C {} 2> /dev/null'"

    export FZF_ALT_E_COMMAND="${__FZF[ALT_E]} | iconful -f"  # FZF: ALT + E

	export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview' --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort' --header 'Press CTRL-Y to copy command into clipboard' --border"

    export FZF_ALT_E_OPTS="
    --preview \"($FZF_FILE_HIGHLIGHTER {$FZF_PATH_LOC} || $FZF_DIR_HIGHLIGHTER {$FZF_PATH_LOC}) 2>/dev/null | head -200\"
    --bind 'alt-e:execute($EDITOR {$FZF_PATH_LOC} >/dev/tty </dev/tty)'
    --bind \"ctrl-y:execute-silent(ruby -e 'puts ARGV' {+$FZF_PATH_LOC} | pbcopy)+abort\"
    --preview-window=down:60%
    "

    # ------------------------------------------------------
    # Make sure git completions are the good ones
    # For reference: https://github.com/github/hub/pull/1962
    # ------------------------------------------------------
	if [ "$(uname)" = "Darwin" ]; then
		(
		if [ -e /usr/local/share/zsh/site-functions/_git ]; then
			command mv -f /usr/local/share/zsh/site-functions/{,disabled.}_git
		fi
		) &!
	fi

	if [[ -f ${HOME}/.zshrc.local ]]; then
		source $HOME/.zshrc.local
	else
		[[ -z "${HOMEBREW_GITHUB_API_TOKEN}" ]] && echo "⚠ HOMEBREW_GITHUB_API_TOKEN not set." && _has_unset_config=yes
		[[ -z "${GITHUB_TOKEN}" ]] && echo "⚠ GITHUB_TOKEN not set." && _has_unset_config=yes
		[[ ${_has_unset_config:-no} == "yes" ]] && echo "Set the missing configs in ~/.zshrc"
	fi

	# ---------------------------------------------
	# PYENV
	# ---------------------------------------------
	if [ $(command -v pyenv) ]; then
		export PYENV_ROOT="${HOME}/.pyenv"
		eval "$(pyenv init -)"
	fi

	(( $+commands[thefuck] )) && source <(thefuck --alias 2>/dev/null)

    # Profile
    # Uncomment the line below and start a new shell. Don't forget to uncomment the
    # `zprof` portion on .zshenv
    # zprof
}
