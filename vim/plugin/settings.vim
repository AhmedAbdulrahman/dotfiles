" Encoding "
set encoding=UTF-8 " Default encoding. (vim-only) "
scriptencoding UTF-8 " Default encoding for current script. "
set fileformats=unix " Only use Unix end-of-line format. "

let $VIMHOME = expand($HOME.'/.vim')

" Change to English version"
let $LANG = 'en_US'
set langmenu=en_US

" Colors"
" Set Color/Theme based off time of day"
"set background=dark"  "Choose dark colors if available."

let g:nd_themes = [
  \ ['7:00',  'minimal-light', 'light' ],
  \ ['18:00', 'minimal-dark', 'dark' ],
  \ ]

set termguicolors " Enable True Color support. "
colorscheme minimal-dark " Color scheme."

" Behaviour "
set backspace=indent,eol,start " Allow backspacing over everything in insert mode. "
set belloff=all " Turn off the bell upon all events. "
set breakindent " Wrapped lines will be indented with same amount of space. "
set clipboard=unnamedplus " Sync unnamed register with system clipboard. "
set comments= " Clear default 'comments' value, let the filetype handle it."

set shell=zsh " Set ZSH as the prompt for Vim"
set confirm " Seek for confirmation for certain commands instead of giving errors. "
set display=lastline " As much as possible of the last line in a window will be displayed. "
set keywordprg= " Disable definition search by default. "
set modelines=1 " Maximum number of lines that is checked for set commands. "
set mouse=nv " Enable mouse support only for normal and visual modes. "
set nolangremap " Setting 'langmap' does not apply to characters resulting from a mapping. "
set noruler " Disable showing line numbers in command line. "
set noshowmatch " When a bracket is inserted, do not jump to the matching one. "
set nostartofline " Prevent the cursor from changing the current column when jumping. "
set nowrap " Prevent wrapping for long lines. "
set nrformats=bin,hex " Only accept binary and hexadecimal numbers. "
set pumheight=10 " Maximum number of items to show in the pop-up menu for completion. "
set regexpengine=1 " Use old regular expression engine. "
set report=0 " Threshold for reporting number of lines changed. "
set scrolloff=8 " Minimum number of screen lines to keep above and below the cursor. "
set sessionoptions=blank,buffers,curdir,folds,help,localoptions,resize,tabpages,winsize " Options for `mksession` command. "
set shellpipe=&> " Fix potentional screen flashing problems with not using `tee`. =atI "
set shortmess=filmnrwxoOstTIc " Use abbreviations and short messages in command menu line. "
set sidescroll=5 " Columns to scroll horizontally when cursor is moved off the screen. "
set sidescrolloff=5 " Minimum number of screen columns to keep to cursor right. "
set synmaxcol=200 " Don't highlight very long lines. "
syntax sync minlines=256   " Start highlighting from 256 lines backwards"
set textwidth=0 " Prevent auto wrapping when using affecting keys. "
set timeoutlen=500 " Mapping delays in milliseconds. "
set ttimeoutlen=10 " Key code delays in milliseconds. "
set ttyfast " More characters will be sent to the screen for redrawing in terminal. (vim-only) "
set updatetime=2000 " If that milliseconds nothing is typed CursorHold event will trigger. "
set visualbell " Use visual bell instead of beeping on errors. "

" Interface "
set cursorline " Highlight the line background of the cursor. "
set lazyredraw " Don't bother updating screen during macro playback"
set re=1
set laststatus=2 " Always show the status line. "

" Show trailing whitespace"
set list
set listchars=nbsp:░,tab:▷\ ,extends:»,precedes:«,trail:• " Strings to use when 'list' option set. "
set nojoinspaces " Disable inserting two spaces after `.`, `?`, `!` with join command. "
set concealcursor=n

" Characters to be used in various user-interface elements. "
if has('windows')
  set fillchars=diff:⣿                " BOX DRAWINGS "
  set fillchars+=vert:┃               " HEAVY VERTICAL "
  set fillchars+=fold:─
  if has('nvim')
    set fillchars=eob:\                 " Hide end of buffer ~ "
  endif
endif

if has('linebreak')
  let &showbreak='↳  '                " DOWNWARDS ARROW WITH TIP RIGHTWARDS"
endif

set relativenumber " Show relative line numbers alongside numbers. "

" Always draw the sign column even there is no sign in it. "
if has('nvim-0.4.2')
  set signcolumn=yes:2
else
  set signcolumn=yes
endif
set title " Show title as in 'titlestring' in title bar of window. "
set titlestring=%f " Format of the title used by 'title'. %F\ -\ vim"

" Tags "
set tags=./.git/tags;,./tags;,tags " Look for `tags` file in .git/ directory. "

