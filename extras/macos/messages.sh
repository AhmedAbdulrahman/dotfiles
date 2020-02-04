#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../scripts/utils.sh"

print_in_purple "\n • Messages\n\n"

execute "defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add 'automaticEmojiSubstitutionEnablediMessage' -bool false" \
    "Disable automatic emoji substitution (i.e. use plain text smileys)"
execute "defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add 'automaticQuoteSubstitutionEnabled' -bool false" \
    "Disable smart quotes as it’s annoying for messages that contain code"
execute "defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add 'continuousSpellCheckingEnabled' -bool false" \
    "Disable continuous spell checking"

osascript -e 'quit app "Messages"'