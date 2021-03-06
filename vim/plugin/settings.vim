" Encoding "
set encoding=UTF-8 " Default encoding. (vim-only) "
scriptencoding UTF-8 " Default encoding for current script. "
set fileformats=unix " Only use Unix end-of-line format. "
set fileencoding=utf-8 " Default file encoding set to utf-8"
set termencoding=utf-8 " Default terminal encoding set to utf-8"

" Change to English version"
let $LANG = 'en_US'
set langmenu=en_US

" Colors"
" Set Color/Theme based off time of day"
"set background=dark"  "Choose dark colors if available."

let g:nd_themes = [
  \ ['7:00',  'aylin', 'dark' ],
  \ ['18:00', 'aylin', 'dark' ],
  \ ]

set termguicolors " Enable True Color support. "
colorscheme aylin " Color scheme."

" Behaviour "
set backspace=indent,eol,start " Allow backspacing over everything in insert mode. "
set belloff=all " Turn off the bell upon all events. "
set breakindent " Wrapped lines will be indented with same amount of space. "
set clipboard=unnamedplus " Sync unnamed register with system clipboard. "
set comments= " Clear default 'comments' value, let the filetype handle it."
set confirm " Seek for confirmation for certain commands instead of giving errors. "
set display=lastline " As much as possible of the last line in a window will be displayed. "
" Don’t add empty newlines at the end of files"
set binary
set noeol
set keywordprg= " Disable definition search by default. "
set modelines=4 " Maximum number of lines that is checked for set commands. "
set mouse=nv " Enable mouse support only for normal and visual modes. "
set nolangremap " Setting 'langmap' does not apply to characters resulting from a mapping. "
set noruler " Disable showing line numbers in command line. "
set noshowmatch " When a bracket is inserted, do not jump to the matching one. "
set nostartofline " Prevent the cursor from changing the current column when jumping. "
set nowrap " Prevent wrapping for long lines. "
set nrformats=bin,hex " Only accept binary and hexadecimal numbers. "
set report=0 " Threshold for reporting number of lines changed. "
set scrolloff=8 " Minimum number of screen lines to keep above and below the cursor. "
set sessionoptions=blank,buffers,curdir,folds,help,localoptions,resize,tabpages,winsize " Options for `mksession` command. "
set shellpipe=&> " Fix potentional screen flashing problems with not using `tee`. =atI "
set shortmess=filmnrwxoOstTIc " Use abbreviations and short messages in command menu line. "
set sidescroll=5 " Columns to scroll horizontally when cursor is moved off the screen. "
set sidescrolloff=5 " Minimum number of screen columns to keep to cursor right. "
set textwidth=80 " Prevent auto wrapping when using affecting keys. "
set timeoutlen=500 " Mapping delays in milliseconds. "
set ttimeoutlen=10 " Key code delays in milliseconds. "
set ttyfast " More characters will be sent to the screen for redrawing in terminal. (vim-only) "
set updatetime=2000 " If that milliseconds nothing is typed CursorHold event will trigger. "
set visualbell " Use visual bell instead of beeping on errors. "

" Interface "
set cursorline " Highlight the line background of the cursor. "

" Show trailing whitespace"
set list
set listchars=tab:………,nbsp:░,extends:»,precedes:«,trail:• " Strings to use when 'list' option set. "
set nojoinspaces " Disable inserting two spaces after `.`, `?`, `!` with join command. "
set concealcursor=n

" Characters to be used in various user-interface elements. "
if has('windows')
  set fillchars=diff:⣿                " BOX DRAWINGS "
  set fillchars+=vert:┃               " HEAVY VERTICAL "
  set fillchars+=fold:─
  if has('nvim-0.3.1')
    set fillchars+=msgsep:‾
    set fillchars=eob:\                 " Hide end of buffer ~ "
  endif
  if has('nvim-0.5')
    set fillchars+=foldopen:▾,foldsep:│,foldclose:▸
  endif
endif

if has('linebreak')
  let &showbreak='↳  '                " DOWNWARDS ARROW WITH TIP RIGHTWARDS"
endif

" Make tilde command behave like an operator."
set tildeop

if has("mac")
  "set nocursorline"

  if exists("+relativenumber")
    set norelativenumber " Don't show relative line numbers alongside numbers. "
  endif

  " Folding "
  if has('folding')
	set foldtext=ahmed#settings#foldtext()
	set foldmethod=indent               " Use indent model for folding mechanism. Not as cool as syntax, but faster"
	set foldlevelstart=99               " Start editing with all folds open"
	set foldopen=hor,mark,percent,quickfix,tag,undo " Specifies for which type of commands folds will be opened."
  endif

endif

" Always draw the sign column even there is no sign in it. "
set signcolumn=yes

set updatetime=1000

if exists('+emoji')
  set noemoji
endif

