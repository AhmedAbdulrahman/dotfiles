"Settings"
so ~/.vim/plugins.vim
"Retro groove color scheme for Vim"
colorscheme gruvbox
hi CursorLineNr ctermfg=white
" TODO: Pick a leader key "
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
"use default clipboard on MAC"
if has('mac')
    set clipboard=unnamed
endif

" Appearance "
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

"Bindings"
map q <Nop>
map ; :Files<CR>                        "For search pane"
set backspace=indent,eol,start          "Set Interactive file tree view"

map <F6> :setlocal spell!<CR>
map <F12> :Goyo<CR>
map <C-o> :NERDTreeToggle<CR>
map <C-p> :FZF<CR>                      " Launch FZF with CTRL P"

" Plugins Configuration "
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
\   'javascript': ['eslint']
\   'typescript': ['eslint']
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