#!/usr/bin/env zsh

# ---------------------------------------------
# Shortcust
# ---------------------------------------------
alias dotfiles='cd ~/dotfiles'
alias dl="cd ~/Downloads"
alias dk="cd ~/Desktop"
alias p="cd ~/Projects"
alias docs='cd ~/Documents/'
alias ds='cd ~/.ssh'
alias dp='cd ~/Dropbox'
alias cdbin='cd /usr/local/bin/'

# ---------------------------------------------
# Moving around
# ---------------------------------------------
alias ..="cd .."
alias ...="cd ../.."
alias cd..="cd .."
alias oo='open .'

# ---------------------------------------------
# Copy & Move
# ---------------------------------------------
# `rm` and `mv` are so dangerous, they must always ask for confirmation.
alias rm="${aliases[rm]:-rm} -i"
alias mv="${aliases[mv]:-mv} -iv"
alias cp="${aliases[cp]:-cp} -iv"
alias ln="${aliases[ln]:-ln} -iv"
alias mkdir="${aliases[mkdir]:-mkdir} -p"
alias e="${(z)VISUAL:-${(z)EDITOR}}"
alias which='which -a'
alias type='type -a'
alias trimcopy="tr -d '\n' | pbcopy"	# Trim new lines and copy to clipboard

# ---------------------------------------------
# Npm & Yarn
# ---------------------------------------------
alias npm-update="npx npm-check -u"
alias flush-npm="rm -rf node_modules && npm i && echo NPM is done"
alias nicache="npm install --prefer-offline"
alias yoff="yarn add --offline";
alias ypm="echo \"Installing deps without lockfile and ignoring engines\" && yarn install --no-lockfile --ignore-engines"
alias KABOOM="yarn global upgrade --latest;brew update; brew upgrade; brew cleanup -s; brew doctor"

# ---------------------------------------------
# Git
# ---------------------------------------------
alias commit='git commit -S -s -m'
alias amend="git commit --amend"
alias master="git checkout master"
alias develop="git checkout develop"
alias status="git status"
alias push="git push"
alias pull='git pull'
alias save='git stash save -u'
alias undo='git reset HEAD~'			# Undo commit and unstage all files
alias undosoft='git reset --soft HEAD~'	# Undo commit and keep all files staged
alias undohard='git reset --hard HEAD~'	# Undo the commit and completely remove all changes
alias undopush='git push -f origin HEAD^:master'
alias unstage='git reset --'

# ---------------------------------------------
# Timewarrior & Taskwarrior
# ---------------------------------------------
alias tiw='timew'
alias "tiw sum"='timew summary'
alias "tiws"='timew start'
alias "tiwp"='timew stop'
alias "tiwt"='timew stop'
# reports, in current context
alias tard="task burndown.daily"
alias tarw="task burndown.weekly"
alias tarm="task burndown.monthly"
# Closed today
alias twctoday='task end:today all'
# Done today
alias twdtoday='task end:today status:completed all'
alias twlist="clear; task list -BLOCKED"
alias twcl="clear; task newest"
# list main categories (projects)
alias twlistprojects="task projects rc.list.all.projects=yes 2>/dev/null | grep -E '^\w'"
# list all projects
alias twlistall="task projects rc.list.all.projects=yes"
alias twclear="clear; task +READY"
alias twsum="task summary"
alias twallsum="task summary rc.summary.all.projects=yes"

# ---------------------------------------------
# IP Addresses
# ---------------------------------------------
alias ip='dig +short myip.opendns.com @resolver1.opendns.com'
alias localip="ipconfig getifaddr en1"
alias ips="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"
alias myip="ifconfig | grep 'inet ' | grep -v 127.0.0.1 | awk '{print \$2}'"
alias lsof-tcp='lsof -iTCP'
alias lsof-tcp-listen='lsof -iTCP -sTCP:LISTEN -P'
alias hosts='sudo $EDITOR /etc/hosts'

# ---------------------------------------------
# Tmux
# ---------------------------------------------
alias tmux='tmux -f "$HOME/.tmux.conf"'
alias mks='tmux kill-session -t'
alias mkS='tmux kill-server'
alias tn='tmux new-session -s'
alias tl='tmux list-sessions'

# Conditional Tmux aliases
[[ $TERM == *"tmux"* ]] && alias :sp='tmux split-window'
[[ $TERM == *"tmux"* ]] && alias :vs='tmux split-window -h'
# SSH when in TMUX needs to explicitly pass $TERM
[[ $TERM == *"tmux"* ]] && alias ssh="TERM=xterm-256color ssh"
[[ $TERM == *"tmux"* ]] && alias vagrant="TERM=xterm-256color vagrant"
[[ $TERM == *"tmux"* ]] && alias brew="TERM=xterm-256color brew"