set title " Show title as in 'titlestring' in title bar of window. "
set titlestring=%f " Format of the title used by 'title'. %F\ -\ vim"

" Tags "
set tags=./.git/tags;,./tags;,tags " Look for `tags` file in .git/ directory. "

" Make sure diffs are always opened in vertical splits, also match my git settings"
set diffopt+=vertical,algorithm:histogram,indent-heuristic,hiddenoff
call ahmed#settings#customize_diff()

" Formatting "
if !has('nvim') && (v:version > 703 || v:version == 703 && has('patch541'))
  set formatoptions+=j                " Remove comment leader when joining comment lines"
endif
set formatoptions+=n                  " Smart auto-indenting inside numbered lists"
set formatoptions+=r1
set linespace=41

" Completion "
set wildcharm=<C-z> " The key to start wildcard expansion inside macro. "
set wildignorecase " Ignore case when completing in command menu. "
set wildmenu " Command-line completion operates in an enhanced mode. "
set wildmode=longest:full,list,full " zsh-like command autocompletion. "
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem,*.pyc,.hg,.bzr " Version control "
set wildignore+=*.swp,*~,*/.DS_Store         " Apple OS X "
set wildignore+=Thumbs.db                    " Windows "
set wildignore+=*.pyc                        " Python "
set wildignore+=*/tmp/*,/dist/*,/node_modules/*,*.so,*.swp,*.zip "to limit ctrlp search"
set path=.,** " List of directories which will be searched when using related features. "
set complete+=kspell " Options for keyword completion. "

" Disable unsafe commands."
" Only run autocommands owned by me"
" http://andrew.stwrt.ca/posts/project-specific-vimrc/"
set secure

if has('virtualedit')
  set virtualedit=block               " Allow cursor to move where there is no text in visual block mode"
endif

set whichwrap=b,h,l,s,<,>,[,],~       " Allow <BS>/h/l/<Left>/<Right>/<Space>, ~ to cross line boundaries"
set completeopt+=menuone
set completeopt+=noinsert
set completeopt-=preview

if has('nvim-0.4')
  set wildoptions=pum
  set pumblend=10 " Enables pseudo-transparency for the Popup-menu"
  set pumheight=50 " Maximum number of items to show in the popup menu for Insert mode completion."
endif

if has('syntax')
  set spellcapcheck=                  " Don't check for capital letters at start of sentence"
  " https://robots.thoughtbot.com/opt-in-project-specific-vim-spell-checking-and-word-completion"
  set spelllang=en,sv,ar
  set spellsuggest=30
  let &spellfile=$VIMHOME.'/spell/spell.add'
endif

" Indentation "
set tabstop=4 " Spaces per tab. "
set shiftwidth=2 " Number of spaces to use for each step of auto indent operators. (when shifting) "
set softtabstop=-1 " Number of spaces that a <Tab> counts. "
set noexpandtab " Disable using spaces instead of tab characters. "
set nosmarttab " Tab key always inserts blanks according to 'tabstop'. "
set autoindent " Copy indent from current line when starting a new line. "
set shiftround " Round indent to multiple of 'shiftwidth'. Applies to > and < commands. "
set smartindent " Automatically inserts one extra level of indentation in some cases. "

" Search "
set ignorecase " Ignore case when searching except when using a capital letter"
set incsearch " Highlight found first search term as you type the search. "
set nohlsearch " Highlight searched terms. "
set smartcase " If a uppercase character is entered, the search will be case sensitive. "
if executable('rg')
  set grepprg=rg\ --vimgrep\ --no-messages\ --no-ignore\ --hidden\ --follow\ --smart-case\ --glob "!.git/"\ --glob "!node_modules/"\ --regexp\ " Program to use for the :grep command. "
  set grepformat=%f:%l:%c:%m,%f:%l:%m " Format to recognize for the :grep command output. "
endif

" Buffers, Windows, Tabs "
set autoread " Read the file again if have been changed outside of Vim. "
set hidden " Allows you to hide buffers with unsaved changes without being prompted. "
set splitbelow " Splitting a window will put the new window below of the current one. "
set splitright " Splitting a window will put the new window right of the current one. "
set switchbuf=useopen " Jump to the first open window that contains the specified buffer. "
set tabline=%!ahmed#settings#tabline() " Custom tabline modifier function. "
set tabpagemax=50 " Maximum number of tab pages to be opened by the `tab all` command. "

" Command Mode "
set cmdwinheight=5 " Height of the command window size for commands like `q:` and `q/`. "
set history=1000 " Define maximum command history size. "
set undolevels=1000
set noshowcmd " Disable displaying key presses at the right bottom. "
set noshowmode " Disable native mode indicator. showmode"

"set esckeys" "Allow cursor keys in insert mode"
" Vim "
if !has('nvim') && !has('gui')
	" Configures the cursor style for each mode. "
	let &t_SI = "\<Esc>[6 q" " [S]tart [I]nsert "
	let &t_SR = "\<Esc>[4 q" " [S]tart [R]eplace "
	let &t_EI = "\<Esc>[2 q" " [E]nd [I]nsert "

	" Transform cursor to its box form when starting. "
	silent call feedkeys("i\<Esc>")
endif

" Neovim "
if has('nvim')
	set inccommand=nosplit " Show live substitution results as you type."
	set display+=msgsep " Only scroll lines on command line pager, not the entire screen."
endif

if has('gui_running')
    " toolbar and scrollbars"
    set guioptions-=T       " Removes top toolbar"
    set guioptions-=L       " Removes left hand scroll bar"
    set guioptions-=r       " Removes right hand scroll bar"
    set guioptions-=b       " bottom scroll bar"
    set guioptions-=h       " only calculate bottom scroll size of current line"
    set shortmess+=A        " ignore annoying swapfile messages"
    set shortmess+=I        " no splash screen"
    set shortmess+=O        " file-read message overwrites previous"
    set shortmess+=T        " truncate non-file messages in middle"
    set shortmess+=W        " don't echo "[w]"/"[written]" when writing"
    set shortmess+=a        " use abbreviations in messages eg. `[RO]` instead of `[readonly]`"
    set shortmess+=o        " overwrite file-written messages"
    set shortmess+=t        " truncate file messages at start"
endif

" Configures the cursor style for each mode "
if exists('&guioptions')
  " cursor behavior:"
  "   - no blinking in normal/visual mode"
  "   - blinking in insert-mode"
  set guicursor+=n-v-c:blinkon0,i-ci:ver25-Cursor/lCursor-blinkwait30-blinkoff100-blinkon100
endif

if has('nvim')
  " dark0 + gray"
  let g:terminal_color_0 = '#555863'
  let g:terminal_color_8 = '#81848b'

  " neurtral_red + bright_red"
  let g:terminal_color_1 = '#d0476a'
  let g:terminal_color_9 = '#f55780'

  " neutral_green + bright_green"
  let g:terminal_color_2 = '#52b994'
  let g:terminal_color_10 = '#61dbaf'

  " neutral_yellow + bright_yellow"
  let g:terminal_color_3 = '#d6b168'
  let g:terminal_color_11 = '#ffcc66'

  " neutral_blue + bright_blue"
  let g:terminal_color_4 = '#6788cb'
  let g:terminal_color_12 = '#82abff'

  " neutral_purple + bright_purple"
  let g:terminal_color_5 = '#cf869e'
  let g:terminal_color_13 = '#ffa7c4'

  " neutral_aqua + faded_aqua"
  let g:terminal_color_6 = '#68b6a7'
  let g:terminal_color_14 = '#7edbca'

  " light4 + light1"
  let g:terminal_color_7 = '#c5c8c6'
  let g:terminal_color_15 = '#dddddd'
endif

if has('mksession')
  if !has('nvim')
    let &viewdir=$XDG_DATA_HOME.'/nvim/view' " override ~/.vim/view default"
  endif
  set viewoptions=cursor,folds        " save/restore just these (with `:{mk,load}view`)"
endif

" Backup "
if exists('$SUDO_USER')
  set nobackup                        " Don't create root-owned files "
  set nowritebackup                   " Don't create root-owned files "
else
  if !has('nvim')
    let &backupdir=g:VIMDATA.'/backup' " keep backup files out of the way"
  endif
  set backupdir+=.
endif

" Swap "
if exists('$SUDO_USER')
  set noswapfile                      " Don't create root-owned files "
else
  if !has('nvim')
    let &directory=$XDG_DATA_HOME.'/nvim/swap//' " keep swap files out of the way"
  endif
  set directory+=.
endif

set updatecount=100 " Update swapfiles every 80 typed chars "

if has('persistent_undo')
  if exists('$SUDO_USER')
    set noundofile                    " Don't create root-owned files "
  else
    if !has('nvim')
      let &undodir=$XDG_DATA_HOME.'/nvim/undo/' " keep undo files out of the way"
    endif
    set undodir+=.
    set undofile                      " Actually use undo files when exiting a buffer "
  endif
endif

if exists('$SUDO_USER')               " Don't create root-owned files "
  if has('nvim')
    set shada=
  else
    set viminfo=
  endif
else
  if has('nvim')
    " default in nvim: !,'100,<50,s10,h "
    set shada=!,'100,<500,:10000,/10000,s10,h
    augroup MyNeovimShada
      autocmd!
      autocmd CursorHold,FocusGained,FocusLost * rshada|wshada
    augroup END
  else
    execute "set viminfo=!,'100,<500,:10000,/10000,s10,h,n".$XDG_DATA_HOME.'/nvim/viminfo'
  endif
endif
