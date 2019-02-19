# Mode
set-option -g mode-bg brightblack
set-option -g mode-fg default

# Use top tabbar
set-option -g status-position bottom

# set color for status bar
set-option -g status-style bg=default,fg=default

# Status update interval
set-option -g status-interval 5

# Basic status bar colors
set-option -g status 'on'
set-option -q -g status-utf8 'on'
# set-option -g status-bg 'colour235'
set-option -g status-bg default
set-option -g status-fg white
set-option -g status-attr 'none'

# Left side of status bar
set-option -g status-left-length 100
set-option -g status-left-attr 'none'
# set-option -g status-left '#[fg=colour232,bg=colour154] #S #[fg=colour232] #W #[fg=colour121]⦁ #[fg=colour121,bg=colour235] #(whoami)#[fg=colour235,bg=colour235,nobold,nounderscore,noitalics]'
set-option -g status-left "#[fg=colour232,bg=colour154]#{?client_prefix#[fg=colour232,bg=colour154],#[fg=colour232]} #S #[fg=colour232]"


# Window status
set-option -g window-status-fg 'colour121'
set-option -g window-status-attr 'none'
set-option -g window-status-activity-bg 'colour235'
set-option -g window-status-activity-attr 'none'
set-option -g window-status-activity-fg 'colour154'
# set-option -g window-status-bg 'colour235'
set-option -g window-status-format '#[fg=colour235,nobold,nounderscore,noitalics]#[default] #I  #W #[fg=colour235,nobold,nounderscore,noitalics]'
set-option -g window-status-current-format '#[fg=colour235,nobold,nounderscore,noitalics]#[fg=colour222] #I  #W  #F #[fg=colour154,nobold,nounderscore,noitalics]'
set-option -g window-status-separator ' '
set-option -g status-justify left

# Right side of status bar
set-option -g status-right-length 100
set-option -g status-right-attr 'none'
status_prefix="#[fg=colour238,bg=colour235,nobold,nounderscore,noitalics]"
status_block_prefix="#[fg=colour154,bg=colour238,nobold,nounderscore,noitalics]"
status_node_version="#[fg=colour121] #(node -v) #[fg=colour121]⦁ "
# status_date_time="#[fg=colour121,bg=colour235] %A, %d %b %Y %H:%M "
status_github="#(~/.tmux/scripts/tmux-github-status)"
status_wifi="#[fg=colour121]#(~/.tmux/scripts/tmux-wifi)#[fg=colour121]⦁ "
status_block="#[fg=colour232,bg=colour154] #(rainbarf --battery --remaining --no-rgb) "
status_prayer_times="#[fg=colour232,bg=colour154] #(~/.tmux/scripts/tmux-next-prayer) #(rainbarf --battery --remaining --no-rgb) "
# set-option -g status-right "${status_prefix}${status_github}${status_node_version}${status_wifi}${status_prayer_times}"
set-option -g status-right "${status_github}${status_node_version}${status_wifi}${status_prayer_times}"

# Pane border
set-option -g pane-border-bg default
set-option -g pane-border-fg 'colour238'
set-option -g pane-active-border-bg default
set-option -g pane-active-border-fg white

# Pane number indicator
set-option -g display-panes-colour brightblack
set-option -g display-panes-active-colour brightwhite

# Clock mode
set-option -g clock-mode-colour white
set-option -g clock-mode-style 24

# Message
set-option -g message-bg yellow
set-option -g message-fg black
set-option -g message-command-bg 'colour238'
set-option -g message-command-fg 'colour222'
