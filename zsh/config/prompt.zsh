#===============================================================================
#  Author: Ahmed Abdulrahman
#  Email: a.kasapbashi@gmail.com
#  Created: 2019-10-20 20:20
#===============================================================================

# Spaceship custom configuration

# ------------------
# Configuration
# ------------------

# REACT
SPACESHIP_REACT_SHOW="${SPACESHIP_REACT_SHOW:=true}"
SPACESHIP_REACT_SUFFIX="${SPACESHIP_REACT_SUFFIX:="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_REACT_SYMBOL="${SPACESHIP_REACT_SYMBOL:="⚛️ "}"
SPACESHIP_REACT_DEFAULT_VERSION="${SPACESHIP_REACT_DEFAULT_VERSION:=""}"
SPACESHIP_REACT_COLOR="${SPACESHIP_REACT_COLOR:="cyan"}"

# ------------------
# Section
# ------------------

_is_react_project() {
	# Uncomment if you are not using jq tool
  # node -p "r=require('./package.json'); r.dependencies['$1']" 2>/dev/null
  # node -p "require('./package.json').dependencies['$1']"
  jq -r ".dependencies.$1" package.json 2>/dev/null
}

spaceship_react() {
  # If SPACESHIP_REACT_SHOW is false, don't show React section
  [[ $SPACESHIP_REACT_SHOW == false ]] && return

  # Show REACT status only inside an NODE/NPM project
  # [[ -f package.json || -d node_modules ]] && return

  local react_version=$(_is_react_project "react")

  [[ $react_version == "undefined" || $react_version == "" || $react_version == "null" ]] && return

  # Display REACT section
  spaceship::section \
    "$SPACESHIP_REACT_COLOR" \
    "$SPACESHIP_REACT_PREFIX" \
    "${SPACESHIP_REACT_SYMBOL} ${react_version}" \
    "$SPACESHIP_REACT_SUFFIX"
}

  SPACESHIP_PROMPT_ORDER=(
    dir
    git
    react
    line_sep
    char
  )


# ------------------------
# Generate Random Emojis
# ------------------------

EMOJIS=(👻 🚀 🐞 🎨 🍕 🐭 ☕️ 💀 👀 🐼 🐶 🐬 🐳 💰 💞 🍪 🐌 🍄 )

SPACESHIP_DIR_TRUNC='1' # show only last directory
SPACESHIP_DIR_TRUNC_PREFIX="${EMOJIS[$RANDOM % ${#EMOJIS[@]} + 1]} "
SPACESHIP_CHAR_SYMBOL="» %b"

# EXIT CODE
SPACESHIP_EXIT_CODE_SHOW=true
SPACESHIP_EXIT_CODE_PREFIX="("
SPACESHIP_EXIT_CODE_SUFFIX=") "
SPACESHIP_EXIT_CODE_SYMBOL="✘ "
SPACESHIP_EXIT_CODE_COLOR="red"
