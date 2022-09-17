typeset -AU __FZF

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

[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh