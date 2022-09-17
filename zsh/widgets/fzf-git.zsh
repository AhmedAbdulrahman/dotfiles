#  vim: set ts=4 sw=4 tw=80 ft=zsh et :

# Register functions as widgets.
foreach widget (
	# Built-in
	'add-surround surround'
	'delete-surround surround'
	'change-surround surround'
	select-quoted
	select-bracketed

	# Custom
	fzf-file-edit-widget
	fzf-history-widget
) {
	eval zle -N $widget
}
unset widget

# ALT-E - Edit selected file
function fzf-file-edit-widget() {
    setopt localoptions pipefail 2> /dev/null
    local files
    files=$(eval "$FZF_ALT_E_COMMAND" |
        FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse $FZF_DEFAULT_OPTS $FZF_ALT_E_OPTS" fzf -m |
        sed 's/^\s\+.\s//')
    local ret=$?

    [[ $ret -eq 0 ]] && echo $files | xargs sh -c "$EDITOR \$@ </dev/tty" $EDITOR

    zle redisplay
    typeset -f zle-line-init >/dev/null && zle zle-line-init
    return $ret
}
zle     -N    fzf-file-edit-widget
bindkey '\ee' fzf-file-edit-widget

# CTRL-R - Paste the selected command from history into the command line
function fzf-history-widget() {
    local selected num
    setopt localoptions noglobsubst noposixbuiltins pipefail 2> /dev/null
    selected=( $(fc -rl 1 | awk '{FIRST=$1; $1=""; if (!x[$0]++) {$1=FIRST; print $0}}' |
        FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS -n2..,.. --tiebreak=index --bind=ctrl-r:toggle-sort $FZF_CTRL_R_OPTS --query=${(qqq)LBUFFER} +m" $(__fzfcmd)) )
    local ret=$?
    if [ -n "$selected" ]; then
        num=$selected[1]
        if [ -n "$num" ]; then
            zle vi-fetch-history -n $num
        fi
    fi
    zle redisplay
    typeset -f zle-line-init >/dev/null && zle zle-line-init
    return $ret
}
zle     -N   fzf-history-widget
bindkey '^R' fzf-history-widget

function is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}
# Show git modified files (or all files if none was modified)
function fzf_gg() {
  is_in_git_repo || return
  modified_files=$(git -c color.status=always status --short)
  if [[ -n $modified_files ]]; then
  git -c color.status=always status --short | fzf-down -m --ansi --select-1 --exit-0 --nth 2..,.. \
    --preview-window down:50%:wrap \
    --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1}) | head -500' |
  cut -c4- | sed 's/.* -> //'
  return
  fi
  git ls-files | awk '{print $4}' | sort -u |
  fzf-down -m --ansi --select-1 --exit-0 --nth 2..,.. \
    --preview-window down:50%:wrap \
    --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1}) | head -500' |
   sed 's/.* -> //'
}
# Show git files
function fzf_gv() {
  is_in_git_repo || return
  git ls-files | 
  fzf-down -m --ansi --select-1 --exit-0 --nth 2..,.. \
    --preview-window down:50%:wrap \
    --preview 'bat --color always --style=header,grid --line-range :300 --terminal-width=-4 {}' |
   sed 's/.* -> //'
}

