#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../scripts/utils.sh"

print_in_purple "\n • General UI & UX\n\n"

execute "sudo pmset -a hibernatemode 0" \
    "Disable hibernation (speeds up entering sleep mode)"

execute "sudo rm /private/var/vm/sleepimage" \
    "Remove the sleep image file to save disk space"

execute "sudo touch /private/var/vm/sleepimage" \
    "Create a zero-byte file instead…"

execute "sudo chflags uchg /private/var/vm/sleepimage" \
    "…and make sure it can’t be rewritten"

execute "defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true && \
         defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true" \
   "Avoid creating '.DS_Store' files on network or USB volumes"

execute "sudo pmset -a standbydelay 8640" \
    "Set standby delay to 24 hours (default is 1 hour)"

execute "defaults write com.apple.menuextra.battery ShowPercent -string 'NO'" \
    "Hide battery percentage from the menu bar"

execute "sudo defaults write /Library/Preferences/com.apple.loginwindow showInputMenu -bool true" \
    "Show language menu in the top right corner of the boot screen"

execute "defaults write com.apple.CrashReporter UseUNC 1" \
    "Make crash reports appear as notifications"

execute "defaults write com.apple.LaunchServices LSQuarantine -bool false" \
    "Disable 'Are you sure you want to open this application?' dialog"

execute "defaults write com.apple.print.PrintingPrefs 'Quit When Finished' -bool true" \
    "Automatically quit the printer app once the print jobs are completed"

execute "/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user" \
    "Remove duplicates in the “Open With” menu (also see `lscleanup` alias)"

execute "defaults write NSGlobalDomain NSTextShowsControlCharacters -bool true" \
    "Display ASCII control characters using caret notation in standard text views"

execute "defaults write com.apple.screencapture disable-shadow -bool true" \
    "Disable shadow in screenshots"

execute "defaults write com.apple.screencapture location -string '$HOME/Desktop'" \
    "Save screenshots to the Desktop"

execute "defaults write com.apple.screencapture show-thumbnail -bool false" \
    "Do not show thumbnail"

execute "defaults write com.apple.screencapture type -string 'png'" \
    "Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)"

execute "defaults write com.apple.screensaver askForPassword -int 1 && \
         defaults write com.apple.screensaver askForPasswordDelay -int 0" \
    "Require password immediately after into sleep or screen saver mode"

execute "defaults write com.apple.screencapture location -string '${HOME}/Desktop/screenshots'" \
    "Save screenshots to the desktop"

execute "defaults write -g AppleFontSmoothing -int 2" \
    "Enable subpixel font rendering on non-Apple LCDs Reference: https://github.com/kevinSuttle/macOS-Defaults/issues/17#issuecomment-266633501"

execute "sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true"
    "Enable HiDPI display modes (requires restart)"

execute "defaults write -g AppleShowScrollBars -string 'Always'" \
    "Always show scrollbars"

execute "defaults write -g NSAutomaticWindowAnimationsEnabled -bool false" \
    "Disable window opening and closing animations."

execute "sudo nvram SystemAudioVolume=' '" \
    "Disable the sound effects on boot"

execute "defaults write com.apple.helpviewer DevMode -bool true" \
    "Set Help Viewer windows to non-floating mode"

execute "sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName" \
    "Reveal IP address, hostname, OS version, etc. when clicking the clock in the login window"

execute "defaults write -g NSDisableAutomaticTermination -bool true" \
    "Disable automatic termination of inactive apps"

execute "defaults write -g NSNavPanelExpandedStateForSaveMode -bool true" \
    "Expand save panel by default"

execute "defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool tru" \
    "Expand save panel by default"

execute "defaults write -g NSTableViewDefaultSizeMode -int 2" \
    "Set sidebar icon size to medium"

execute "defaults write -g NSUseAnimatedFocusRing -bool false" \
    "Disable the over-the-top focus ring animation"

execute "defaults write -g NSWindowResizeTime -float 0.001" \
    "Accelerated playback when adjusting the window size."

execute "defaults write -g PMPrintingExpandedStateForPrint -bool true" \
    "Expand print panel by default"

execute "defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false" \
    "Save to disk (not to iCloud) by default"

execute "defaults write com.apple.universalaccess reduceTransparency -bool true" \
    "Disable transparency in the menu bar and elsewhere on Yosemite"

execute "defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true" \
    "Expand print panel by default"

execute "defaults write -g QLPanelAnimationDuration -float 0" \
    "Disable opening a Quick Look window animations."

execute "defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false" \
    "Disable resume system-wide"

execute "sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string 'potato' && \
         sudo scutil --set ComputerName 'potato' && \
         sudo scutil --set HostName 'potato' && \
         sudo scutil --set LocalHostName 'potato'" \
    "Set computer name (as done via System Preferences → Sharing)"

execute "sudo systemsetup -setrestartfreeze on" \
    "Restart automatically if the computer freezes"

execute "defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false" \
    "Disable automatic capitalization as it’s annoying when typing code"

execute "defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false" \
    "Disable automatic period substitution as it’s annoying when typing code"

execute "defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false" \ 
    "Disable smart quotes as they’re annoying when typing code"

execute "defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false" \
    "Disable smart dashes as they’re annoying when typing code"

execute "sudo defaults write /Library/Preferences/com.apple.Bluetooth.plist ControllerPowerState 0 && \
         sudo launchctl unload /System/Library/LaunchDaemons/com.apple.blued.plist && \
         sudo launchctl load /System/Library/LaunchDaemons/com.apple.blued.plist" \
    "Turn Bluetooth off"

execute "for domain in ~/Library/Preferences/ByHost/com.apple.systemuiserver.*; do
            sudo defaults write \"\${domain}\" dontAutoLoad -array \
                '/System/Library/CoreServices/Menu Extras/TimeMachine.menu' \
                '/System/Library/CoreServices/Menu Extras/Volume.menu'
         done \
            && sudo defaults write com.apple.systemuiserver menuExtras -array \
                '/System/Library/CoreServices/Menu Extras/Bluetooth.menu' \
                '/System/Library/CoreServices/Menu Extras/AirPort.menu' \
                '/System/Library/CoreServices/Menu Extras/Battery.menu' \
                '/System/Library/CoreServices/Menu Extras/Clock.menu'
        " \
    "Hide Time Machine and Volume icons from the menu bar"

osascript -e 'quit app "SystemUIServer"'