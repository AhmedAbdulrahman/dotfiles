# Use smart URL pasting and escaping.
autoload -Uz bracketed-paste-url-magic && zle -N bracketed-paste bracketed-paste-url-magic
autoload -Uz url-quote-magic && zle -N self-insert url-quote-magic

setopt AUTO_RESUME          # Treat single word simple commands without redirection as candidates for resumption of an existing job.
setopt INTERACTIVE_COMMENTS # Allow comments starting with `#` even in interactive shells.
setopt NO_FLOW_CONTROL      # disable start (C-s) and stop (C-q) characters
setopt CORRECT              # Suggest command corrections
setopt LONG_LIST_JOBS       # List jobs in the long format by default.
setopt NOTIFY               # Report the status of background jobs immediately, rather than waiting until just before printing a prompt.
setopt NO_BG_NICE           # Prevent runing all background jobs at a lower priority.
setopt NO_CHECK_JOBS        # Prevent reporting the status of background and suspended jobs before exiting a shell with job control. NO_CHECK_JOBS is best used only in combination with NO_HUP, else such jobs will be killed automatically.
setopt NO_HUP               # Prevent sending the HUP signal to running jobs when the shell exits.
setopt NO_BEEP              # Don't beep on erros (overrides /etc/zshrc in Catalina)

# Remove path separtor from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}

# sets the window title and updates upon directory change
# more work probably needs to be done here to support multiplexers
if (($+ztermtitle)); then
  case ${TERM} in
    xterm*|*rxvt)
      precmd() { print -Pn "\e]0;${ztermtitle}\a" }
      precmd  # we execute it once to initialize the window title
      ;;
  esac
fi

# ---------------------------------------------
# Locale : LANGUAGE must be set by en_US
# ---------------------------------------------
export LANGUAGE="en_US.UTF-8"
export LANG="${LANGUAGE}"
export LC_ALL="${LANGUAGE}"
export LC_CTYPE="${LANGUAGE}"

# ---------------------------------------------
# Set less or more as the default pager.
# ---------------------------------------------
if (( ! ${+PAGER} )); then
  if (( ${+commands[less]} )); then
    export PAGER=less
  else
    export PAGER=more
  fi
fi

# set the correct term with TMUX
export TERM=xterm-256color

# Better spell checking & auto correction prompt
export SPROMPT="zsh: correct %F{red}'%R'%f to %F{blue}'%r'%f [%B%Uy%u%bes, %B%Un%u%bo, %B%Ue%u%bdit, %B%Ua%u%bbort]? "

# Browser
if [ "$(uname)" = "Darwin" ]; then
  export BROWSER='open'
fi

# Editors
# Set neovim as default EDITOR if it's available, otherwise use vim
(( $+commands[nvim] )) && export EDITOR=nvim || export EDITOR=vim
export VISUAL=$EDITOR # For GUI
export GIT_EDITOR=$EDITOR # For GIT
export PAGER='less' # For PAGER

# Set MANPAGER based on $EDITOR
case $EDITOR in
    nvim) export MANPAGER="nvim +'set ft=man' -" ;;
     vim) export MANPAGER="/bin/sh -c \"col -b | vim -c 'set ft=man' -\"" ;;
       *) export MANPAGER='less' ;;
esac
export MANWIDTH=120¬

# # Default editor for local and remote sessions
# if [[ -n "$SSH_CONNECTION" ]]; then
#   # on the server
#   if [ command -v vim >/dev/null 2>&1 ]; then
#     export EDITOR='vim'
#   else
#     export EDITOR='vi'
#   fi
# else
#   export EDITOR='vim'
# fi

# Less
# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS='-F -g -i -M -R -S -w -X -z-4'

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

# ---------------------------------------------
# Temporary Files
# ---------------------------------------------
if [[ ! -d "$TMPDIR" ]]; then
  export TMPDIR="/tmp/$LOGNAME"
  mkdir -p -m 700 "$TMPDIR"
fi

TMPPREFIX="${TMPDIR%/}/zsh"

# ---------------------------------------------
# Custom env variables
# ---------------------------------------------
# if [[ ! -d "${PROJECTS}" ]]; then
#     export PROJECTS="${PROJECTS:-$HOME/Projects}"
#     mkdir -p ${PROJECTS}
# fi


# Ensure UID is exported so Docker can use it
export UID=$UID