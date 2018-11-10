"Use UTF-8 without BOM"
set encoding=UTF-8

"Make Vim more useful"
set nocompatible

"--------------"
"Vundle Plugins"
"--------------"
if filereadable(expand("$HOME/.vim/plugins.vim"))
  source $HOME/.vim/plugins.vim
endif

if filereadable(expand("$HOME/.vim/settings.vim"))
  source $HOME/.vim/settings.vim
endif

"--------"
"Settings"
"--------"

" Set relative line numbers"
if exists("&relativenumber")
	set relativenumber
  au BufReadPost,BufNewFile * set relativenumber
endif

au BufRead,BufNewFile *.json set ft=json syntax=javascript

if executable('jq')
  autocmd BufRead *.json :%!jq .
endif

"Enable omni completion"
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

"LESS"
au BufNewFile,BufRead *.less set filetype=css

autocmd BufNewFile,BufRead *.md set filetype=markdown

"Common Ruby files"
au BufRead,BufNewFile Rakefile,Capfile,Gemfile,.autotest,.irbrc,*.treetop,*.tt set ft=ruby syntax=ruby

"Common javascript files"
au BufRead,BufNewFile *.jsx,*.ts set ft=javascript syntax=javascript

"ZSH"
au BufRead,BufNewFile .zsh_rc,.functions,.commonrc set ft=zsh

"Speed up transition from modes"
if ! has('gui_running')
  set ttimeoutlen=10
  augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=0
    au InsertLeave * set timeoutlen=1000
  augroup END
endif

"------------------------"
" Mappings configurationn"
"------------------------"

"Mouse scrolling"
map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>

" Change Working Directory to that of the current file"
cmap cwd lcd %:p:h
cmap cd. lcd %:p:h

