""
" Set search register to current visual selection."
""
" xnoremap * :<C-u>call mappings#visual#setsearch#('/')<CR>/<C-r>=@/<CR><CR>"
" xnoremap # :<C-u>call mappings#visual#setsearch#('?')<CR>?<C-r>=@/<CR><CR>"
""
" @param {string} searchtype Direction for search command, either '/' or '?'."
""
function! mappings#visual#setsearch#(searchtype) abort
	let l:temp = @s
	normal! gv"sy
	let @/ = substitute(escape(@s, a:searchtype . '\'), '\n', '\\n', 'g')
	let @s = l:temp
endfunction
