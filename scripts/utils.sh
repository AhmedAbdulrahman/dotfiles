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

get_answer() {
    printf "%s" "$REPLY"
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
    print_in_yellow "   [?] $1\n"
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
			 command cat <<EOF
$GREEN
	 _____   ____ _______ ______ _____ _      ______  _____
    |  __ \ / __ \__   __|  ____|_   _| |    |  ____|/ ____|
    | |  | | |  | | | |  | |__    | | | |    | |__  | (___
    | |  | | |  | | | |  |  __|   | | | |    |  __|  \___ \/
    | |__| | |__| | | |  | |     _| |_| |____| |____ ____) |
    |_____/ \____/  |_|  |_|    |_____|______|______|_____/

                    by @AhmedAbdulrahman
EOF
}

print_macos_header() {
				 command cat <<EOF
$GREEN
                           ____   _____
                          / __ \ / ____|
    _  __  ___   __ _  ___| |  | | (___
    | | _ / _ \ / _\ | / __| |  | |\___ \/
    | |  | | | | (_| | (__| |__| |____) |
    |_|  |_| |_|\__,_|\___|\____/|_____/

            by @AhmedAbdulrahman
EOF
}

print_node_header() {
				 command cat <<EOF
$GREEN
     _   _           _           _  _____
    | \ | |         | |         | |/ ____|
    |  \| | ___   __| | ___     | | (___
    | . ' |/ _ \ / _' |/ _ \_   | |\___ \
    | |\  | (_) | (_| |  __/ |__| |____) |
    |_| \_|\___/ \__,_|\___|\____/|_____/

            by @AhmedAbdulrahman           \/
EOF
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

brew_install() {

    declare -r CMD_ARGUMENTS="$4"
    declare -r FORMULA="$2"
    declare -r FORMULA_READABLE_NAME="$1"
    declare -r TAP_VALUE="$3"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Check if `Homebrew` is installed.

    if ! cmd_exists "brew"; then
        print_error "$FORMULA_READABLE_NAME ('Homebrew' is not installed)"
        return 1
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # If `brew tap` needs to be executed,
    # check if it executed correctly.

    if [ -n "$TAP_VALUE" ]; then
        if ! brew_tap "$TAP_VALUE"; then
            print_error "$FORMULA_READABLE_NAME ('brew tap $TAP_VALUE' failed)"
            return 1
        fi
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Install the specified formula.

    # shellcheck disable=SC2086
    if brew list "$FORMULA" $CMD_ARGUMENTS &> /dev/null; then
        print_success "$FORMULA_READABLE_NAME"
    else
        execute \
            "brew install $FORMULA $CMD_ARGUMENTS" \
            "$FORMULA_READABLE_NAME"
    fi

}

brew_prefix() {

    local path=""

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if path="$(brew --prefix 2> /dev/null)"; then
        printf "%s" "$path"
        return 0
    else
        print_error "Homebrew (get prefix)"
        return 1
    fi

}

brew_tap() {
    brew tap "$1" &> /dev/null
}

brew_update() {

    execute \
        "brew update" \
        "Homebrew (update)"

}

brew_upgrade() {

    execute \
        "brew upgrade" \
        "Homebrew (upgrade)"

}

get_homebrew_git_config_file_path() {

    local path=""

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if path="$(brew --repository 2> /dev/null)/.git/config"; then
        printf "%s" "$path"
        return 0
    else
        print_error "Homebrew (get config file path)"
        return 1
    fi

}

brew_opt_out_of_analytics() {

    local path=""

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Try to get the path of the `Homebrew` git config file.

    path="$(get_homebrew_git_config_file_path)" \
        || return 1

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Opt-out of Homebrew's analytics.
    if [ "$(git config --file="$path" --get homebrew.analyticsdisabled)" != "true" ]; then
        git config --file="$path" --replace-all homebrew.analyticsdisabled true &> /dev/null
    fi

    print_result $? "Homebrew (opt-out of analytics)"

}

agree_with_xcode_licence() {
    # Automatically agree to the terms of the `Xcode` license.
    sudo xcodebuild -license accept &> /dev/null
    print_result $? "Agree to the terms of the Xcode licence"

}

are_xcode_command_line_tools_installed() {
    xcode-select --print-path &> /dev/null
}

install_xcode() {
    # If necessary, prompt user to install `Xcode`.
    if ! is_xcode_installed; then
        open "macappstores://itunes.apple.com/en/app/xcode/id497799835"
    fi

    # Wait until `Xcode` is installed.

    execute \
        "until is_xcode_installed; do \
            sleep 5; \
         done" \
        "Xcode.app"

}

install_xcode_command_line_tools() {
    # If necessary, prompt user to install the `Xcode Command Line Tools`.
    xcode-select --install &> /dev/null

    # Wait until the `Xcode Command Line Tools` are installed.
    execute \
        "until are_xcode_command_line_tools_installed; do \
            sleep 5; \
         done" \
        "Xcode Command Line Tools"
}

is_xcode_installed() {
    [ -d "/Applications/Xcode.app" ]
}

set_xcode_developer_directory() {

    # Point the `xcode-select` developer directory to
    # the appropriate directory from within `Xcode.app`.
    sudo xcode-select -switch "/Applications/Xcode.app/Contents/Developer" &> /dev/null
    print_result $? "Make 'xcode-select' developer directory point to the appropriate directory from within Xcode.app"

}

create_gitconfig_local() {
    declare -r FILE_PATH="$HOME/.gitconfig.local"

    if [ ! -e "$FILE_PATH" ] || [ -z "$FILE_PATH" ]; then

        printf "%s\n" \
"; vim: ft=gitconfig

[commit]
    # Sign commits using GPG.
    # gpgsign = true
[user]
    name =
    email =
    # signingkey =" \
        >> "$FILE_PATH"
    fi
    print_result $? "$FILE_PATH"
}

create_zshrc_local() {
    declare -r FILE_PATH="$HOME/.zshrc.local"

    if [ ! -e "$FILE_PATH" ] || [ -z "$FILE_PATH" ]; then
        printf "%s\n" \
"#!/bin/bash

# Feel free to keep all your secret keys here

export NPM_AUTH_TOKEN=
export GITHUB_TOKEN=
export HOMEBREW_GITHUB_API_TOKEN=" \
        >> "$FILE_PATH"
    fi

    print_result $? "$FILE_PATH"
}

create_vimrc_local() {
    declare -r FILE_PATH="$HOME/.vimrc.local"

    if [ ! -e "$FILE_PATH" ]; then
        printf "" >> "$FILE_PATH"
    fi

    print_result $? "$FILE_PATH"
}

# Setup Github SSH Key
add_ssh_configs() {
    printf "%s\n" \
        "Host github.com" \
        "  IdentityFile $1" \
        "  LogLevel ERROR" >> ~/.ssh/config

    print_result $? "Add SSH configs"

}

copy_public_ssh_key_to_clipboard () {
    if cmd_exists "pbcopy"; then
        pbcopy < "$1"
        print_result $? "Copy public SSH key to clipboard"

    elif cmd_exists "xclip"; then
        xclip -selection clip < "$1"
        print_result $? "Copy public SSH key to clipboard"
    else
        print_warning "Please copy the public SSH key ($1) to clipboard"
    fi

}

generate_ssh_keys() {
    ask "Please provide an email address: " && printf "\n"
    ssh-keygen -t rsa -b 4096 -C "$(get_answer)" -f "$1"
    print_result $? "Generate SSH keys"

}

open_github_ssh_page() {
    declare -r GITHUB_SSH_URL="https://github.com/settings/ssh"

    # The order of the following checks matters
    if cmd_exists "xdg-open"; then
        xdg-open "$GITHUB_SSH_URL"
    elif cmd_exists "open"; then
        open "$GITHUB_SSH_URL"
    else
        print_warning "Please add the public SSH key to GitHub ($GITHUB_SSH_URL)"
    fi

}

set_github_ssh_key() {
    local sshKeyFileName="$HOME/.ssh/github"
    # If there is already a file with that name, generate another, unique, file name.
    if [ -f "$sshKeyFileName" ]; then
        sshKeyFileName="$(mktemp -u "$HOME/.ssh/github_XXXXX")"
    fi

    generate_ssh_keys "$sshKeyFileName"
    add_ssh_configs "$sshKeyFileName"
    copy_public_ssh_key_to_clipboard "${sshKeyFileName}.pub"
    open_github_ssh_page
    test_ssh_connection \
        && rm "${sshKeyFileName}.pub"

}

test_ssh_connection() {
    while true; do
        ssh -T git@github.com &> /dev/null
        [ $? -eq 1 ] && break
        sleep 5
    done
}