" Status Line"
set statusline=%<%f\ %{fugitive#statusline()}\ %h%m%r%=%-14.(%l,%c%V%)\ %{strlen(&fenc)?&fenc:'none'}\ %P
"hi StatusLine ctermbg=0 ctermfg=7"
"hi StatusLineNC ctermbg=0 ctermfg=2"
let g:Powerline_symbols = 'fancy'

"autocomplete window colours"
highlight Pmenu ctermfg=15 ctermbg=239
highlight PmenuSel ctermfg=250 ctermbg=236

"Speed up viewport scrolling"
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

"Delete buffer without closing window"
map <Leader>d :BD<cr>

"Move faster up/down"
nmap <C-j> 5j
xmap <C-j> 5j
nmap <C-k> 5k
xmap <C-k> 5k

"copy line and leave a marker"
nnoremap yy yymy

"Highlighted yank"
let g:highlightedyank_highlight_duration = 300

"Disable arrow keys"
inoremap <Up>    <NOP>
nnoremap <Up>    <NOP>
inoremap <Down>  <NOP>
nnoremap <Down>  <NOP>
inoremap <Left>  <NOP>
nnoremap <Left>  <NOP>
inoremap <Right> <NOP>
nnoremap <Right> <NOP>

"split current window"
nnoremap <C-w>- :split file<CR>
nnoremap <C-w>\ :vsplit file<CR>
nnoremap <leader>- :split file<CR>
nnoremap <leader>\ :vsplit file<CR>

"easy regex replace for current word"
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/
xnoremap <leader>s :<c-u>%s/\%V

"select but dont jump"
nnoremap <Leader>8 *#
nnoremap <Leader>3 #*

"Indent/unident block"
"nnoremap <leader>] >i[
nnoremap <leader>[ <i[
nnoremap <leader>} >i{
nnoremap <leader>{ <i{
"
"Buffer navigation"
map <Tab><Tab> <C-^>
map <Leader>l :bnext<CR>
map <Leader>h :bprev<CR>

"when pairing some braces or quotes, put cursor between them"
inoremap <>   <><Left>
inoremap ()   ()<Left>
inoremap {}   {}<Left>
inoremap []   []<Left>
inoremap ""   ""<Left>
inoremap ''   ''<Left>
inoremap ``   ``<Left>

"Buffer resizing"
nnoremap <Leader>H :vertical resize -4<cr>
nnoremap <Leader>J :resize +5<cr>
nnoremap <Leader>K :resize -5<cr>
nnoremap <Leader>L :vertical resize +5<cr>

"Fix page up and down"
map <PageUp> <C-U>
map <PageDown> <C-D>
imap <PageUp> <C-O><C-U>
imap <PageDown> <C-O><C-D>

" Close Quickfix window"
map <leader>qq :cclose<CR>

"save using <C-s> in every mode when in operator-pending or insert, takes you to normal mode"
nnoremap <C-s> :write<Cr>
vnoremap <C-s> <C-c>:write<Cr>
inoremap <C-s> <Esc>:write<Cr>
onoremap <C-s> <Esc>:write<Cr>
"Fast saves"
nmap <leader>w :w!<cr>

"close pane using <C-w>"
fun! s:__bclose()
  if (len(getbufinfo({'buflisted': 1})) > 1)
    bdelete
  endif
endfun

" since I know it from Chrome / Atom (cmd+w) and do not use the <C-w> mappings anyway"
noremap <silent> <C-w> :call <SID>__bclose()<Cr>

" I like things that wrap back to start after end, quickfix stops at last error but if I specify cn again, I want to definitely go to the next error (I can see line numbers in sidebar to track where I am anyway)"
fun! s:__qfnxt()
  try
    cnext
  catch
    crewind
  endtry
endfun

fun! s:__qfprv()
  try
    cprev
  catch
    clast
  endtry
endfun

"shortcuts for quickfix list"
nnoremap <silent> <C-n> :call <SID>__qfnxt()<Cr>
nnoremap <silent> <C-b> :call <SID>__qfprv()<Cr>

"strip trailing whitespace"
noremap <Leader>ss :call StripWhitespace()<CR>

map q <Nop>
map <F6> :setlocal spell!<CR>
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"          "<TAB>: completion."  


" Plugins Configuration "
"------------------------"

"NerdTree"
let NERDTreeShowHidden=1
let g:NERDTreeWinSize=40	                                        "The default of 31 is just a little too narrow."
let g:NERDTreeMinimalUI=1	                                        "Disable display of '?' text and 'Bookmarks' label."
let g:NERDTreeCreatePrefix='silent keepalt keepjumps'             "Let <Leader><Leader> (^#) return from NERDTree window."
let g:NERDTreeMouseMode=2	                                        "Single-click to toggle directory nodes, double-click to open non-directory nodes."
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''
map <Leader>n :NERDTreeToggle<CR>                                 "NERDTree"
nmap <Leader>nt <Plug>NERDTreeTabsToggle<CR>                      "NERDTreeTabs"

function! AttemptSelectLastFile() abort
  let l:previous=expand('#:t')
  if l:previous !=# ''
    call search('\v<' . l:previous . '>')
  endif
endfunction

if has('autocmd')
  augroup AhmedNERDTree
    autocmd!
    autocmd User NERDTreeInit call AttemptSelectLastFile()
  augroup END
endif

" Undotree toggle"
nnoremap <Leader>u :UndotreeToggle<cr>

"TagBar"
map <C-m> :TagbarToggle<CR>

"Gruvbox"
"-------"
let g:gruvbox_vert_split = 'bg1'
let g:gruvbox_sign_column = 'bg0'

"JSDOC"
"-----"
let g:javascript_plugin_jsdoc = 1	                      " Enable JSDoc highlighting "
let g:javascript_plugin_flow = 1	                      " Enable Flow syntax highlighting "
" Allow JSX syntax in JS files "

"Emmet"
"-----"
let g:jsx_ext_required = 0	                            " lets emmet use jsx shortcuts"
"Set Emmet to apply jsx settings to javascript.jsx filetype"
let g:user_emmet_settings = {
\  'javascript.jsx' : {
\      'extends' : 'jsx',
\      'quote_char': "'",
\  },
\}
autocmd FileType html,css,javascript,jsx EmmetInstall
imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")

"Prettier"
"--------"
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue PrettierAsync
nmap <Leader>p <Plug>(Prettier)

"UiSnippets"
"----------"
let g:UltiSnipsExpandTrigger="<Tab>"
let g:UltiSnipsJumpForwardTrigger="<Tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"
let g:UltiSnipsSnippetsDir="~/.vim/ultisnips"
let g:UltiSnipsSnippetDirectories=['ultisnips']

"Tagged Template"
"---------------"
"NOTE: Tag on the left, filetype on the right "
let g:taggedtemplate#tagSyntaxMap = {
  \ "html": "html",
  \ "md":   "markdown",
  \ "css":  "css" }
autocmd FileType javascript,javascript.jsx,typescript : call taggedtemplate#applySyntaxMap()

" ALE "
"---------"
let local_eslint = finddir(getcwd() . '/node_modules') . '/.bin/eslint'
if matchstr(local_eslint, "^\/\\w") == ''
    let local_eslint = local_eslint
endif

let g:ale_javascript_eslint_executable = local_eslint

"enable completion where available."
let g:ale_completion_enabled = 1

let g:ale_fixers = {
\   'javascript': ['eslint'],
\   'typescript': ['eslint'],
\   'typescriptreact': ['eslint']
\}

let g:ale_linters = {
\   'javascript': ['eslint'],
\   'typescript': ['eslint'],
\   'jsx': ['eslint'],
\   'html': [],
\}

let g:ale_linter_aliases = {'jsx': 'css'}

"use a slightly slimmer error pointer"
let g:ale_sign_error = '✖'
hi ALEErrorSign guifg=#DF8C8C
let g:ale_sign_warning = '⚠'
hi ALEWarningSign guifg=#F2C38F

highlight ALEErrorSign ctermfg=18 ctermbg=73 cterm=bold
highlight ALEWarningSign ctermfg=18 ctermbg=73 cterm=bold

" Ale error shortcuts"
nmap <silent> <Leader>k <Plug>(ale_previous_wrap)
nmap <silent> <Leader>j <Plug>(ale_next_wrap)
"nmap <Leader>d <Plug>(ale_fix)"

set statusline+=%#warningmsg#
set statusline+=%*

let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]

let g:lightline = {
  \     'active': {
  \         'left': [['mode', 'paste' ], ['readonly', 'filename', 'modified']],
  \         'right': [['lineinfo'], ['percent'], ['gitbranch', 'fileformat', 'fileencoding']]
  \     },
  \     'component_function': {
  \         'gitbranch': 'gitbranch#name'
  \     }
  \ }


" Fzf "
"-----"
  let g:fzf_layout = { 'down': '75%' }
    let g:fzf_colors =
    \ { 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Clear'],
      \ 'hl':      ['fg', 'String'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }

  command! -bang -nargs=? -complete=dir Files
	\ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

  nnoremap <silent> <leader><tab> :Files<CR>
  nnoremap <silent> <leader><leader> :Buffers<CR>
  nnoremap <silent> <leader>; :BLines<CR>
  nnoremap <silent> <leader>O :BTags<CR>
  nnoremap <silent> <leader>o :Tags<CR>
  nnoremap <silent> <leader>? :History<CR>

  nnoremap <silent> <leader>ft :Filetypes<CR>

  imap <c-x><c-p> <plug>(fzf-complete-path)
  imap <C-x><C-f> <plug>(fzf-complete-file-rg)
  imap <C-x><C-l> <plug>(fzf-complete-line)

  let g:fzf_layout = { 'down': '75%' }

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
        \   'rg --column --line-number --no-heading --iglob "!**/dist/**" --iglob "!**/language/**" --iglob "!**/lang/**" -g "!*.sql" -g "!*.min.js" --color=always '.shellescape(<q-args>), 1,
        \   fzf#vim#with_preview(),
        \   <bang>0)
  endif

  command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
  nnoremap <leader>/ :Rg<cr>

" Incsearch {{{"
"--------------"
let g:incsearch#auto_nohlsearch = 1	                                      " auto unhighlight after searching"
let g:incsearch#do_not_save_error_message_history = 1                     " do not store incsearch errors in history"
let g:incsearch#consistent_n_direction = 1                                " when searching backward, do not invert meaning of n and N"
map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)

" IndentLine {{"
let g:indentLine_char = ''
let g:indentLine_first_char = ''
let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_setColors = 0
" }}"

" Airline {{"
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = 'powerlineish'
set laststatus=2
set ttimeoutlen=50
set noshowmode
let g:airline#extensions#branch#enabled=1
" }}"

set guifont=<FONT_NAME>:h<FONT_SIZE>