# if it's a dumb terminal, return.
if [[ ${TERM} == 'dumb' ]]; then
  return 1
fi

# I have <C-s> vim mapping for saving, and we need to byPass Ctrl+S through iTerm for VIM
stty -ixon

# Bind the keys
bindkey -v

# Insert Mode
bindkey -M viins '^K' up-history # ^K to previous command.
bindkey -M viins '^J' down-history # ^J to next command.
bindkey -M viins '^F' vi-forward-char # Go forward char or complete current completion.
bindkey -M viins '^U' backward-kill-line # Kill line backwards.
bindkey -M viins '^?' backward-delete-char # Delete left char with backspace key.
bindkey -M viins '^B' backward-kill-word # Delete a WORD backward.
bindkey -M viins '^[[3~' delete-char # Ensure delete key always delete forward.

# Normal Mode
bindkey -M vicmd 'j' down-line # Override down-line-or-history.
bindkey -M vicmd 'k' up-line # Override up-line-or-history.
bindkey -M vicmd '^K' up-history # ^K to previous command.
bindkey -M vicmd '^J' down-history # ^J to next command.
bindkey -M vicmd 'H' vi-beginning-of-line # Go beginning of line.
bindkey -M vicmd 'L' vi-end-of-line # Go end of line.
bindkey -M vicmd 'sr' change-surround # Change surround operator.
bindkey -M vicmd 'sd' delete-surround # Delete surround operator.
bindkey -M vicmd 'sa' add-surround # Add surround operator.
bindkey -M vicmd '^Y' custom-tmux-scroll-up # Activate tmux copy-mode and scroll up depending on key stroke.
bindkey -M vicmd '^U' custom-tmux-scroll-up # Activate tmux copy-mode and scroll up depending on key stroke.
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
# Visual Mode
bindkey -M visual 'H' vi-beginning-of-line # Go beginning of line.
bindkey -M visual 'L' vi-end-of-line # Go end of line.
bindkey -M visual 'S' add-surround # Add surround.
foreach char ({a,i}{\',\",\`}) { bindkey -M visual $char select-quoted } && unset char # Text objects for delimiters.
foreach char ({a,i}${(s..)^:-'()[]{}<>bB'}) { bindkey -M visual $char select-bracketed } && unset char # Text objects for pairs of brackets.

# Operator Mode
bindkey -M viopp 'H' vi-beginning-of-line # Go beginning of line.
bindkey -M viopp 'L' vi-end-of-line # Go end of line.
foreach char ({a,i}{\',\",\`}) { bindkey -M viopp $char select-quoted } && unset char # Text objects for delimiters.
foreach char ({a,i}${(s..)^:-'()[]{}<>bB'}) { bindkey -M viopp $char select-bracketed } && unset char # Text objects for pairs of brackets.

# Completion Mode
bindkey -M menuselect '^?' undo # Backspace for deleting suggesting completion as a whole.
bindkey -M menuselect '+' accept-and-hold # Accept the selection but keep the completion list open.
bindkey -M menuselect '^K' up-line-or-history # Navigate up completion.
bindkey -M menuselect '^J' down-line-or-history # Navigate down completion.
bindkey -M menuselect '^L' forward-char # Navigate right completion.
bindkey -M menuselect '^H' backward-char # Navigate left completion.
bindkey -M menuselect '^I' down-line-or-history # <Tab> to selection completion forward.
bindkey -M menuselect '^[[Z' reverse-menu-complete # <S-Tab> to select completion backward.

# Remove ^G (list-expand) so we can use our fzf-widgets
bindkey -r '^G'

# ZLE hooks for prompt's vi mode status
function zle-keymap-select zle-line-init zle-line-finish {
    case "${KEYMAP}" in
        main|viins)
            printf '\033[6 q' # line cursor
            ;;
        vicmd)
            printf '\033[2 q' # block cursor
            ;;
    esac
}

zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select

# Ensure no delay when changing modes
export KEYTIMEOUT=1

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd '!' edit-command-line

# FZF Folder Widget
bindkey '^q' fzf-cd-widget
