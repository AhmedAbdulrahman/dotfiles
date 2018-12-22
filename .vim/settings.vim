"----------------"
"Theme and Styling"
"----------------"

" for mirage version of theme"
let ayucolor="mirage" 
colorscheme ayu

set background=dark
set fillchars=vert:\ ,stl:\ ,stlnc:\ 
set confirm

hi VertSplit         ctermbg=NONE guibg=NONE
hi Normal            ctermbg=NONE guibg=NONE
hi LineNr            ctermbg=NONE guibg=NONE
hi CursorLineNr ctermfg=white

"Show changes since last save"
function! s:DiffSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setl bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
command! DS call s:DiffSaved()

"--------"
"1.Settings"
"--------"

"1.1 General"
"---------"

"yep - the space bar is my leader keyset"
let mapleader = "\<Space>"           
set shell=zsh                         " Set bash as the prompt for Vim"
set backupskip=/tmp/*,/private/tmp/*  " Don’t create backups when editing files in certain directories"
set nowb
set noswapfile

" Disable error bells."
set noerrorbells

" Use visual bell instead of audible bell"
set visualbell 

" Only insert single space after a '.', '?' and '!' with a join command."
set nojoinspaces 

set ttymouse=xterm2
set so=999

"to limit ctrlp search"
set wildignore+=*/tmp/*,/dist/*,/node_modules/*,*.so,*.swp,*.zip

"Allow cursor keys in insert mode"
set esckeys

"Optimize for fast terminal connections"
set ttyfast

"Add the g flag to search/replace by default"
set gdefault

set timeout timeoutlen=1500
"Don’t add empty newlines at the end of files"
set binary														

set noeol

let g:elite_mode=1	                                      " Enable Elite mode, No ARRRROWWS!!!!"
set cursorline                                            " Enable highlighting of the current line"

"Enable mouse in all modes"
set mouse=a

"Always show current position"
set ruler

"Don’t show the intro message when starting Vim"
set shortmess=atI

"Show the (partial) command as it’s being typed"
set showcmd

"Start scrolling three lines before the horizontal window border"
set scrolloff=3

" Start scrolling three columns before vertical border of window"
set sidescrolloff=3 

"Allow backspace in insert mode"
set backspace=indent,eol,start

"Enable per-directory .vimrc files and disable unsafe commands in them"
set exrc

set secure

"Reload files that have been changed outside vim"
set autoread 

"Persistent Undo"
if has('persistent_undo')
  let target_path = expand('~/.vim/vim-persisted-undo/')

  if !isdirectory(target_path)
    call system('mkdir -p ' . target_path)
  endif

  let &undodir = target_path
  set undofile
endif

set clipboard=unnamedplus
"use default clipboard on MAC"
if has('mac')
    set clipboard=unnamed
endif

" Markers are used to specify folds. "
set foldmethod=syntax                                     " fold based on indent"
set foldnestmax=10                                        " deepest fold is 10 levels"
set nofoldenable                                          " don't fold by default"
set foldlevel=1

" Allow folding single lines "
set foldminlines=0 

" Set max fold nesting level "
set foldnestmax=3 

" Format comments "
set formatoptions+=c 

" Format comments with gq "
set formatoptions+=q 

" Recognize numbered lists "
set formatoptions+=n 

" Use indent from 2nd line of a paragraph "
set formatoptions+=2 

" Don't break lines that are already long "
set formatoptions+=l 

" Break before 1-letter words "
set formatoptions+=1 

" By default add g flag to search/replace. Add g to toggle. "
set gdefault 

" When a buffer is brought to foreground, remember undo history and marks. "
set hidden 

" Remember copy history after quiting. "
"set viminfo='20,\"500'"

" Increase history from 20 default to 1000"
set history=1000 

"Set Interactive file tree view"
set backspace=indent,eol,start

" Character for CLI expansion (TAB-completion)."
set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.gif,*.psd,*.o,*.obj,*.min.js,*.sql
set wildignore+=*/bower_components/*,*/node_modules/*,node_modules/*
set wildignore+=*/wp-/plugins/*,*/w3tc-config/*,*/cache/*
set wildignore+=*/smarty/*,*/vendor/*,*/.git/*,*/.hg/*,*/.svn/*,*/.sass-cache/*,*/log/*,*/tmp/*,*/build/*,*/ckeditor/*,*/doc/*,*/source_maps/*,*/dist/*

" Hitting TAB in command mode will show possible completions above command line"
set wildmenu 

"1.2 Appearance "
"---------------"

"Enable syntax highlighting"
syntax enable

"Enable line numbers"
set number

"Sets line spacing but only in gui"
set linespace=12

"Show the filename in the window titlebar"
set title

set titlestring=%F\ -\ vim

"Always display the status line"
set laststatus=2

" Show the current mode"
set showmode

" Show tab bar if there is more than one"
set showtabline=1 

" Don't show the intro message when starting vim"
set shortmess=atI 

set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_ "Show “invisible” characters"
set list

" Add vertical spaces to keep right and left aligned "
set diffopt=filler

" Ignore whitespace changes (focus on code changes) "
set diffopt+=iwhite

" Change colour of tildes at the end of the buffer "
highlight EndOfBuffer ctermfg=black

" Border colour "
hi! VertSplit ctermfg=2 ctermbg=NONE term=NONE

"Strip trailing whitespace (,ss)"
function! StripWhitespace()
	let save_cursor = getpos(".")
	let old_query = getreg('/')
	:%s/\s\+$//e
	call setpos('.', save_cursor)
	call setreg('/', old_query)
endfunction

"1.3 File behaviour "
"-------------------"
set expandtab


set linebreak
set breakindent

" Don't reset cursor to start of line when moving around."
set nostartofline


" Set Proper Tabs"
set tabstop=4 shiftwidth=4 expandtab	                 "Don’t reset cursor to start of line when moving around."
set smarttab	                                         "At start of line, <Tab> inserts shiftwidth spaces, <Bs> deletes shiftwidth spaces"


" set nowrap Do not wrap lines"
set wrap

"Make tabs as wide as two spaces"
set modeline

" Respect modeline in files"
set modelines=4

" Show all changes"
set report=0 


" 1.4 Search "
"------------"
" Ignore 'ignorecase' if search patter contains uppercase characters"
set smartcase 

" do not highlight searches, incsearch plugin does this"
set hlsearch

" Incremental highlight term as pattern is typed "
set incsearch

" Ignore case of searches "
set ignorecase

" don't redraw while executing macros "
set nolazyredraw 

" Searches wrap around end of file"
set wrapscan

" match to be used with %"
set matchpairs+=<:> 

" Enable extended regexes "
set magic

" show matching braces "
set showmatch

" how many tenths of a second to blink "
set mat=2

" automatically set indent of new line "
set autoindent 
set smartindent

"-----------"
"   Panes	  "
"-----------"

" New window goes below"
set splitbelow 

" New windows goes right"
set splitright

"Allow splits to be reduced to a single line"
set winminheight=0

" No extra spaces between rows"
set linespace=0 

set scrolljump=5
set scrolloff=3

"-----------"
" Functions "
"-----------"

map <C-h> :call WinMove('h')<cr>
map <C-j> :call WinMove('j')<cr>
map <C-k> :call WinMove('k')<cr>
map <C-l> :call WinMove('l')<cr>

" Window movement shortcuts
" move to the window in the direction shown, or create a new window
function! WinMove(key)
    let t:curwin = winnr()
    exec "wincmd ".a:key
    if (t:curwin == winnr())
        if (match(a:key,'[jk]'))
            wincmd v
        else
            wincmd s
        endif
        exec "wincmd ".a:key
    endif
endfunction

"Codi Config"
let g:codi#width         = 50.0
let s:codi_filetype_tabs = {}

function! s:FullscreenScratch()
  " store filetype and buffer of current buffer for later reference"
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
  nmap <silent><buffer> <Leader>bl :tabprevious<Cr>

  " everything is setup, filetype is set let Codi do the rest :)"
  Codi
endfunction

"Codi: create a mapping to call the fullscreen scratch wrapper"
nmap <silent> <Leader>c :call <SID>FullscreenScratch()<Cr>
