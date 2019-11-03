""
" Fuzzy finder fzf as Vim plugin."
""

if !empty(expand($FZF_CTRL_T_OPTS))
  let g:fzf_files_options = $FZF_CTRL_T_OPTS
endif

if !empty(expand($VIM_FZF_LOG))
  let g:fzf_commits_log_options = $VIM_FZF_LOG
endif

if !empty(expand($FZF_DEFAULT_OPTS))
  let $FZF_DEFAULT_OPTS .= ' --layout=reverse --margin=1,4'
endif

" Add prefix 'Fzf' commands for grouping."
let g:fzf_command_prefix = 'F'

" Jump to the existing window if possible."
let g:fzf_buffers_jump = v:true

" Directly execute the command without appending anything."
let g:fzf_commands_expect = 'alt-enter'

" Set custom layout."
let g:fzf_layout = {
	\ 'window': ahmed#settings#fzf_window()
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

" Ag Search"
if executable('ag')
    " Use ag over grep"
    set grepprg=ag\ --nogroup\ --nocolor
endif

" Ripgrep Search"
if executable('rg')
    set grepprg=rg\ --vimgrep\ --color=never\ --glob\ '"!*/plugins/*"'

    " Ripgrep and fzf settings"
	command! -bang -nargs=* Rg
		\ call fzf#vim#grep(
		\ 'rg --column --line-number --no-heading --glob "!*/dist/*" --glob "!*/plugins/*" -g "!*.sql" -g "!*.min.js" --color=always '.shellescape(<q-args>), 1,
		\ <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
  		\           : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%', '?'),
		\ <bang>0)

endif

command! -bang -nargs=? -complete=dir GFiles
	\ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview('right:60%', '?'), <bang>0)

command! -bang -nargs=? -complete=dir Files
	\ call fzf#vim#files(<q-args>, fzf#vim#with_preview('right:60%', '?'), <bang>0)

command! -bang -nargs=* -complete=buffer Buffers
  	\ call fzf#vim#buffers(<q-args>, fzf#vim#with_preview('right:60%', '?'), <bang>0)

imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Define key mappings."
nnoremap <silent> <leader>/ :Rg<cr>
nnoremap <silent><expr> <leader><tab> ahmed#settings#is_git() ? ':GFiles<CR>' : ':Files<CR>'

nnoremap <silent> <Leader><C-p> :FFiles<Enter>
nnoremap <silent> <M-x> :FCommands<Enter>
nnoremap <silent> <M-b> :Buffers<Enter>
nnoremap <silent> <C-f> :FTags<Enter>
nnoremap <silent> <Leader>h :FHelptags<Enter>
nnoremap <silent> <Leader>: :FHistory:<Enter>
nnoremap <silent> <Leader>; :FHistory/<Enter>
nnoremap <silent> <Leader>m :FMarks<Enter>

function! s:fzf_statusline() abort
  setlocal statusline=%4*\ fzf\ %6*V:\ ctrl-v,\ H:\ ctrl-x,\ Tab:\ ctrl-t
endfunction

" Disable status line for fzf buffers."
augroup MyFZF
	autocmd!
	autocmd! User FzfStatusLine call <SID>fzf_statusline()
augroup END

function! FzfSpellSink(word)
  exe 'normal! "_ciw'.a:word
endfunction

function! FzfSpell()
  let suggestions = spellsuggest(expand('<cword>'))
  return fzf#run({'source': suggestions, 'sink': function('FzfSpellSink'), 'down': 10 })
endfunction

nnoremap z= :call FzfSpell()<CR>