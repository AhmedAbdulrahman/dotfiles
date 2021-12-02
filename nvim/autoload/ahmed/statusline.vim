scriptencoding UTF-8

" display lineNoIndicator (from drzel/vim-line-no-indicator) "
function! statusline#lineNoIndicator() abort
  let l:line_no_indicator_chars = ['⎺', '⎻', '─', '⎼', '⎽']
  " Zero index line number so 1/3 = 0, 2/3 = 0.5, and 3/3 = 1"
  let l:current_line = line('.')
  let l:total_lines = line('$')

  if l:current_line == 1
    let l:index = 1
  elseif l:current_line == l:total_lines
    let l:index = l:line_no_indicator_chars
  else
    let l:line_no_fraction = floor(l:current_line) / floor(l:total_lines)
    let l:index = float2nr(l:line_no_fraction * len(l:line_no_indicator_chars))
  endif

  return l:line_no_indicator_chars[l:index]
endfunction

function! statusline#rhs() abort
	if winwidth(0) > 80
		return printf('%%4* %s %02d/%02d:%02d %%*', statusline#lineNoIndicator(), line('.'),  line('$') , col('.'))
	else
		return statusline#lineNoIndicator()
	endif
endfunction

function! statusline#linter() abort
	if !exists('g:loaded_ale')
		return ''
	endif

	let l:counts = ale#statusline#Count(bufnr(''))

	let l:allerrors = l:counts.error + l:counts.style_error
	let l:allwarnings = l:counts.total - l:allerrors

  return printf('𥉉%d  %d ', l:allerrors, l:allwarnings)
endfunction

function! ahmed#statusline#fileprefix() abort
	let l:basename = expand('%:h')

	if l:basename ==# '' || l:basename ==# '.'
		return ''
	else
		return substitute(l:basename . '/', '\C^' . $HOME, '~', '')
	endif
endfunction

function! statusline#filetypesymbol() abort
	if !exists('*WebDevIconsGetFileTypeSymbol')
		return ''
	endif

	return WebDevIconsGetFileTypeSymbol()
endfunction

function! statusline#hlsearch() abort
	if !&hlsearch
		return ''
	endif

	return '' . ' '
endfunction

function! statusline#spell() abort
	if !&spell
		return ''
	endif

	return '%%#WarningMsg# ⍴ %%*'
endfunction

function! statusline#paste() abort
	if !&paste
		return ''
	endif

	return '%%#ErrorMsg# ✎ %%*'
endfunction

function! statusline#git() abort
	let s:head = ''

	if exists('g:loaded_fugitive')
		let s:head = fugitive#head(7)
	endif

	return printf('%s ', s:head)
endfunction

function! statusline#markdownpreview() abort
	if !exists('b:markdownpreview')
		return ''
	endif

	return '' . ' '
endfunction

function! statusline#nerdtree() abort
	if !exists('b:NERDTree')
		return v:false
	endif

	return substitute(b:NERDTree.root.path.str() . '/', '\C^' . $HOME, '~', '')
endfunction

function! statusline#fileSize() abort
  let l:size = getfsize(expand('%'))
  if l:size == 0 || l:size == -1 || l:size == -2
    return ''
  endif
  if l:size < 1024
    return l:size.' bytes'
  elseif l:size < 1024*1024
    return printf('%.1f', l:size/1024.0).'k'
  elseif l:size < 1024*1024*1024
    return printf('%.1f', l:size/1024.0/1024.0) . 'm'
  else
    return printf('%.1f', l:size/1024.0/1024.0/1024.0) . 'g'
  endif
endfunction

function! statusline#getDiffColors() abort
  return ['%#DiffDelete#', '%#DiffChange#', '%#DiffAdd#', '%#DiffText#']
endfunction

function! statusline#statusDiagnostic() abort
  if exists('*LanguageClient#statusLine')
    return LanguageClient#statusLine()
  endif

  let l:info = get(b:, 'coc_diagnostic_info', {})
  if empty(l:info)
    return ''
  endif

  let [l:DELETE, l:CHANGE, l:ADD, l:TEXT] = statusline#getDiffColors()
  let l:msgs = []
  if get(l:info, 'error', 0)
    call add(l:msgs, printf('%s%d %s %%*', l:DELETE,  l:info['error'] , '×'))
  endif
  if get(info, 'warning', 0)
    call add(l:msgs, printf('%s%d %s %%*', l:CHANGE,  l:info['warning'] , u'!'))
  endif

  return join(l:msgs, ' ')
endfunction

" Get current Mode "
" :h mode() to see all modes"
let s:dictmode= {
      \ 'no'     : ['N-Operator Pending' , '4'],
      \ 'v'      : ['V.'                 , '6'],
      \ 'V'      : ['V·Line'             , '6'],
      \ "\<C-V>" : ['V·Block'            , '6'],
      \ 's'      : ['S.'                 , '3'],
      \ 'S'      : ['S·Line'             , '3'],
      \ "\<C-S>" : ['S·Block.'           , '3'],
      \ 'i'      : ['I.'                 , '5'],
      \ 'ic'     : ['I·Compl'            , '5'],
      \ 'ix'     : ['I·X-Compl'          , '5'],
      \ 'R'      : ['R.'                 , '1'],
      \ 'Rc'     : ['Compl·Replace'      , '1'],
      \ 'Rx'     : ['V·Replace'          , '1'],
      \ 'Rv'     : ['X-Compl·Replace'    , '1'],
      \ 'c'      : ['Command'            , '2'],
      \ 'cv'     : ['Vim Ex'             , '7'],
      \ 'ce'     : ['Ex'                 , '7'],
      \ 'r'      : ['Propmt'             , '7'],
      \ 'rm'     : ['More'               , '7'],
      \ 'r?'     : ['Confirm'            , '7'],
      \ '!'      : ['Sh'                 , '2'],
      \ 't'      : ['T.'                 , '2']
      \ }

function! statusline#getMode() abort
  let l:currentMode = mode()
  if has_key(s:dictmode, l:currentMode)
    let l:modelist = get(s:dictmode, l:currentMode, [l:currentMode, '1'])
    let l:modecolor = l:modelist[1]
    let l:modename = l:modelist[0]
    return l:modename
  endif
  return ''
endfunction
