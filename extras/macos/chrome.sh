#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../scripts/utils.sh"

print_in_purple "\n • Google Chrome\n\n"

execute "defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false" \
    "Disable backswipe"

execute "defaults write com.google.Chrome PMPrintingExpandedStateForPrint2 -bool true" \
    "Expand print dialog by default"

# execute "defaults write com.google.Chrome.canary PMPrintingExpandedStateForPrint2 -bool true" \
#     "Expand print dialog by default Chrome Canary"

execute "defaults write com.google.Chrome DisablePrintPreview -bool true" \
    "Use system-native print preview dialog"

osascript -e 'quit app "Google Chrome"'