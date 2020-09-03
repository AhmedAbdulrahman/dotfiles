""
" Select an entire buffer."
""
" onoremap <silent> ae :<C-u>call ahmed#mappings#motion#entire#()<CR>"
" xnoremap <silent> ae :<C-u>call ahmed#mappings#motion#entire#()<CR>"
""
function! ahmed#mappings#motion#entire#() abort
	normal! m'

	keepjumps normal! gg0VG
endfunction
