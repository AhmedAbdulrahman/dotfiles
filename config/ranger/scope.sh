#!/usr/bin/env bash

set -o noclobber -o noglob -o nounset -o pipefail
IFS=$'\n'

# If the option `use_preview_script` is set to `true`,
# then this script will be called and its output will be displayed in ranger.
# ANSI color codes are supported.
# STDIN is disabled, so interactive scripts won't work properly

# This script is considered a configuration file and must be updated manually.
# It will be left untouched if you upgrade ranger.

# Meanings of exit codes:
# code | meaning    | action of ranger
# -----+------------+-------------------------------------------
# 0    | success    | Display stdout as preview
# 1    | no preview | Display no preview at all
# 2    | plain text | Display the plain content of the file
# 3    | fix width  | Don't reload when width changes
# 4    | fix height | Don't reload when height changes
# 5    | fix both   | Don't ever reload
# 6    | image      | Display the image `$IMAGE_CACHE_PATH` points to as an image preview
# 7    | image      | Display the file directly as an image

# Script arguments
path="$1"            # Full path of the selected file
width="$2"           # Width of the preview pane (number of fitting characters)
height="$3"          # Height of the preview pane (number of fitting characters)
cached="$4"          # Path that should be used to cache image previews
preview_images="$5"  # "True" if image previews are enabled, "False" otherwise

maxln=200    # Stop after $maxln lines.  Can be used like ls | head -n $maxln

# Find out something about the file:
mimetype=$(file --mime-type -Lb "$path")
extension=$(/bin/echo "${path##*.}" | awk '{print tolower($0)}')

# Functions:
# runs a command and saves its output into $output.  Useful if you need
# the return value AND want to use the output in a pipe
try() { output=$(eval '"$@"'); }

# writes the output of the previously used "try" command
dump() { /bin/echo "$output"; }

# a common post-processing function used after most commands
trim() { head -n "$maxln"; }

# wraps highlight to treat exit code 141 (killed by SIGPIPE) as success
safepipe() { "$@"; test $? = 0 -o $? = 141; }

# Image previews, if enabled in ranger.
if [ "$preview_images" = "True" ]; then
    case "$mimetype" in
        image/svg+xml)
           convert "$path" "$cached" && exit 6 || exit 1;;
        image/*)
            exit 7;;
        # Image preview for video, disabled by default.:
        ###video/*)
        ###    ffmpegthumbnailer -i "$path" -o "$cached" -s 0 && exit 6 || exit 1;;
    esac
fi

case "${extension}" in
    # Archive
    a|ace|alz|arc|arj|bz|bz2|cab|cpio|deb|gz|jar|lha|lz|lzh|lzma|lzo|\
    rpm|rz|t7z|tar|tbz|tbz2|tgz|tlz|txz|tZ|tzo|war|xpi|xz|Z|zip)
        atool --list -- "${path}" && exit 5
        bsdtar --list --file "${path}" && exit 5
        exit 1;;
    rar)
        # Avoid password prompt by providing empty password
        try unrar -p- lt "$path" && { dump | trim; exit 0; } || exit 1;;
    7z)
        # Avoid password prompt by providing empty password
        try 7z -p l "$path" && { dump | trim; exit 0; } || exit 1;;

    # PDF
    pdf)
        # Preview as text conversion
        pdftotext -l 10 -nopgbrk -q -- "${path}" - | fmt -w ${width} && exit 5
        mutool draw -F txt -i -- "${path}" 1-10 | fmt -w ${width} && exit 5
        exiftool "${path}" && exit 5
        exit 1;;

    # BitTorrent
    torrent)
        try transmission-show "$path" && { dump | trim; exit 5; } || exit 1;;

    # OpenDocument
    odt|ods|odp|sxw)
        # Preview as text conversion
        odt2txt "${path}" && exit 5
        exit 1;;

    # HTML
    htm|html|xhtml)
        # Preview as text conversion
        w3m -dump "${path}" && exit 5
        elinks -dump "${path}" && exit 5
        ;; # Continue with next handler on failure
esac


case "$mimetype" in
    # Syntax highlight for text files:
    text/* | */xml)
        if [ "$(tput colors)" -ge 256 ]; then
            pygmentize_format=terminal256
            highlight_format=ansi
        else
            pygmentize_format=terminal
            highlight_format=ansi
        fi
        try safepipe highlight --out-format=${highlight_format} "$path" && { dump | trim; exit 5; }
        try safepipe pygmentize -f ${pygmentize_format} "$path" && { dump | trim; exit 5; }
        exit 2;;
    # Ascii-previews of images:
    image/*)
        img2txt --gamma=0.6 --width="$width" "$path" && exit 4 || exit 1;;
    # Display information about media files:
    video/* | audio/*)
        exiftool "$path" && exit 5
        # Use sed to remove spaces so the output fits into the narrow window
        try mediainfo "$path" && { dump | trim | sed 's/  \+:/: /;';  exit 5; } || exit 1;;
esac

exit 1