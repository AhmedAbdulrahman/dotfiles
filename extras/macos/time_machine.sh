#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../scripts/utils.sh"

print_in_purple "\n • Time Machine\n\n"

execute "defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true" \
    "Prevent Time Machine from prompting to use new hard drives as backup volume"

execute "hash tmutil &> /dev/null && sudo tmutil disablelocal" \
    "Disable local Time Machine backups"

osascript -e 'quit app "Time Machine"'