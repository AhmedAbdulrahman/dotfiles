""
" Lookup definition under cursor."
""
" nnoremap <silent> gt :call ahmed#mappings#normal#lookup#()<CR>"
""
function! ahmed#mappings#normal#lookup#() abort
	let l:supportedfiletypes = [
		\ 'javascript',
		\ 'javascript.jsx',
		\ 'css'
	\ ]

	if exists('g:did_coc_loaded') && index(l:supportedfiletypes, &filetype, 0, v:true) >= 0
		call CocAction('doHover')
	elseif !empty(&keywordprg)
		normal! K
	endif
endfunction
