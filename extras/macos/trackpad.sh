#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../scripts/utils.sh"

print_in_purple "\n • Trackpad\n\n"

execute "defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true && \
        defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1 && \
        defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1" \
    "Trackpad: enable tap to click for this user and for the login screen"

execute "defaults write com.apple.BluetoothAudioAgent 'Apple Bitpool Min (editable)' -int 40" \
    "Increase sound quality for Bluetooth headphones/headsets"

execute "defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true && \
        defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144" \
    "Use scroll gesture with the Ctrl (^) modifier key to zoom"