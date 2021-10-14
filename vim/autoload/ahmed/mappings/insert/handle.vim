""
" Cycle through completion items when popup menu is visible."
""
" inoremap <expr> <Tab> ahmed#mappings#insert#handle#tab({ 'key': "\<Tab>" })"
" inoremap <expr> <S-Tab> ahmed#mappings#insert#handle#tab({ 'key': "\<S-Tab>" })"
""
" @param {dictionary} options Configuration dictionary."
" @param {string} options.key Key to use, whether "\<Tab>" or "\<S-Tab>"."
""
function! ahmed#mappings#insert#handle#tab(options) abort
	if !pumvisible()
		" If there is nothing before cursor, perform their original action."
		if !(col('.') - 1) || getline('.')[col('.') - 2] =~# '\s'
			return a:options.key
		endif
	endif

	if a:options.key ==# "\<Tab>"
		return "\<C-n>"
	elseif a:options.key ==# "\<S-Tab>"
		return "\<C-p>"
	endif
endfunction

""
" Accept current completion when popup menu is visible."
""
" inoremap <expr> <CR> ahmed#mappings#insert#handle#cr()"
""
function! ahmed#mappings#insert#handle#cr() abort
	" If it's selected."
	if complete_info()['selected'] != -1
		return "\<C-y>"
	else
		if exists('g:loaded_pear_tree')
			return pear_tree#insert_mode#PrepareExpansion()
		else
			return "\<C-g>u\<CR>"
		endif
	endif
endfunction
