skip_global_compinit=1


# LANGUAGE must be set by en_US
export LANGUAGE="en_US.UTF-8"
export LANG="${LANGUAGE}"
export LC_ALL="${LANGUAGE}"
export LC_CTYPE="${LANGUAGE}"

# - Exports
export ZSH=$HOME/.oh-my-zsh
export VISUAL=vim
export EDITOR="$VISUAL"
# export TERM=xterm-256color

# Extend $PATH without duplicates
_extend_path() {
  if ! $( echo "$PATH" | tr ":" "\n" | grep -qx "$1" ) ; then
    export PATH="$1:$PATH"
  fi
}

# Add custom bin to $PATH
[[ -d "$HOME/.bin" ]] && _extend_path "$HOME/.bin"
[[ -d "$HOME/.npm-global" ]] && _extend_path "$HOME/.npm-global/bin"
[[ -d "$HOME/.rvm/bin" ]] && _extend_path "$HOME/.rvm/bin"
[[ -d "$ZPLUG_BIN" ]] && _extend_path "$ZPLUG_BIN"
[[ -d "$HOME/.composer/vendor/bin": ]] && _extend_path "$HOME/.composer/vendor/bin" 

#export PATH="$HOME/bin:$PATH";
#export PATH="/usr/local/sbin:$PATH"
#export PATH="$HOME/.composer/vendor/bin:$PATH"

# # Extend $NODE_PATH
# if [ -d ~/.npm-global ]; then
#   export NODE_PATH="$NODE_PATH:$HOME/.npm-global/lib/node_modules"
# fi

# SSH
export SSH_KEY_PATH="$HOME/.ssh/id_rsa"


# Less
export LESS="-R -f -F -X -i -P ?f%f:(stdin). ?lb%lb?L/%L.. [?eEOF:?pb%pb\%..]"
export LESSCHARSET="utf-8"
# Pager
export PAGER="${commands[less]:-$PAGER}"


#  History {{{
if [ -z "$HISTFILE" ]; then
  HISTFILE=$HOME/.zsh_history         # The path to the history file.
fi

export HISTSIZE=100000               # History size in memory
export SAVEHIST=1000000              # The number of histsize
export LISTMAX=50                    # The size of asking history

case $HIST_STAMPS in
  "mm/dd/yyyy") alias history="fc -fl 1" ;;
  "dd.mm.yyyy") alias history="fc -El 1" ;;
  "yyyy-mm-dd") alias history="fc -il 1" ;;
  *) alias history='fc -l 1' ;;
esac

setopt EXTENDED_HISTORY              # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY            # Write to the history file immediately, not when the shell exits.
# setopt SHARE_HISTORY               # Share history between all sessions.
setopt HIST_IGNORE_SPACE             # Do not record an entry starting with a space.
setopt HIST_REDUCE_BLANKS            # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY                   # Do not execute immediately upon history expansion.
setopt HIST_BEEP                     # Beep when accessing nonexistent history.
# Do not add in root
[[ "$UID" == 0 ]] && unset HISTFILE && SAVEHIST=0
#  }}} History

#  FZF {{{
FZF_FILE_HIGHLIGHTER='cat'
(( $+commands[rougify]   )) && FZF_FILE_HIGHLIGHTER='rougify'
(( $+commands[coderay]   )) && FZF_FILE_HIGHLIGHTER='coderay'
(( $+commands[highlight] )) && FZF_FILE_HIGHLIGHTER='highlight -lO ansi'
(( $+commands[bat]       )) && FZF_FILE_HIGHLIGHTER='bat --color=always'
export FZF_FILE_HIGHLIGHTER

FZF_DIR_HIGHLIGHTER='ls -l --color=always'
(( $+commands[tree] )) && FZF_DIR_HIGHLIGHTER='tree -CtrL2'
(( $+commands[exa]  )) && FZF_DIR_HIGHLIGHTER='exa --color=always -TL2'
export FZF_DIR_HIGHLIGHTER

(( $+commands[iconful] )) && FZF_PATH_LOC='2..' || FZF_PATH_LOC=''
export FZF_PATH_LOC

