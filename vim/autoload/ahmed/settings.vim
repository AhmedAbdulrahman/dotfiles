scriptencoding UTF-8

""
" Define the string to be displayed for a closed folds."
""
" set foldtext=ahmed#settings#foldtext()"
""
function! ahmed#settings#foldtext() abort
	"let l:lines = v:foldend - v:foldstart + 1"
	"let l:first = substitute(getline(v:foldstart), '\v\c *', '', '')"
	"return printf(' ▢ %s %s', l:lines, l:first)"

	let l:foldchar = matchstr(&fillchars, 'fold:\zs.')
	let l:lines=(v:foldend - v:foldstart + 1) . ' lines'
	let l:first=substitute(getline(v:foldstart), '\v *', '', '')
	let l:dashes=substitute(v:folddashes, '-', l:foldchar, 'g')
	return l:dashes . l:foldchar . l:foldchar . ' ' . l:lines . ': ' . l:first . ' '

endfunction

""
" Custom tabline modifier."
""
" set tabline=%!ahmed#settings#tabline()"
""
function ahmed#settings#tabline() abort
	let l:line = ''
	let l:current = tabpagenr()

	for l:i in range(1, tabpagenr('$'))
		if l:i == l:current
			let l:line .= '%#TabLineSel#'
		else
			let l:line .= '%#TabLine#'
		endif

		let l:label = fnamemodify(
			\ bufname(tabpagebuflist(l:i)[tabpagewinnr(l:i) - 1]),
			\ ':t'
		\ )

		let l:line .= '%' . i . 'T' " Starts mouse click target region."
		let l:line .= '  ' . l:label . '  '
	endfor

	let l:line .= '%#TabLineFill#'
	let l:line .= '%T' " Ends mouse click target region(s)."

	return l:line
endfunction

""
" Check Git Repo."
""

function! ahmed#settings#is_git() abort
  silent call system('git rev-parse')
  return v:shell_error == 0
endfunction

""
" Check Git Repo."
""
function! ahmed#settings#has_floating_window() abort
  " MenuPopupChanged was renamed to CompleteChanged -> https://github.com/neovim/neovim/pull/9819"
  " https://github.com/neoclide/coc.nvim/wiki/F.A.Q#how-to-make-preview-window-shown-aside-with-pum"
  return (exists('##MenuPopupChanged') || exists('##CompleteChanged')) && exists('*nvim_open_win') || (has('textprop') && has('patch-8.1.1522'))
endfunction

function! ahmed#settings#floating_fzf() abort
  let l:buf = nvim_create_buf(v:false, v:true)
  call setbufvar(buf, '&signcolumn', 'no')
  call setbufvar(l:buf, '&filetype', 'fzf')

  let height = &lines - 3
  let width = float2nr(&columns - (&columns * 2 / 60))
  let col = float2nr((&columns - width) / 2)

  let l:opts = {
        \ 'relative': 'editor',
        \ 'row': 1,
        \ 'col': col,
        \ 'width': width,
        \ 'height': height
        \ }

  call nvim_open_win(l:buf, v:true, l:opts)
endfunction

function! ahmed#settings#fzf_window() abort
  return ahmed#settings#has_floating_window() ? 'call ahmed#settings#floating_fzf()' : 'enew'
endfunction

function! ahmed#settings#attempt_select_last_file() abort
  let l:previous=expand('#:t')
  if l:previous !=# ''
    call search('\v<' . l:previous . '>')
  endif
endfunction

function! ahmed#settings#customize_diff()
  if &diff
  	" Disable loading syntax/*.vim files."
    syntax off
    set number
  else
  	" Enable loading syntax/*.vim files."
    syntax on
	" Show line numbers alongside relative numbers. "
    set number&
  endif
endfunction