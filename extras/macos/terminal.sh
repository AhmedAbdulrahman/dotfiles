#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../scripts/utils.sh"

print_in_purple "\n • Terminal\n\n"

execute "defaults write com.googlecode.iterm2 PromptOnQuit -bool false" \
    "Don’t display the annoying prompt when quitting iTerm"

execute "defaults write com.googlecode.iterm2 AllowClipboardAccess -bool true" \
    "Allow terminal apps to access the pasteboard"

execute "defaults write com.googlecode.iterm2 OnlyWhenMoreTabs -bool false" \
    "Confirm close window when there are multiple tabs"

execute "defaults write com.googlecode.iterm2 CheckTestRelease -bool true" \
    "Check for beta versions for auto update"

execute "defaults write com.googlecode.iterm2 DimBackgroundWindows -bool true" \
    "Dim inactive windows"

execute "defaults write com.googlecode.iterm2 HideTab -bool false" \
    "Hide tab bar when there is only one tab"

execute "defaults write com.googlecode.iterm2 IRMemory -int 4" \
    "Memory (in megabytes) to use per session for instant replay"

execute "defaults write com.googlecode.iterm2 OpenArrangementAtStartup -bool false" \
    "Open default arrangement at startup"

execute "defaults write com.googlecode.iterm2 OpenNoWindowsAtStartup -bool false" \
    "Restore only hotkey window at startup"

execute "defaults write com.googlecode.iterm2 SUEnableAutomaticChecks -bool true" \
    "Automatically check for new versions of iTerm2"

execute "defaults write com.googlecode.iterm2 SavePasteHistory -bool false" \
    "Should paste and command history be saved to disk"

execute "defaults write com.googlecode.iterm2 SplitPaneDimmingAmount -string '0.4070612980769232'" \
    "How much to dim inactive split panes or inactive windows"

execute "defaults write com.googlecode.iterm2 StatusBarPosition -integer 1" \
    "Where does the status bar go"

execute "defaults write com.googlecode.iterm2 UseBorder -bool true" \
    "Show a border around windows"

execute "defaults write com.googlecode.iterm2 WordCharacters -string '/-+\\\\~-integer.'" \
    "Characters considered part of a word for selection"

execute "defaults write com.googlecode.iterm2 TabStyleWithAutomaticOption -integer 4" \
    "Set Tab Style to Automatic"

# Ensure the Touch ID is used when `sudo` is required.
if ! grep -q "pam_tid.so" "/etc/pam.d/sudo"; then
    execute "sudo sh -c 'echo \"auth sufficient pam_tid.so\" >> /etc/pam.d/sudo'" \
        "Use Touch ID to authenticate sudo"
fi

osascript -e 'quit app "iTerm"'
