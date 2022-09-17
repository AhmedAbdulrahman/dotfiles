# Set neovim as default EDITOR if it's available, otherwise use vim
(( $+commands[nvim] )) && export EDITOR=nvim || export EDITOR=vim

export VISUAL=$EDITOR # For GUI
export NOTES_EDITOR=$EDITOR # For NOTES
export GIT_EDITOR=$EDITOR # For GIT

# ---------------------------------------------
# Set less or more as the default pager.
# ---------------------------------------------
if (( ${+commands[less]} )); then
    export PAGER=less
else
    export PAGER=more
fi

# Set MANPAGER based on $EDITOR
case $EDITOR in
    nvim) export MANPAGER="nvim -c 'set ft=man | set showtabline=1 | set laststatus=0' +Man!" ;;
     vim) export MANPAGER="/bin/sh -c \"col -b | vim -c 'set ft=man' -\"" ;;
       *) export MANPAGER=$PAGER ;;
esac

export MANWIDTH=120¬
