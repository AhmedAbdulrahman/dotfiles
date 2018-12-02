# Load Theme and disable extra stuff

# byPass Ctrl+S through iTerm for VIM
stty -ixon

#Inject profiling cod (for Debugging measure startup time)
zmodload zsh/zprof

# Theme Setting
ZSH_THEME="spaceship"
echo -e "\033]6;1;bg;red;brightness;40\a"
echo -e "\033]6;1;bg;green;brightness;44\a"
echo -e "\033]6;1;bg;blue;brightness;52\a"

SPACESHIP_CHAR_SYMBOL='❯'
SPACESHIP_CHAR_SUFFIX=' '
SPACESHIP_PACKAGE_SHOW=true
SPACESHIP_NODE_SHOW=false
SPACESHIP_BATTERY_SHOW='always'
DEFAULT_USER=$USER


# --- Source 
source $ZSH/oh-my-zsh.sh
source $HOME/.functions
source $HOME/.aliases

# Plugins to load
plugins=(git sudo zsh-syntax-highlighting zsh-autosuggestions)

# Configures history options
if [ -z "$HISTFILE" ]; then
    HISTFILE=$HOME/.zsh_history
fi

HISTSIZE=10000
SAVEHIST=10000

# Show history
case $HIST_STAMPS in
  "mm/dd/yyyy") alias history='fc -fl 1' ;;
  "dd.mm.yyyy") alias history='fc -El 1' ;;
  "yyyy-mm-dd") alias history='fc -il 1' ;;
  *) alias history='fc -l 1' ;;
esac

setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups # ignore duplication command history list
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history # share command history data

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_OPS="--extended"
export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden --follow --smart-case --glob "!.git/*"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"