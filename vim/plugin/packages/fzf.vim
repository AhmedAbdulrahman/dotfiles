""
" Fuzzy finder fzf as Vim plugin."
""

let $FZF_DEFAULT_OPTS='--layout=reverse'
if !empty(expand($FZF_CTRL_T_OPTS))
  let g:fzf_files_options = $FZF_CTRL_T_OPTS
endif
if !empty(expand($VIM_FZF_LOG))
  let g:fzf_commits_log_options = $VIM_FZF_LOG
endif

" Add prefix 'Fzf' commands for grouping."
let g:fzf_command_prefix = 'F'

" Jump to the existing window if possible."
let g:fzf_buffers_jump = 1

" Directly execute the command without appending anything."
let g:fzf_commands_expect = 'alt-enter'

" Set custom layout."
let g:fzf_layout = {
	\ 'window': 'silent 18split enew'
\ }

" Set actions manually."
let g:fzf_action = {
	\ 'ctrl-e': 'split',
	\ 'ctrl-v': 'vsplit',
	\ 'ctrl-t': 'tab split'
\ }

" History directory."
let g:fzf_history_dir = $HOME . '/.vim/cache/share/fzf/'

" Customize `fzf` colors to match current color scheme."
let g:fzf_colors = {
	\ 'fg': ['fg', 'Normal'],
	\ 'bg': ['bg', 'Normal'],
	\ 'hl': ['fg', 'Comment'],
	\ 'fg+': ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
	\ 'bg+': ['bg', 'CursorLine', 'CursorColumn'],
	\ 'hl+': ['fg', 'Statement'],
	\ 'info': ['fg', 'Comment'],
	\ 'border': ['fg', 'Ignore'],
	\ 'prompt': ['fg', 'Conditional'],
	\ 'pointer': ['fg', 'Exception'],
	\ 'marker': ['fg', 'Keyword'],
	\ 'spinner': ['fg', 'Label'],
	\ 'header': ['fg', 'Comment']
\ }

" Define key mappings."
nnoremap <silent> <leader><tab> :Files<CR>
nnoremap <silent> <C-p> :FGFiles<Enter>
nnoremap <silent> <Leader><C-p> :FFiles<Enter>
nnoremap <silent> <M-x> :FCommands<Enter>
nnoremap <silent> <M-b> :FBuffers<Enter>
nnoremap <silent> <C-f> :FTags<Enter>
nnoremap <silent> <Leader>h :FHelptags<Enter>
nnoremap <silent> <Leader>: :FHistory:<Enter>
nnoremap <silent> <Leader>/ :FHistory/<Enter>
nnoremap <silent> <Leader>` :FMarks<Enter>

" Disable status line for fzf buffers."
augroup fzfdisablestatusline
	autocmd!
	autocmd User FzfStatusLine setlocal statusline=\  |
augroup end

" The Silver Searcher"
if executable('ag')
    " Use ag over grep"
    set grepprg=ag\ --nogroup\ --nocolor
endif

if executable('rg')
    set grepprg=rg\ --vimgrep\ --color=never\ --glob\ '"!*/plugins/*"'

    " Ripgrep and fzf settings"
	command! -bang -nargs=* Rg
		\ call fzf#vim#grep(
		\ 'rg --column --line-number --no-heading --glob "!*/dist/*" --glob "!*/plugins/*" -g "!*.sql" -g "!*.min.js" --color=always '.shellescape(<q-args>), 1,
		\ <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
  		\           : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:hidden', '?'),
		\ <bang>0)

endif

command! -bang -nargs=? -complete=dir Files
      \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
nnoremap <leader>/ :Rg<cr>