""
" File explorer."
""

scriptencoding UTF-8

" Display hidden files."
let g:NERDTreeShowHidden = v:true

" Set buffer width, the default of 31 is just a little too narrow."
let g:NERDTreeWinSize = 40

" Keep the tree sync on file deletion or rename."
let g:NERDTreeAutoDeleteBuffer = v:true

" Custom file where bookmarks are saved."
let g:NERDTreeBookmarksFile = $HOME . '/.vim/cache/share/nerdtreebookmarks'

" Disable display of '?' text and 'Bookmarks' label."
let g:NERDTreeMinimalUI = v:true

let g:NERDTreeCreatePrefix='silent keepalt keepjumps'

" Single-click to toggle directory nodes, double-click to open non-directory nodes."
let g:NERDTreeMouseMode=2

let g:NERDTreeShowBookmarks=1

if has('autocmd')
  augroup AhmedNERDTree
    autocmd!
    autocmd User NERDTreeInit call ahmed#settings#attempt_select_last_file()
  augroup END
endif

" Hide some files and folders."
let g:NERDTreeIgnore = [
	\ '^\.DS_Store$[[file]]',
	\ '^\.git$[[dir]]',
	\ '^node_modules$[[dir]]',
	\ '\.swp$',
	\ '\.idea\/',
	\ '\.pyc$',
	\ '\.egg-info$',
	\ '__pycache__',
	\ '__pycache__'
\ ]

let g:NERDTreeSortOrder = ['\/$', '^\.']

" Use natural sort order."
let g:NERDTreeNaturalSort = v:true

" Use `trash-cli` when deleting files and folders."
let g:NERDTreeRemoveDirCmd = 'trash '
let g:NERDTreeRemoveFileCmd = 'trash '

" Change default statusline."
let g:NERDTreeStatusline = '%{ahmed#statusline#nerdtree()}'

" Make colors of directory icons with the same as directory names."
highlight! link NERDTreeFlags NERDTreeDir

" Define mappings."
let g:NERDTreeMapActivateNode = 'l'
let g:NERDTreeMapOpenRecursively = 'L'
let g:NERDTreeMapCloseDir = 'h'
let g:NERDTreeMapCloseChildren = 'H'
let g:NERDTreeMapPreview = 'i'
let g:NERDTreeMapOpenSplit = 'sp'
let g:NERDTreeMapOpenVSplit = 'vs'
let g:NERDTreeMapDeleteBookmark = 'bd'
let g:NERDTreeMapToggleBookmarks = 'bt'
let g:NERDTreeMapJumpParent = 'gp'
let g:NERDTreeMapJumpRoot = 'gr'
let g:NERDTreeMapJumpNextSibling = '<NOP>'
let g:NERDTreeMapJumpPrevSibling = '<NOP>'
let g:NERDTreeMapUpdirKeepOpen = '-'
let g:NERDTreeMapRefresh = 'r'
let g:NERDTreeMapRefreshRoot = 'R'
let g:NERDTreeMapMenu = 'm'
let g:NERDTreeMapChangeRoot = 'zr'
let g:NERDTreeMapToggleHidden = 'zh'
let g:NERDTreeMapToggleZoom = 'zv'
let g:NERDTreeMapHelp = '?'
let g:NERDTreeNodeDelimiter = "\u00a0"

" Disable unused mappings."
let g:NERDTreeMapCWD = ''
let g:NERDTreeMapChdir = ''
let g:NERDTreeMapJumpFirstChild = ''
let g:NERDTreeMapJumpLastChild = ''
let g:NERDTreeMapOpenExpl = ''
let g:NERDTreeMapOpenInTab = ''
let g:NERDTreeMapOpenInTabSilent = ''
let g:NERDTreeMapPreviewSplit = ''
let g:NERDTreeMapPreviewVSplit = ''
let g:NERDTreeMapQuit = ''
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeMapToggleFiles = ''
let g:NERDTreeMapToggleFilters = ''
let g:NERDTreeMapCustomOpen = '<CR>'

" Define mappings."
nnoremap <silent> <Leader>f :packadd nerdtree <Bar> NERDTreeToggle<RETURN>
nnoremap <silent> <Leader>F :packadd nerdtree <Bar> NERDTreeFind<Enter>

" Move up a directory using '-' like vim-vinegar (usually u does this)."
nmap <buffer> <expr> - g:NERDTreeMapUpdir

"map <C-Right> :tabn<cr>"
"map <C-Left> :tabp<cr>"

augroup nerdtreesettings
	autocmd!

	" Set common options."
	autocmd FileType nerdtree
		\ setlocal
			\ nolist
			\ nocursorline
			\ signcolumn=no
			\ conceallevel=3 concealcursor=nvic
			\ nofoldenable
			\ colorcolumn=

	" Hide current working directory line."
	autocmd FileType nerdtree syntax match NERDTreeHideCWD #^[</].*$# conceal

	" Hide slashes after each directory node."
	autocmd FileType nerdtree syntax match NERDTreeDirSlash #/$# conceal containedin=NERDTreeDir contained
augroup end
