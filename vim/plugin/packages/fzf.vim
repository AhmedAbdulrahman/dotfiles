""
" Fuzzy finder fzf as Vim plugin."
""

let g:fzf_files_options = '--preview "bat --color always --wrap never --style numbers,changes {2..} | head -'.&lines.'"'

if !empty(expand($VIM_FZF_LOG))
  let g:fzf_commits_log_options = $VIM_FZF_LOG
endif

"Override `fzf` options."
if !empty(expand($FZF_DEFAULT_OPTS))
  let $FZF_DEFAULT_OPTS .=" --layout=reverse --margin='1,3' --no-inline-info --bold --color='fg+:15,bg+:-1,info:8,prompt:0,pointer:12'"
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
let g:fzf_history_dir = $HOME . '/.vim/cache/share/fzf'

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
  let &grepprg = 'ag --nogroup --nocolor --column'
else
  let &grepprg = 'grep -rn $* *'
endif
command! -nargs=1 -bar Grep execute 'silent! grep! <q-args>' | redraw! | copen

" Ripgrep Search"
if executable('rg')

	" Search in all files"
	command! -bang -nargs=* Rg
		\ call fzf#vim#grep(
		\ "rg --column --line-number --no-heading --color=always --smart-case --fixed-strings --ignore-case --hidden --follow ".shellescape(<q-args>), 1,
		\ fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'down:60%:hidden', '?'),
		\ <bang>0)

endif

" Search for files"
command! -bang -nargs=? -complete=dir Files
	\ call fzf#run(fzf#wrap(fzf#vim#with_preview({
	\   'source': "rg --files --hidden --follow --no-messages --smart-case ".expand(<q-args>)
	\ }, 'down:60%:hidden', '?')))

" Search for buffers"
command! -bang -nargs=* -complete=buffer Buffers
  	\ call fzf#vim#buffers(<q-args>, fzf#vim#with_preview('down:60%:hidden', '?'), <bang>0)

imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
inoremap <expr> <c-x><c-d> fzf#vim#complete#path('blsd')
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Define key mappings."
nnoremap <silent> <leader>/ :Rg<cr>
nnoremap <silent> <leader><leader>/ :GRg<cr>
nnoremap <silent> <expr> <leader><tab> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Files\<cr>"
nnoremap <silent> <Leader><C-p> :FGitFiles<Enter>
nnoremap <silent> <Leader><C-s> :FGFiles?<Enter>
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