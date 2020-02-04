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

osascript -e 'quit app "Activity Monitor"'