#!/bin/bash

# Safer bash scripts with 'set -euxo pipefail'
set -Eueo pipefail
trap on_error SIGKILL SIGTERM

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

execute_cmd() {

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

# Success reporter
print_success() {
    echo -e "${GREEN}[✔] ${*}${RESET}"
}

# Error reporter
print_error() {
    echo -e "${RED}[✖] ${*}${RESET}"
}

# question reporter
print_question() {
    echo -e "${CYAN}[?] ${*}${RESET}"
}

# Warning reporter
print_warning() {
    echo -e "${YELLOW}[⚠ ] ${*}${RESET}"
}

# Info reporter
print_info() {
    echo -e "${BLUE}[!] ${*}${RESET}"
}

# Print Banner
print_header() {
    # printf "%*s\n" $(((${#title}+$COLUMNS)/2)) "$title"
    echo -e "$GREEN      _____   ____ _______ ______ _____ _      ______  _____  "
    echo -e "$GREEN     |  __ \ / __ \__   __|  ____|_   _| |    |  ____|/ ____| "
    echo -e "$GREEN     | |  | | |  | | | |  | |__    | | | |    | |__  | (___   "
    echo -e "$GREEN     | |  | | |  | | | |  |  __|   | | | |    |  __|  \___ \  "
    echo -e "$GREEN     | |__| | |__| | | |  | |     _| |_| |____| |____ ____) | "
    echo -e "$GREEN     |_____/ \____/  |_|  |_|    |_____|______|______|_____/  "
    echo -e "$GREEN                                                              "
    echo -e "$GREEN                     by @AhmedAbdulrahman             ${RESET}"
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
  echo
  echo -e $GREEN"Setup was successfully done!"
  echo -e $GREEN"Happy Coding!"
  echo
  echo -ne $RED'-_-_-_-_-_-_-_-_-_-_-_-_-_-_'
  echo -e  $RESET$BOLD',------,'$RESET
  echo -ne $YELLOW'-_-_-_-_-_-_-_-_-_-_-_-_-_-_'
  echo -e  $RESET$BOLD'|   /\_/\\'$RESET
  echo -ne $GREEN'-_-_-_-_-_-_-_-_-_-_-_-_-_-'
  echo -e  $RESET$BOLD'~|__( ^ .^)'$RESET
  echo -ne $CYAN'-_-_-_-_-_-_-_-_-_-_-_-_-_-_'
  echo -e  $RESET$BOLD'""  ""'$RESET
  echo
  print_warning "P.S: Don't forget to restart your terminal ;)"
  echo
}

on_error() {
  print_error "Wow... Something serious happened!"
  print_error "In case if you need any help, raise an issue -> ${CYAN}${GITHUB_REPO_URL_BASE}issues/new${RESET}"
  echo
  exit 1
}

# End section
finish() {
  print_success "Done."
  sleep 1
}