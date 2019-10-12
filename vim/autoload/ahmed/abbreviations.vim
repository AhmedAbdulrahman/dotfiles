""
" Insert shebang string according to filetype."
""
" inoreabbrev <expr> _#! ahmed#abbreviations#shebang()"
""
" @return {shebang} Shebang string, with or without interpreter."
""
function! ahmed#abbreviations#shebang() abort
	if empty(&filetype)
		return '#!/usr/bin/env'
	endif

	let l:interpreters = {
		\ 'javascript': 'node',
		\ 'sh': 'bash'
	\ }

	return printf(
		\ '#!/usr/bin/env %s',
		\ get(l:interpreters, split(&filetype, '\v\c\.')[0], &filetype)
	\ )
endfunction
