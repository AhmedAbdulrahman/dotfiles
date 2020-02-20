scriptencoding UTF-8

function! ahmed#statusline#linter() abort
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

function! ahmed#statusline#filetypesymbol() abort
	if !exists('*WebDevIconsGetFileTypeSymbol')
		return ''
	endif

	return WebDevIconsGetFileTypeSymbol()
endfunction

function! ahmed#statusline#hlsearch() abort
	if !&hlsearch
		return ''
	endif

	return '' . ' '
endfunction

function! ahmed#statusline#spell() abort
	if !&spell
		return ''
	endif

	return '' . ' '
endfunction

function! ahmed#statusline#git() abort
	let s:head = ''

	if exists('g:loaded_fugitive')
		let s:head = fugitive#head(7)
	endif

	return printf('%s ', s:head)
endfunction

function! ahmed#statusline#markdownpreview() abort
	if !exists('b:markdownpreview')
		return ''
	endif

	return '' . ' '
endfunction

function! ahmed#statusline#nerdtree() abort
	if !exists('b:NERDTree')
		return v:false
	endif

	return substitute(b:NERDTree.root.path.str() . '/', '\C^' . $HOME, '~', '')
endfunction

function! ahmed#statusline#fileSize() abort
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

function! ahmed#statusline#statusDiagnostic() abort
  if exists('*LanguageClient#statusLine')
    return LanguageClient#statusLine()
  endif

  let l:info = get(b:, 'coc_diagnostic_info', {})
  if empty(l:info)
    return ''
  endif

  let [l:DELETE, l:CHANGE, l:ADD, l:TEXT] = ahmed#statusline#getDiffColors()
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

function! ahmed#statusline#getMode() abort
  let l:currentMode = mode()
  if has_key(s:dictmode, l:currentMode)
    let l:modelist = get(s:dictmode, l:currentMode, [l:currentMode, '1'])
    let l:modecolor = l:modelist[1]
    let l:modename = l:modelist[0]
    return l:modename
  endif
  return ''
endfunction