" Make sure diffs are always opened in vertical splits, also match my git settings"
set diffopt+=vertical,algorithm:histogram,indent-heuristic,hiddenoff
call ahmed#settings#customize_diff()

" Formatting "
let &formatprg = 'par b1 e1 g1 q1 r3 w80 R1 T4 B=.,\?_A_a Q=_s\>' " External formatter program that will be used with `gq` operator. "
set formatoptions=croqnj " General text formatting options used by many mechanics. "
set linespace=41
" Completion "
set complete=.,w,b,k,t " Options for keyword completion. "
set completeopt=longest,menuone " Options for insert mode completion. "
set path=.,** " List of directories which will be searched when using related features. "
set pumheight=8 " Maximum height of the popup menu for insert mode completion. "

" Indentation "
set tabstop=4 " Spaces per tab. "
set shiftwidth=2 " Number of spaces to use for each step of auto indent operators. (when shifting) "
set softtabstop=-1 " Number of spaces that a <Tab> counts. "
set noexpandtab " Disable using spaces instead of tab characters. "
set nosmarttab " Tab key always inserts blanks according to 'tabstop'. "
set autoindent " Copy indent from current line when starting a new line. "
set shiftround " Round indent to multiple of 'shiftwidth'. Applies to > and < commands. "
set smartindent " Automatically inserts one extra level of indentation in some cases. "

" Folding "
if has('folding')
  set foldtext=ahmed#settings#foldtext()
  set foldmethod=indent               " not as cool as syntax, but faster"
  set foldlevelstart=99               " start unfolded"
endif

" Search "
set ignorecase " Make default search is not case sensitive. "
set incsearch " Instantly show results when you start searching. "
set nohlsearch " Disable highlight the matched search results by default. "
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
set history=10000 " Define maximum command history size. "
set noshowcmd " Disable displaying key presses at the right bottom. "
set noshowmode " Disable native mode indicator. showmode"
set wildcharm=<C-z> " The key to start wildcard expansion inside macro. "
set wildignorecase " Ignore case when completing in command menu. "
set wildmenu " Command-line completion operates in an enhanced mode. "
set wildmode=list:longest,full " zsh-like command autocompletion. "
set wildignore+=.hg,.git,.svn,.bzr " Version control "
set wildignore+=*.DS_Store         " Apple OS X "
set wildignore+=Thumbs.db          " Windows "
set wildignore+=*.pyc              " Python "
set wildignore+=*/tmp/*,/dist/*,/node_modules/*,*.so,*.swp,*.zip "to limit ctrlp search"
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
	set fillchars+=eob:\  " Hide end of buffer tilde symbols."
	set display+=msgsep " Only scroll lines on command line pager, not the entire screen."
	"set wildoptions+=pum" " Display the completion matches using the popupmenu."

  " For neovim terminal :term"
  " nnoremap <leader>t  :vsplit +terminal<cr>"
  tnoremap <expr> <esc> &filetype == 'fzf' ? "\<esc>" : "\<c-\>\<c-n>"
  tnoremap <M-h> <c-\><c-n><c-w>h
  tnoremap <M-j> <c-\><c-n><c-w>j
  tnoremap <M-k> <c-\><c-n><c-w>k
  tnoremap <M-l> <c-\><c-n><c-w>l
  augroup MyTerm
    autocmd!
    autocmd TermOpen * setl nonumber norelativenumber
    autocmd TermOpen term://* startinsert
    autocmd TermClose term://* stopinsert
  augroup END
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
  let g:terminal_color_0 = '#282828'
  let g:terminal_color_8 = '#928374'

  " neurtral_red + bright_red"
  let g:terminal_color_1 = '#cc241d'
  let g:terminal_color_9 = '#fb4934'

  " neutral_green + bright_green"
  let g:terminal_color_2 = '#98971a'
  let g:terminal_color_10 = '#b8bb26'

  " neutral_yellow + bright_yellow"
  let g:terminal_color_3 = '#d79921'
  let g:terminal_color_11 = '#fabd2f'

  " neutral_blue + bright_blue"
  let g:terminal_color_4 = '#458588'
  let g:terminal_color_12 = '#83a598'

  " neutral_purple + bright_purple"
  let g:terminal_color_5 = '#b16286'
  let g:terminal_color_13 = '#d3869b'

  " neutral_aqua + faded_aqua"
  let g:terminal_color_6 = '#689d6a'
  let g:terminal_color_14 = '#8ec07c'

  " light4 + light1"
  let g:terminal_color_7 = '#a89984'
  let g:terminal_color_15 = '#ebdbb2'
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
    let &backupdir=$XDG_DATA_HOME.'/nvim/backup' " keep backup files out of the way"
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