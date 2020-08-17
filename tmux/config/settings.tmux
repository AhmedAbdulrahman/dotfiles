# Unbind default system defined prefi.
unbind C-b

# Set a new keybinding to C-Space
set -g prefix C-Space

# Bind 'C-a C-a' to send 'C-a'.
# Dont mess up with other ctrl-a options by pressing ctrl-a twice
bind Space send-prefix

# Default term.
# set-option -g default-terminal "screen-256color"
set-option -g default-terminal "xterm-256color"
# Enable vi style key bindings in command mode.
set-option -g mode-keys vi
set-option -g status-keys vi

# Mouse can be used to select panes, select windows (by clicking on the status
# bar), resize panes. For default bindings see `tmux list-keys`.
set-option -g mouse on
bind-key -n WheelUpPane if-shell -F -t = "#{mouse_any_flag}" "send-keys -M" "if -Ft= '#{pane_in_mode}' 'send-keys -M' 'select-pane -t=; copy-mode -e; send-keys -M'"
bind-key -n WheelDownPane select-pane -t= \; send-keys -M

# Time in milliseconds for which tmux waits after an escape.
set-option -g escape-time 0

# Keep commands history and set its limit.
set-option -g history-file ~/.tmux/cache/history
set-option -g history-limit 10000

# Start window numbers at 1 to match keyboard order with tmux window order.
set-option -g base-index 1
set-option -g pane-base-index 1

# Renumber windows sequentially after closing any of them.
set-option -g renumber-windows on

# Allow programs to change title using a escape sequence.
set-option -g allow-rename on

# Don't show "Activity in window X" messages.
set-option -g visual-activity off

# Enable supported focus events.
# set-option -g focus-events on

# Turn on automatic window renaming.
set-option -g automatic-rename on

# Terminal overrides.
set-option -g -a terminal-overrides ',xterm-256color:Tc' # True color support.