# ---------------------------------------------
# Utilities
# ---------------------------------------------
alias "?"="pwd"
alias sz='exec zsh'
alias refresh='source ~/.zsh/.zshrc; echo "Reloaded .zshrc."'
alias less='less -r'
alias tf='tail -f'
alias cl='clear'
alias note='nvim ~/Documents/Notes/note'
alias reload="exec ${SHELL} -l"	# Reload the shell (i.e. invoke as a login shell)
alias path='echo -e ${PATH//:/\\n}'	# Print each PATH entry on a separate line
alias apache="sudo apachectl"
alias chmox='chmod -x'
alias python=python3
alias bye='sudo shutdown -h now'
alias ios='open -a /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Applications/iPhone\ Simulator.app'
alias chromekill="ps ux | grep '[C]hrome Helper --type=renderer' | grep -v extension-process | tr -s ' ' | cut -d ' ' -f2 | xargs kill"	# Kill all the tabs in Chrome to free up memory

# ---------------------------------------------
# System
# ---------------------------------------------
alias cpu='top -n 10 -o cpu -O time -stats pid,command,cpu,cpu_me,time,threads,ports' # CPU
alias mem='top -o rsize' # Memory
alias df='df --all --si --print-type' # Display all disk usage statistics with SI units and FS types.
alias du='du --max-depth=1 --si' # Display size of files and folders under current directory.
alias diskspace='du -h -d 2'
alias fs="stat -f \"%z bytes\""		# File size
alias diskspace_report="df -P -kHl"
alias free_diskspace_report="diskspace_report"
# alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"	# Lock the screen (when going AFK = Away From Keyboard)

# Cleaners
alias rm_modules="find . -name "node_modules" -type d -prune -exec rm -rf '{}' +"
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"	# Recursively delete `.DS_Store` files
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl; sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"
# alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes;sudo rm -rfv ~/.Trash"
alias flushdns="sudo dscacheutil -flushcache; \
                       sudo killall -HUP mDNSResponder"

# ---------------------------------------------
# Useful stuff - for LiveStream
# ---------------------------------------------
alias showhidden="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder" # Show hidden files in Finder
alias hidehidden="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder" # Hide hidden files in Finder
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"	# Show all desktop icons
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder" # Hide all desktop icons
# Livestream Mode - (no dock, hide, clean trash ...etc)
alias livestream_mode='defaults write com.apple.dock autohide -bool true;
							 killall Dock;
							 defaults write com.apple.menuextra.clock IsAnalog -bool true;
							 killall SystemUIServer;
							 rm -rf ~/.Trash/*;'

# Set everything back to Normal (Regular Mode)
alias regular_mode='defaults write com.apple.dock autohide -bool false
							killall Dock;
							defaults write com.apple.menuextra.clock IsAnalog -bool false;
							killall SystemUIServer;'

# ---------------------------------------------
# Conditional aliases
# ---------------------------------------------
if (( $+commands[nvim] )) then;
  	# Use `\vim` or `command vim` to get the real vim.
	alias vim='nvim'
	alias vv='vim $(fzf)'
	alias ez="vim ~/.zsh/.zshrc"
fi

if (( $+commands[hub] )); then
    alias git=hub
fi
# better ls
if (($+commands[colorls])); then
	alias ls="echo; colorls -A --group-directories-first"
fi

if (( $+commands[lsd] )); then
  alias ls="lsd "
  alias ll="lsd --tree --almost-all --group-dirs first "
elif (( $+commands[tree] )); then
  alias ll="type tree >/dev/null && tree -da -L 1 || l -d .*/ */ "
else
  alias ll="echo 'You have to install lsd or tree'"
fi

# Jq
if (( $+commands[jq] )) then;
  alias formatJSON='jq .'
else
  alias formatJSON='python -m json.tool'
fi

# File Download
if (( $+commands[aria2c] )); then
  alias get='aria2c --continue --remote-time --file-allocation=none'
elif (( $+commands[curl] )); then
  alias get='curl --continue-at - --location --progress-bar --remote-name --remote-time'
elif (( $+commands[wget] )); then
  alias get='wget --continue --progress=bar --timestamping'
fi

if (( $+commands[htop] )); then
  alias top=htop
fi

# Ranger file explorer
if (( $+commands[ranger] )); then
    unalias r 2>/dev/null
    alias r=ranger
fi