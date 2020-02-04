#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../scripts/utils.sh"

print_in_purple "\n • Keyboard\n\n"

execute "defaults write -g AppleKeyboardUIMode -int 3" \
    "Enable full keyboard access for all controls (e.g. enable Tab in modal dialogs)"

execute "defaults write -g ApplePressAndHoldEnabled -bool false" \
    "Disable press-and-hold in favor of key repeat"

execute "defaults write -g 'InitialKeyRepeat_Level_Saved' -int 10" \
    "Set delay until repeat"

execute "defaults write -g KeyRepeat -int 1" \
    "Set the key repeat rate to fast"

execute "defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false" \
    "Disable automatic capitalization"

execute "defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false" \
    "Disable automatic correction"

execute "defaults write -g NSAutomaticPeriodSubstitutionEnabled -bool false" \
    "Disable automatic period substitution"

execute "defaults write -g NSAutomaticDashSubstitutionEnabled -bool false" \
    "Disable smart dashes"

execute "defaults write -g NSAutomaticQuoteSubstitutionEnabled -bool false" \
    "Disable smart quotes"

execute "defaults write com.apple.universalaccess closeViewZoomFollowsFocus -bool true" \
    "Follow the keyboard focus while zoomed in"

# Note: if you’re in the US, replace `EUR` with `USD`, `Centimeters` with
# `Inches`, `en_GB` with `en_US`, and `true` with `false`.
execute "defaults write NSGlobalDomain AppleLanguages -array 'en' 'tr' 'ar' 'sv' && \
         defaults write NSGlobalDomain AppleLocale -string 'en_GB@currency=EUR' && \
         defaults write NSGlobalDomain AppleMeasurementUnits -string 'Centimeters' \
         defaults write NSGlobalDomain AppleMetricUnits -bool true" \
    "Set language and text formats"

execute "sudo defaults write /Library/Preferences/com.apple.loginwindow showInputMenu -bool true"
    "Show language menu in the top right corner of the boot screen"

execute "sudo systemsetup -settimezone 'Europe/Stockholm' > /dev/null"
    "Set the timezone; see 'sudo systemsetup -listtimezones' for other values"