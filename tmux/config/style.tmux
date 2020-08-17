# ----------------------
# Colorize Messages
# ----------------------
set -g message-style bg=default,fg=brightred #base02
set -g message-command-style bg=black,fg=blue

# ----------------------
# Panes
# ----------------------
set -g pane-border-style bg=default,fg=#8d929b
set -g pane-active-border-style bg=default,fg=#8d929b
setw -g pane-border-status top
setw -g pane-border-format '─'

# ----------------------
# Status Bar
# ----------------------
set -g status on

set -g status-interval 5
set -g status-justify left
set -g status-position top

# set color for status bar
set -g status-style bg=default,fg=default

# setw -g window-status-format "#[bg=default]#{?window_activity_flag,#{?window_bell_flag,#[fg=brightred]▲,#[fg=#8383af]⦁},#[fg=#8383af]⦁}#[bg=default]"
setw -g window-status-format " #I: #W "

setw -g window-status-current-format "#{?window_zoomed_flag,#[fg=yellow][ #W ],#W}#[bg=default]"
# setw -g window-status-style bg=default,fg=colour237
setw -g window-status-activity-style bg=default,fg=colour243
setw -g window-status-bell-style bg=default,fg=brightred
setw -g window-status-current-style bg=default,fg=colour004

# show session name, window & pane number, date and time on left side of
# status bar
set -g status-left-length 70
set -g status-left "#[fg=#ffa7c4]#{?client_prefix,#[fg=#ffa7c4],#[fg=#8d929b]}#[bold] #S #[fg=#ffa7c4] "

# show default node version, battery status, wifi name & date time
status_prefix="#{?client_prefix,#[fg=#ffa7c4]#(echo $(tmux show-option -gqv prefix | tr \"[:lower:]\" \"[:upper:]\" | sed 's/C-/\^/')) #[fg=#8383af]⦁ ,}"
status_node_version='#[fg=colour237]#[fg=#7edbca]#(node -v) #[fg=#8383af]⦁ '
status_wifi="#[fg=colour237]#[fg=#8d929b]#(~/.tmux/scripts/tmux-wifi) #[fg=#8383af]⦁ "
status_weather="#[fg=colour237]#[fg=#8d929b]#(~/.tmux/scripts/tmux-weather)"
status_github="#(~/.tmux/scripts/tmux-github-status)"
status_npm="#(~/.tmux/scripts/tmux-npm-status)"
# for some reason that extra space at the end prevents the date from overlaping & makes it play nice with Nerd Fonts
status_date_time="#[fg=colour237]#[fg=#8d929b]%A, %d %b#[fg=colour237] "
status_prayer_times="#[fg=#8d929b]#(~/.tmux/scripts/tmux-next-prayer) #[fg=#8383af]⦁ "

set -g status-right-length 300
set -g status-right "${status_npm}${status_github}${status_node_version}${status_wifi}${status_weather}${status_prayer_times}${status_date_time}"
