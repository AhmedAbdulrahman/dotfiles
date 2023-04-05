#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../scripts/utils.sh"

print_in_purple "\n • Preferences\n"

# We need to close `System Preferences` to avoid overriding the preferences that are being changed.

./close_system_preferences_panes.applescript

./activity_monitor.sh
./app_store.sh
./chrome.sh
./dock.sh
./finder.sh
./firefox.sh
./keyboard.sh
./language_and_region.sh
./maps.sh
./messages.sh
./photos.sh
./safari.sh
./textedit.sh
./time_machine.sh
./trackpad.sh
./transmission.sh
./tweetbot.sh
./ui_and_ux.sh
