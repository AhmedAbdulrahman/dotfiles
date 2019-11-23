#!/bin/sh

[ "$#" -eq 0 ] && exit 1
if [ -n "$(command -v curl)" ]; then
  URL=$(curl -sIL -o /dev/null -w '%{url_effective}' "$1")
else
  URL="$1"
fi
URL=$(echo "${url}" | perl -p -e 's/(\?|\&)?utm_[a-z]+=[^\&]+//g;' -e 's/(#|\&)?utm_[a-z]+=[^\&]+//g;')
TITLE="$2"

grep -q "[${TITLE}](${URL})" ~/Box\ Sync/saved-articles/bookmarks.txt || echo "[${TITLE}](${URL})" >>~/Box\ Sync/saved-articles/bookmarks.txt

./getpocket.com/send-to-pocket.sh "$URL" "$TITLE"