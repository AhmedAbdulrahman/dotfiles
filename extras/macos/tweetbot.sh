#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../scripts/utils.sh"

print_in_purple "\n • Tweetbot\n\n"

execute "defaults write com.tapbots.TweetbotMac OpenURLsDirectly -bool true" \
    "Bypass the annoyingly slow t.co URL shortener"

osascript -e 'quit app "Tweetbot"'