# FZF: default
(( $+commands[rg]   )) && FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden --follow --smart-case --glob "!.git/*" 2>/dev/null'
(( $+commands[fd]   )) && FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git 2>/dev/null'
export FZF_DEFAULT_COMMAND
FZF_DEFAULT_OPTS="
--border
--height 90%
--extended
--ansi
--reverse
--cycle
--bind alt-p:preview-up,alt-n:preview-down
--bind ctrl-u:half-page-up
--bind ctrl-d:half-page-down
--bind alt-a:select-all,ctrl-r:toggle-all
--bind ctrl-s:toggle-sort
--bind ?:toggle-preview,alt-w:toggle-preview-wrap
--bind \"ctrl-y:execute-silent(ruby -e 'puts ARGV' {+} | pbcopy)+abort\"
--bind 'alt-e:execute($EDITOR {} >/dev/tty </dev/tty)'
--preview \"($FZF_FILE_HIGHLIGHTER {} || $FZF_DIR_HIGHLIGHTER {}) 2>/dev/null | head -200\"
--preview-window right:50%:hidden
"
export FZF_DEFAULT_OPTS

# FZF: Ctrl - T
FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
(( $+commands[iconful] )) && FZF_CTRL_T_COMMAND="$FZF_CTRL_T_COMMAND | iconful -f"
export FZF_CTRL_T_COMMAND
FZF_CTRL_T_OPTS="
--preview \"($FZF_FILE_HIGHLIGHTER {$FZF_PATH_LOC} || $FZF_DIR_HIGHLIGHTER {$FZF_PATH_LOC}) 2>/dev/null | head -200\"
--bind 'enter:execute(echo {$FZF_PATH_LOC})+abort'
--bind 'alt-e:execute($EDITOR {$FZF_PATH_LOC} >/dev/tty </dev/tty)'
--bind \"ctrl-y:execute-silent(ruby -e 'puts ARGV' {+$FZF_PATH_LOC} | pbcopy)+abort\"
--preview-window right:65%
"
export FZF_CTRL_T_OPTS

# FZF: Ctrl - R
FZF_CTRL_R_OPTS="
--preview 'echo {}'
--preview-window 'down:2:wrap'
--bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
--header 'Press CTRL-Y to copy command into clipboard'
--exact
--expect=ctrl-x
"
export FZF_CTRL_R_OPTS

# FZF: Alt - C
FZF_ALT_C_COMMAND="command find -L . -mindepth 1 \
    \\( -path '*/\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \\) \
    -prune -o -type d -print 2> /dev/null | cut -b3-"
(( $+commands[fd]      )) && FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git 2>/dev/null'
(( $+commands[blsd]    )) && FZF_ALT_C_COMMAND='blsd $dir | grep -v "^\.$"'
(( $+commands[iconful] )) && FZF_ALT_C_COMMAND="$FZF_ALT_C_COMMAND | iconful -d"
export FZF_ALT_C_COMMAND
export FZF_ALT_C_OPTS="
--exit-0
--bind 'enter:execute(echo {$FZF_PATH_LOC})+abort'
--preview '($FZF_DIR_HIGHLIGHTER {$FZF_PATH_LOC}) | head -200 2>/dev/null'
--preview-window=right:50%
"

# FZF: Alt - E
FZF_ALT_E_COMMAND="$FZF_DEFAULT_COMMAND"
(( $+commands[iconful] )) && FZF_ALT_E_COMMAND="$FZF_ALT_E_COMMAND | iconful -f"
export FZF_ALT_E_COMMAND
FZF_ALT_E_OPTS="
--preview \"($FZF_FILE_HIGHLIGHTER {$FZF_PATH_LOC} || $FZF_DIR_HIGHLIGHTER {$FZF_PATH_LOC}) 2>/dev/null | head -200\"
--bind 'alt-e:execute($EDITOR {$FZF_PATH_LOC} >/dev/tty </dev/tty)'
--bind \"ctrl-y:execute-silent(ruby -e 'puts ARGV' {+$FZF_PATH_LOC} | pbcopy)+abort\"
--preview-window right:50%
"
export FZF_ALT_E_OPTS
#  }}} FZF

_comp_options="${_comp_options/NO_warnnestedvar/}"