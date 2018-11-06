"--------------"
"Source Plugins"
"--------------"
so ~/.vim/plugins.vim

"---------"
"VIM Theme"
"---------"
"Retro groove color scheme for Vim"
colorscheme gruvbox
hi CursorLineNr ctermfg=white

"--------"
"Settings"
"--------"
"1 General"
"---------"

"yep - the space bar is my leader keyset"
let mapleader = "\<Space>"           
set shell=zsh                         " Set bash as the prompt for Vim"
set backupskip=/tmp/*,/private/tmp/*  " Don’t create backups when editing files in certain directories"
set nowb
set noswapfile
set noerrorbells
set ttymouse=xterm2
set so=999
set wildignore+=*/tmp/*,/dist/*,/node_modules/*,*.so,*.swp,*.zip " to limit ctrlp search"
set nocompatible											"Make Vim more useful"
set wildmenu													"Enhance command-line completion"
set esckeys														"Allow cursor keys in insert mode"
set ttyfast														"Optimize for fast terminal connections"
set gdefault													"Add the g flag to search/replace by default"
set encoding=utf-8 nobomb							"Use UTF-8 without BOM"
set timeout timeoutlen=1500
set binary														"Don’t add empty newlines at the end of files"
set noeol
set cursorline												"Highlight current line"
set mouse=a														"Enable mouse in all modes"
set noerrorbells											"Disable error bells"
set ruler															"Show the cursor position"
set shortmess=atI											"Don’t show the intro message when starting Vim"
set showcmd														"Show the (partial) command as it’s being typed"
set scrolloff=3												"Start scrolling three lines before the horizontal window border"
set backspace=indent,eol,start				"Allow backspace in insert mode"
set exrc                              "Enable per-directory .vimrc files and disable unsafe commands in them"
set secure
set clipboard=unnamedplus

"Persistent Undo"
if has('persistent_undo')
  let target_path = expand('~/.vim/vim-persisted-undo/')

  if !isdirectory(target_path)
    call system('mkdir -p ' . target_path)
  endif

  let &undodir = target_path
  set undofile
endif

"use default clipboard on MAC"
if has('mac')
    set clipboard=unnamed
endif

"-------------"
"2 Appearance "
"-------------"

syntax enable 												"Enable syntax highlighting"
set number														"Enable line numbers"
set linespace=12     									"Sets line spacing but only in gui"
set title															"Show the filename in the window titlebar"
set titlestring=%F\ -\ vim
if exists("&relativenumber")          "Use relative line numbers"
	set relativenumber
	au BufReadPost * set relativenumber
endif
set statusline=%=\ %f\ %m             "Statusline"
set fillchars=vert:\ ,stl:\ ,stlnc:\ 
set laststatus=2
set noshowmode
set background=dark

set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_ "Show “invisible” characters"
set list

function! StripWhitespace()          "Strip trailing whitespace (,ss)"
	let save_cursor = getpos(".")
	let old_query = getreg('/')
	:%s/\s\+$//e
	call setpos('.', save_cursor)
	call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>
noremap <leader>W :w !sudo tee % > /dev/null<CR>  "Save a file as root (,W)"

" File behaviour "
set expandtab
set smarttab
set linebreak
set breakindent
set nostartofline											"Don’t reset cursor to start of line when moving around."
set tabstop=4 shiftwidth=4 expandtab	"Make tabs as wide as two spaces"
set modeline                          " Respect modeline in files"
set modelines=4

" Search "
set smartcase
set hlsearch       " Highlight search term "
set incsearch      " Incremental highlight term as pattern is typed"
set ignorecase		 " Ignore case of searches"

" Panes "
set splitbelow
set splitright

"--------"
"Bindings"
"--------"
map q <Nop>
"For search pane"
map ; :Files<CR>
"Set Interactive file tree view"
set backspace=indent,eol,start

map <F6> :setlocal spell!<CR>
map <F12> :Goyo<CR>
map <C-o> :NERDTreeToggle<CR>
" Launch FZF with CTRL P"
map <C-p> :FZF<CR>
nmap <Leader>n <Plug>NERDTreeTabsToggle<CR>

"save using <C-s> in every mode"
"when in operator-pending or insert, takes you to normal mode"
nnoremap <C-s> :write<Cr>
vnoremap <C-s> <C-c>:write<Cr>
inoremap <C-s> <Esc>:write<Cr>
onoremap <C-s> <Esc>:write<Cr>

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

"close pane using <C-w>"
fun! s:__bclose()
  if (len(getbufinfo({'buflisted': 1})) > 1)
    bdelete
  endif
endfun

" since I know it from Chrome / Atom (cmd+w) and do not use the <C-w> mappings anyway"
noremap <silent> <C-w> :call <SID>__bclose()<Cr>

"when pairing some braces or quotes, put cursor between them"
inoremap <>   <><Left>
inoremap ()   ()<Left>
inoremap {}   {}<Left>
inoremap []   []<Left>
inoremap ""   ""<Left>
inoremap ''   ''<Left>
inoremap ``   ``<Left>

"use tab and shift tab to indent and de-indent code"
nnoremap <Tab>   >>
nnoremap <S-Tab> <<
vnoremap <Tab>   >><Esc>gv
vnoremap <S-Tab> <<<Esc>gv

"Codi Config"
let g:codi#width         = 50.0
let s:codi_filetype_tabs = {}

function! s:FullscreenScratch()
  " store filetype and bufnr of current buffer for later reference"
  let current_buf_ft  = &ft
  let current_buf_num = bufnr('%')

  " check if a scratch buffer for this filetype already exists"
  let saved_scratch = get(s:codi_filetype_tabs, current_buf_ft, -1)

  " if a tabpage exists for current_buf_ft, go to it instead of creating a new scratch buffer"
  if saved_scratch != -1
    if index(map(gettabinfo(), 'v:val.tabnr'), saved_scratch) == -1
      unlet s:codi_filetype_tabs[current_buf_ft]
    else
      exe 'tabn' saved_scratch
      return
    endif
  endif

  "create a new empty tab, set scratch options and give it a name"
  tabe
  setlocal buftype=nofile noswapfile modifiable buflisted bufhidden=hide
  exe ':file scratch::' . current_buf_ft

  " set filetype to that of original source file e.g. ruby / python / w/e Codi supports"
  let &filetype = current_buf_ft

  " store the tabpagenr per filetype so we can return to it later when re-opening from the same filetype"
  let s:codi_filetype_tabs[&filetype] = tabpagenr()

  " create a buffer local mapping"
  nmap <silent><buffer> <Leader><Leader> :tabprevious<Cr>

  " everything is setup, filetype is set let Codi do the rest :)"
  Codi
endfunction

"create a mapping to call the fullscreen scratch wrapper"
nmap <silent> <Leader>c :call <SID>FullscreenScratch()<Cr>

" Highlighted yank"
let g:highlightedyank_highlight_duration = 300

"-----------------------"
" Plugins Configuration "
"-----------------------"
" Gruvbox"
let g:gruvbox_vert_split = 'bg1'
let g:gruvbox_sign_column = 'bg0'

" Enable JSDoc highlighting "
let g:javascript_plugin_jsdoc = 1
" Enable Flow syntax highlighting "
let g:javascript_plugin_flow = 1
" Allow JSX syntax in JS files "

"Emmet"
" lets emmet use jsx shortcuts"
let g:jsx_ext_required = 0
imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")
"Set Emmet to apply jsx settings to javascript.jsx filetype"
let g:user_emmet_settings = {
\  'javascript.jsx' : {
\      'extends' : 'jsx',
\      'quote_char': "'",
\  },
\}
autocmd FileType html,css,javascript,jsx EmmetInstall

"Prettier"
nmap <Leader>p <Plug>(Prettier)
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue PrettierAsync

"UiSnippets"
let g:UltiSnipsExpandTrigger="<C-l>"
let g:UltiSnipsJumpForwardTrigger="<C-b>"
let g:UltiSnipsJumpBackwardTrigger="<C-z>"

"Tagged Template"
"NOTE: Tag on the left, filetype on the right "
let g:taggedtemplate#tagSyntaxMap = {
  \ "html": "html",
  \ "md":   "markdown",
  \ "css":  "css" }
autocmd FileType javascript,javascript.jsx,typescript : call taggedtemplate#applySyntaxMap()

"---ALE---"
nmap <Leader>d <Plug>(ale_fix)
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

"ale error shortcuts"
nmap <silent> <Leader>k <Plug>(ale_previous_wrap)
nmap <silent> <Leader>j <Plug>(ale_next_wrap)

let g:lightline = {
  \     'active': {
  \         'left': [['mode', 'paste' ], ['readonly', 'filename', 'modified']],
  \         'right': [['lineinfo'], ['percent'], ['gitbranch', 'fileformat', 'fileencoding']]
  \     },
  \     'component_function': {
  \         'gitbranch': 'gitbranch#name'
  \     }
  \ }

let NERDTreeShowHidden=1