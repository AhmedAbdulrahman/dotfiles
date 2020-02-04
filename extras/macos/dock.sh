#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../scripts/utils.sh"

print_in_purple "\n • Dock\n\n"

execute "defaults write com.apple.dock autohide -bool true" \
    "Automatically hide and show the Dock"

execute "defaults write com.apple.dock autohide-delay -float 0" \
    "Disable the auto-hiding Dock delay"

execute "defaults write com.apple.dock mouse-over-hilite-stack -bool true" \
    "Enable highlight hover effect for the grid view of a stack (Dock)"

execute "defaults write com.apple.dock autohide-time-modifier -float 0" \
    "Remove the animation when hiding/showing the Dock"

execute "defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true" \
    "Enable spring loading for all Dock items"

execute "defaults write com.apple.dock expose-animation-duration -float 0.1" \
    "Speed up Mission Control animations"

execute "defaults write com.apple.dock expose-group-by-app -bool false" \
    "Don’t group windows by application in Mission Control"

execute "defaults write com.apple.dock launchanim -bool false" \
    "Don’t animate opening applications from the Dock"

execute "defaults write com.apple.dock mineffect -string 'scale'" \
    "Change minimize/maximize window effect"

execute "defaults write com.apple.dock minimize-to-application -bool true" \
    "Reduce clutter by minimizing windows into their application icons"

execute "defaults write com.apple.dock mru-spaces -bool false" \
    "Don’t automatically rearrange Spaces based on most recent use"

execute "defaults write com.apple.dock persistent-apps -array && \
         defaults write com.apple.dock persistent-others -array " \
    "Wipe all (default) app icons from the Dock"

execute "defaults write com.apple.dock static-only -bool true" \
    "Show only open applications in the Dock"

execute "defaults write com.apple.dock show-process-indicators -bool true" \
    "Show indicator lights for open applications"

execute "defaults write com.apple.dock show-recents -bool false" \
    "Don’t show recent applications in Dock"

execute "defaults write com.apple.dock showhidden -bool true" \
    "Make Dock icons of hidden applications translucent"

execute "defaults write com.apple.dock showLaunchpadGestureEnabled -int 0" \
    "Disable the Launchpad gesture (pinch with thumb and three fingers)"

execute "defaults write com.apple.dashboard mcx-disabled -bool true" \
    "Disable Dashboard"

execute "defaults write com.apple.dock dashboard-in-overlay -bool true" \
    "Don’t show Dashboard as a Space"

execute "defaults write com.apple.dock tilesize -int 36" \
    "Set the icon size of Dock items to 36 pixels"

find "${HOME}/Library/Application Support/Dock" -name "*-*.db" -maxdepth 1 -delete

# Add iOS & Watch Simulator to Launchpad
sudo ln -sf "/Applications/Xcode.app/Contents/Developer/Applications/Simulator.app" "/Applications/Simulator.app"
sudo ln -sf "/Applications/Xcode.app/Contents/Developer/Applications/Simulator (Watch).app" "/Applications/Simulator (Watch).app"

osascript -e 'quit app "Dock"'