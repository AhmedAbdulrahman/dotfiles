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
  " Size and position"
  let width = float2nr(&columns * 0.9)
  let height = float2nr(&lines * 0.7)
  let row = float2nr((&lines - height) / 2)
  let col = float2nr((&columns - width) / 2)

  " Border"
  let top = '╭' . repeat('─', width - 2) . '╮'
  let mid = '│' . repeat(' ', width - 2) . '│'
  let bot = '╰' . repeat('─', width - 2) . '╯'
  let border = [top] + repeat([mid], height - 2) + [bot]

  " Draw frame"
  let s:frame = ahmed#settings#create_float('Comment', {'row': row, 'col': col, 'width': width, 'height': height})
  call nvim_buf_set_lines(s:frame, 0, -1, v:true, border)

  " Draw viewport"
  call ahmed#settings#create_float('Normal', {'row': row + 1, 'col': col + 2, 'width': width - 4, 'height': height - 2})
  autocmd BufWipeout <buffer> execute 'bwipeout' s:frame

endfunction

function! ahmed#settings#create_float(hl, opts) abort
  let buf = nvim_create_buf(v:false, v:true)
  let opts = extend({'relative': 'editor', 'style': 'minimal'}, a:opts)
  let win = nvim_open_win(buf, v:true, opts)
  call setwinvar(win, '&winhighlight', 'NormalFloat:'.a:hl)
  call setwinvar(win, '&colorcolumn', '')
  return buf
endfunction

function! ahmed#settings#fzf_window() abort
  return ahmed#settings#has_floating_window() ? 'call ahmed#settings#floating_fzf()' : 'silent 18split enew'
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