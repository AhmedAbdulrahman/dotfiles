# Put this line on top to make keybinds work
bindkey -e

# byPass Ctrl+S through iTerm for VIM
stty -ixon

# --- Source 
[ -f $ZSH/oh-my-zsh.sh ] && source $ZSH/oh-my-zsh.sh
[ -f ~/.fzf.zsh   ] && source ~/.fzf.zsh
[ -f ~/.functions ] && source ~/.functions
[ -f ~/.aliases   ] && source ~/.aliases

[ -f ~/.zsh_fzf_extra   ] && source ~/.zsh_fzf_extra
[ -f ~/.zsh_plug   ] && source ~/.zsh_plug
[ -f ~/.zsh_theme   ] && source ~/.zsh_theme
[ -f ~/.zsh_misc   ] && source ~/.zsh_misc


# export FZF_DEFAULT_OPS="--extended"
# export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden --follow --smart-case --glob "!.git/*"'
# export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"