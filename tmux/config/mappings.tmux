# Unbind default system defined prefi.
unbind-key C-b

# Set a new keybinding to C-Space
set -g prefix C-Space

# Bind 'C-a C-a' to send 'C-a'.
# Dont mess up with other ctrl-a options by pressing ctrl-a twice
bind-key C-a send-prefix

# Edit tmux.conf in default $EDITOR
bind-key e new-window -n '~/.tmux.conf' "zsh -c '\${EDITOR:-nvim} ~/.tmux.conf && tmux source ~/.tmux.conf && tmux display \"~/.tmux.conf sourced\"'"

# Reload configuration.
unbind r
bind-key r \
	source-file ~/.tmux.conf \; \
	display-message ' (!) ~/.tmux.conf reloaded.'

# Vim style pane selection
bind-key h select-pane -L
bind-key j select-pane -D
bind-key k select-pane -U
bind-key l select-pane -R

# Use Alt-Vim keys without prefix key to switch panes 
bind-key -n M-h select-pane -L
bind-key -n M-j select-pane -D
bind-key -n M-k select-pane -U
bind-key -n M-l select-pane -R

# Switch windows.
bind-key -n M-p select-window -t :- # Previous window.
bind-key -n M-n select-window -t :+ # Next window.

# Toggle zoom.
bind-key -n M-z resize-pane -Z

# Split pane with same directory.
unbind-key '"'
unbind-key %
bind-key - split-window -v -c '#{pane_current_path}'
bind-key \ split-window -h -c '#{pane_current_path}'
bind-key _ split-window -fv -c '#{pane_current_path}' # Full width.
bind-key | split-window -fh -c '#{pane_current_path}' # Full height.
# Or use vim-like keys for splits and windows
bind-key v split-window -h -c "#{pane_current_path}"
bind-key s split-window -v -c "#{pane_current_path}"

# Resize panes.
unbind-key C-Up
unbind-key C-Down
unbind-key C-Left
unbind-key C-Right
bind-key -n M-H resize-pane -L 2
bind-key -n M-J resize-pane -D 1
bind-key -n M-K resize-pane -U 1
bind-key -n M-L resize-pane -R 2

# Vim-like key bindings for pane navigation (default uses cursor keys)
bind-key -n M-Left select-pane -L
bind-key -n M-Right select-pane -R
bind-key -n M-Up select-pane -U
bind-key -n M-Down select-pane -D

# Toggle pane full screen
bind-key Z resize-pane -Z

# Move panes.
unbind-key {
unbind-key }
bind-key -r H swap-pane -U
bind-key -r L swap-pane -D

# Kill panes without prompt.
bind-key X kill-pane

# Pressing Ctrl+Shift+Left (will move the current window to the left. Similarly
# right. No need to use the modifier (C-b).
bind-key -n C-S-Left swap-window -t -1
bind-key -n C-S-Right swap-window -t +1

bind-key -n S-Right next-window
bind-key -n S-Left previous-window

# Kill windows without prompt.
unbind-key &
bind-key x kill-window

# Enter copy mode.
unbind-key [
bind-key -n M-v copy-mode

# Make the current window the first window
bind-key T swap-window -t 1

# find session
bind C-f command-prompt -p find-session 'switch-client -t %%'

# Select
bind-key -T copy-mode-vi v send-keys -X begin-selection
bind-key -T copy-mode-vi V send-keys -X select-line
bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle

# https://github.com/zanshin/dotfiles/blob/master/tmux/tmux.conf
# ---------------------
# Copy & Paste
# ---------------------
bind-key -T copy-mode-vi v send-keys -X begin-selection
bind-key -T copy-mode-vi V send-keys -X select-line
bind-key -T copy-mode-vi r send-keys -X rectangle-toggle
bind-key -T copy-mode-vi Escape send-keys -X cancel
bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "pbcopy"
bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "pbcopy"

# Save entire tmux history to a file - file will be on machine where tmux is
# running
bind-key * command-prompt -p 'save history to filename:' -I '~/tmux.history' 'capture-pane -S -32768 ; save-buffer %1 ; delete-buffer'

# # Copy
# bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'clipboard' # Copy to system clipboard.
# bind-key -T copy-mode-vi Y send-keys -X copy-pipe-and-cancel 'clipboard; tmux paste-buffer -s ""' # Copy and paste immediately to shell prompt.
# bind-key -T copy-mode-vi Escape send -X cancel
# bind-key -T copy-mode-vi L      send -X end-of-line
# bind-key -T copy-mode-vi H      send -X start-of-line
# # Paste
# unbind-key ]
# bind-key p paste-buffer -s '' # Paste without CR feed.
# unbind-key =
# bind-key P choose-buffer "paste-buffer -b '%%' -s ''"

# Search
bind-key -T copy-mode-vi / command-prompt -i -p '/' 'send-keys -X search-forward-incremental "%%%"'
bind-key -T copy-mode-vi ? command-prompt -i -p '?' 'send-keys -X search-backward-incremental "%%%"'

# Jump search mode with prefix.
bind-key / copy-mode \; send-keys '/'
bind-key ? copy-mode \; send-keys '?'

# Quickly navigate up and down in visual mode.
bind-key -T copy-mode-vi K \
	send-keys -X cursor-up \; \
	send-keys -X cursor-up \; \
	send-keys -X cursor-up \; \
	send-keys -X cursor-up \; \
	send-keys -X cursor-up \;
bind-key -T copy-mode-vi J \
	send-keys -X cursor-down \; \
	send-keys -X cursor-down \; \
	send-keys -X cursor-down \; \
	send-keys -X cursor-down \; \
	send-keys -X cursor-down \;

# ----------------------
# set some pretty colors
# ----------------------
# colorize messages in the command line
set -g message-style bg=default,fg=brightred #base02
set -g message-command-style bg=black,fg=blue
