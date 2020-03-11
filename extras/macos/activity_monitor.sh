#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../scripts/utils.sh"

print_in_purple "\n • Activity Monitor\n\n"

execute "defaults write com.apple.ActivityMonitor OpenMainWindow -bool true" \
    "Show the main window when launching Activity Monitor"

execute "defaults write com.apple.ActivityMonitor IconType -int 5" \
    "Visualize CPU usage in the Activity Monitor Dock icon"

execute "defaults write com.apple.ActivityMonitor ShowCategory -int 0" \
    "Show all processes in Activity Monitor"

execute "defaults write com.apple.ActivityMonitor SortColumn -string 'CPUUsage'" \
    "Sort Activity Monitor results by CPU usage"

execute "defaults write com.apple.ActivityMonitor SortDirection -int 0" \
    "Sort Activity Monitor results by CPU usage direction"

# 1: Very often (1 sec)
# 2: Often (2 sec)
# 5: Normally (5 sec)
execute "defaults write com.apple.ActivityMonitor UpdatePeriod -int 2" \
	"Update refresh frequency (in seconds)"

execute "defaults write com.apple.ActivityMonitor DiskGraphType -int 1" \
	"Show Data in the Disk graph (instead of IO)"

execute "defaults write com.apple.ActivityMonitor NetworkGraphType -int 1" \
	"Show Data in the Network graph (instead of packets)"

# 0: Application Icon
# 2: Network Usage
# 3: Disk Activity
# 5: CPU Usage
# 6: CPU History
execute "defaults write com.apple.ActivityMonitor IconType -int 3" \
	"Change Dock Icon"

osascript -e 'quit app "Activity Monitor"'
