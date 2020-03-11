#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../scripts/utils.sh"

print_in_purple "\n • Security\n\n"

# Based on:
# https://github.com/drduh/macOS-Security-and-Privacy-Guide
# https://benchmarks.cisecurity.org/tools2/osx/CIS_Apple_OSX_10.12_Benchmark_v1.0.0.pdf

# Enable firewall. Possible values:
#   0 = off
#   1 = on for specific sevices
#   2 = on for essential services
execute "sudo defaults write /Library/Preferences/com.apple.alf globalstate -int 1" \
		"Privacy: don’t send search queries to Apple"

# Source: https://support.apple.com/kb/PH18642
execute " sudo defaults write /Library/Preferences/com.apple.alf stealthenabled -int 1" \
	"Enable firewall stealth mode (no response to ICMP / ping requests)"

execute " sudo systemsetup -setremoteappleevents off" \
	"Disable remote apple events"

execute " sudo systemsetup -setremotelogin off" \
	"Disable remote login"

execute " sudo systemsetup -setwakeonmodem off" \
	"Disable wake-on modem"

execute " sudo systemsetup -setwakeonnetworkaccess off" \
	"Disable wake-on LAN"

execute "sudo defaults write /Library/Preferences/com.apple.loginwindow RetriesUntilHint -int 0" \
	"Do not show password hints"

execute "sudo defaults write /Library/Preferences/com.apple.loginwindow GuestEnabled -bool false" \
	"Disable guest account login"

execute "sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.SubmitDiagInfo.plist" \
	"Disable diagnostic reports"
