#!/bin/bash

e='\033'
RESET="${e}[0m"
BOLD="${e}[1m"
CYAN="${e}[0;96m"
RED="${e}[0;91m"
YELLOW="${e}[0;93m"
GREEN="${e}[0;92m"
BLUE="${e}[1;34m"
COLUMNS=$(tput cols) 

answer_is_yes() {
    [[ "$REPLY" =~ ^[Yy]$ ]] \
        && return 0 \
        || return 1
}

ask() {
    print_question "$1"
    read -r
}

ask_for_confirmation() {
    print_question "$1 (y/n) "
    read -r -n 1
    printf "\n"
}

ask_for_sudo_permission() {

    # Ask for the administrator password upfront.
    sudo -v &> /dev/null

    # Keep-alive: update existing `sudo` time stamp until the script has finished.
    while true; do
        sudo -n true
        sleep 60
        kill -0 "$$" || exit
    done &> /dev/null &

}

cmd_exists() {
    command -v "$1" &> /dev/null
}

kill_all_subprocesses() {

    local i=""

    for i in $(jobs -p); do
        kill "$i"
        wait "$i" &> /dev/null
    done

}

execute() {

    local -r CMDS="$1"
    local -r MSG="${2:-$1}"
    local -r TMP_FILE="$(mktemp /tmp/XXXXX)"

    local exitCode=0
    local cmdsPID=""

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # If the current process is ended,
    # also end all its subprocesses.

    set_trap "EXIT" "kill_all_subprocesses"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Execute commands in background

    eval "$CMDS" \
        &> /dev/null \
        2> "$TMP_FILE" &

    cmdsPID=$!

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Show a spinner if the commands
    # require more time to complete.

    show_spinner "$cmdsPID" "$CMDS" "$MSG"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Wait for the commands to no longer be executing
    # in the background, and then get their exit code.

    wait "$cmdsPID" &> /dev/null
    exitCode=$?

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Print output based on what happened.

    print_result $exitCode "$MSG"

    if [ $exitCode -ne 0 ]; then
        print_error_stream < "$TMP_FILE"
    fi

    rm -rf "$TMP_FILE"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    return $exitCode

}

get_os() {

    local os=""
    local kernelName=""

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    kernelName="$(uname -s)"

    if [ "$kernelName" == "Darwin" ]; then
        os="macos"
    elif [ "$kernelName" == "Linux" ] && \
         [ -e "/etc/os-release" ]; then
        os="$(. /etc/os-release; printf "%s" "$ID")"
    else
        os="$kernelName"
    fi

    printf "%s" "$os"

}

is_git_repository() {
    git rev-parse &> /dev/null
}

print_in_color() {
    printf "%b" \
        "$(tput setaf "$2" 2> /dev/null)" \
        "$1" \
        "$(tput sgr0 2> /dev/null)"
}

print_in_green() {
    print_in_color "$1" 2
}

print_in_purple() {
    print_in_color "$1" 5
}

print_in_red() {
    print_in_color "$1" 1
}

print_in_yellow() {
    print_in_color "$1" 3
}

print_in_blue() {
    print_in_color "$1" 4
}

print_question() {
    print_in_yellow "   [?] $1"
}

# Success reporter
print_success() {
    print_in_green "   [✔] $1\n"
}

# Error reporter
print_error() {
    print_in_red "   [✖] $1 $2\n"
}

print_error_stream() {
    while read -r line; do
        print_error "↳ ERROR: $line"
    done
}

# question reporter
print_question() {
    print_in_yellow "   [?] $1"
}

# Warning reporter
print_warning() {
    print_in_yellow "   [⚠] $1\n"
}

# Info reporter
print_info() {
    print_in_blue "   [!] $1\n"
}

# Result reporter
print_result() {

    if [ "$1" -eq 0 ]; then
        print_success "$2"
    else
        print_error "$2"
    fi

    return "$1"

}

