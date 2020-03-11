#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../scripts/utils.sh"

print_in_purple "\n • Screen\n\n"

execute "defaults write com.apple.screensaver askForPassword -int 1 && \
	defaults write com.apple.screensaver askForPasswordDelay -int 5" \
	"Require password immediately after sleep or screen saver begins"

execute "defaults write com.apple.screencapture location -string '${HOME}/Desktop'" \
	"Save screenshots to the Desktop"

execute "defaults write com.apple.screencapture type -string 'png'" \
	"Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)"

execute "defaults write com.apple.screencapture disable-shadow -bool true" \
	"Disable shadow in screenshots"


execute "defaults write com.apple.screencapture show-thumbnail -bool false" \
	"Do not show thumbnail"

execute "defaults write -g AppleFontSmoothing -int 2" \
	"Enable subpixel font rendering on non-Apple LCDs Reference: https://github.com/kevinSuttle/macOS-Defaults/issues/17#issuecomment-266633501"

execute "sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true"
	"Enable HiDPI display modes (requires restart)"