# Show git conflicted files
function fzf_gu() {
  is_in_git_repo || return
  git ls-files -u | awk '{print $4}' | sort -u |
  fzf-down -m --ansi --select-1 --exit-0 --nth 2..,.. \
    --preview-window down:50%:wrap \
    --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1}) | head -500' |
   sed 's/.* -> //'
}
# Git local branches, ordered by last activity
function fzf_gb() {
  is_in_git_repo || return
  branches=$(git for-each-ref --sort=committerdate refs/heads --format='%(refname:short) (last activity: %(color:green)%(committerdate:relative)%(color:reset))')
  echo $branches |
  fzf-down --ansi --multi --tac --preview-window right:60% \
    --preview-window down:50%:wrap \
    --preview 'git log --color=always --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" $(echo {} | cut -d" " -f1)' |
  cut -d' ' -f1
}
# Git remote branches, ordered by last activity
function fzf_gf() {
  is_in_git_repo || return
  branches=$(git for-each-ref --sort=committerdate refs/remotes --format='%(refname:short) (last activity: %(color:green)%(committerdate:relative)%(color:reset))')
  echo $branches |
  fzf-down --ansi --multi --tac --preview-window right:60% \
    --preview-window down:50%:wrap \
    --preview 'git log --color=always --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" $(echo {} | cut -d" " -f1)' |
  cut -d' ' -f1
}
# Git tags
function fzf_gt() {
  is_in_git_repo || return
  git tag --sort -version:refname |
  fzf-down --multi --preview-window right:70% \
    --preview-window down:50%:wrap \
    --preview 'git show --color=always {} | head -200'
}
# Git commit hashes
function fzf_gh() {
  is_in_git_repo || return
  local currentBranch=$(git rev-parse --abbrev-ref HEAD)
  git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --color=always "${currentBranch}" |
  fzf-down --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
    --header 'Press CTRL-S to toggle sort' \
    --preview-window down:50%:wrap \
    --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always | head -200' |
  grep -o "[a-f0-9]\{7,\}"
}
# Git remotes
function fzf_gr() {
  is_in_git_repo || return
  git remote -v | awk '{print $1 "\t" $2}' | uniq |
  fzf-down --tac \
    --preview 'git log --oneline --graph --color=always --date=short --pretty="format:%C(auto)%cd %h%d %s" {1} | head -200' |
  cut -d$'\t' -f1
}

# Git stash
function fzf-gs-widget() {
  is_in_git_repo || return
  emulate -L sh
  local out q k sha
  while out=$(
    git stash list --pretty="%C(yellow)%gd %C(yellow)%h %>(14)%Cgreen%cr %C(blue)%gs" |
    fzf-down --ansi --no-sort --query="$q" --print-query \
        --preview-window down:50%:wrap \
        --header "Ctrl-a: apply stash | Ctrl-d: diff | Ctrl-b: create branch | Ctrl-s: drop | Ctrl-p: Pop" \
        --preview "echo {} | grep -o '[a-f0-9]\{7\}' | head -1 | xargs -I % sh -c 'git stash show --color=always % | head -200 '" \
        --expect=ctrl-d,ctrl-b,ctrl-s,ctrl-a,ctrl-p);
  do
    out=( "${(@f)out}")
    q="${out[0]}"
    k="${out[1]}"
    stashLine="${out[-1]}"
    stashIdx="${stashLine%% *}"
    sha="${stashLine#${stashIdx} }"
    sha="${sha%% *}"
    [[ -z "$sha" ]] && continue
    if [[ "$k" == 'ctrl-d' ]]; then
      git diff $sha
    elif [[ "$k" == 'ctrl-b' ]]; then
      git stash branch "${FSTASH_BRANCH_PREFIX:-stash-}$sha" $sha
      break;
    elif [[ "$k" == 'ctrl-s' ]]; then
      git stash drop $stashIdx
    elif [[ "$k" == 'ctrl-a' ]]; then
      git stash apply $sha
      break;
    elif [[ "$k" == 'ctrl-p' ]]; then
      git stash pop $stashIdx
      break;
    fi
  done
  zle reset-prompt
}

function join-lines() {
  local item
  while read item; do
    echo -n "${(q)item} "
  done
}

function bind-git-helper() {
  local char
  for c in $@; do
    eval "function fzf-g$c-widget() { local result=\$(fzf_g$c | join-lines); zle reset-prompt; LBUFFER+=\$result }"
    eval "zle -N fzf-g$c-widget"
    eval "bindkey '^g^$c' fzf-g$c-widget"
  done
}

bind-git-helper g b t r h f u v
unset -f bind-git-helper
# Stash helper works kinda different, so he needs it's own binding rule
zle -N fzf-gs-widget
bindkey '^g^s' fzf-gs-widget