# Print Banner
print_header() {
    print_in_green "    _____   ____ _______ ______ _____ _      ______  _____  \n"
    print_in_green "   |  __ \ / __ \__   __|  ____|_   _| |    |  ____|/ ____| \n"
    print_in_green "   | |  | | |  | | | |  | |__    | | | |    | |__  | (___   \n"
    print_in_green "   | |  | | |  | | | |  |  __|   | | | |    |  __|  \___ \  \n"
    print_in_green "   | |__| | |__| | | |  | |     _| |_| |____| |____ ____) | \n"
    print_in_green "   |_____/ \____/  |_|  |_|    |_____|______|______|_____/  \n"
    print_in_green "                                                            \n"
    print_in_green "                   by @AhmedAbdulrahman                     \n"
}

# Print repo Info
print_repo_info() {
    if is_git_repository; then
        echo -e $BLUE
        command cat <<- EOF
            *******************************************
                    $(git --git-dir "$1/.git" --work-tree "$1" log -n 1 --pretty=format:'%C(yellow)Last commit SHA:  %h')
                    $(git --git-dir "$1/.git" --work-tree "$1" log -n 1 --pretty=format:'%C(red)Commit date:      %ad' --date=short)
                    $(git --git-dir "$1/.git" --work-tree "$1" log -n 1 --pretty=format:'%C(cyan)Author:           %an')
            ********************************************
EOF
        echo -e $RESET
    fi
}

set_trap() {

    trap -p "$1" | grep "$2" &> /dev/null \
        || trap '$2' "$1"

}

on_finish() {
  print_in_green   "    Setup was successfully done! \n"
  print_in_green   "    Happy Coding!\n\n"
  print_in_red     '   -_-_-_-_-_-_-_-_-_-_-_-_-_-_'',------,'
  print_in_yellow  '\n   -_-_-_-_-_-_-_-_-_-_-_-_-_-_''|   /\_/\\'
  print_in_green   '\n   -_-_-_-_-_-_-_-_-_-_-_-_-_-''~|__( ^ .^)'
  print_in_blue    '\n   -_-_-_-_-_-_-_-_-_-_-_-_-_-_''""  ""\n\n'
  
  print_warning    "P.S: Don't forget to restart your terminal ;)"
}

on_error() {
  print_error "Wow... Something serious happened!"
  print_error "In case if you need any help, raise an issue -> ${CYAN}${GITHUB_REPO_URL_BASE}issues/new${RESET}"
  exit 1
}

# End section
finish() {
  print_success "Done."
  sleep 1
}

restart() {
    print_info "\n • Restart\n\n"

    ask_for_confirmation "Do you want to restart?"
    printf "\n"

    if answer_is_yes; then
        sudo shutdown -r now &> /dev/null
    fi
}

show_spinner() {

    local -r FRAMES='/-\|'

    # shellcheck disable=SC2034
    local -r NUMBER_OR_FRAMES=${#FRAMES}

    local -r CMDS="$2"
    local -r MSG="$3"
    local -r PID="$1"

    local i=0
    local frameText=""

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Note: In order for the Travis CI site to display
    # things correctly, it needs special treatment, hence,
    # the "is Travis CI?" checks.

    if [ "$TRAVIS" != "true" ]; then

        # Provide more space so that the text hopefully
        # doesn't reach the bottom line of the terminal window.
        #
        # This is a workaround for escape sequences not tracking
        # the buffer position (accounting for scrolling).
        #
        # See also: https://unix.stackexchange.com/a/278888

        printf "\n\n\n"
        tput cuu 3

        tput sc

    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Display spinner while the commands are being executed.

    while kill -0 "$PID" &>/dev/null; do

        frameText="   [${FRAMES:i++%NUMBER_OR_FRAMES:1}] $MSG"

        # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

        # Print frame text.

        if [ "$TRAVIS" != "true" ]; then
            printf "%s\n" "$frameText"
        else
            printf "%s" "$frameText"
        fi

        sleep 0.2

        # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

        # Clear frame text.

        if [ "$TRAVIS" != "true" ]; then
            tput rc
        else
            printf "\r"
        fi

    done

}