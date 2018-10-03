"Settings"
set nobackup
set nowb
set noswapfile
set noerrorbells
set ttymouse=xterm2
set so=999
set wildmenu
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
let mapleader=","											"Change mapleader"
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

map <Leader> <Plug>(easymotion-prefix)

" Plugins "
let g:gruvbox_vert_split = 'bg1'
let g:gruvbox_sign_column = 'bg0'
let g:javascript_plugin_flow = 1

so ~/.vim/plugins.vim

colorscheme gruvbox
hi CursorLineNr ctermfg=white

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