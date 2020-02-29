""
" Select an entire buffer.
"
" onoremap <silent> ae :<C-u>call ahmed#mappings#motion#entire#()<Enter>
" xnoremap <silent> ae :<C-u>call ahmed#mappings#motion#entire#()<Enter>
""
function! ahmed#mappings#motion#entire#() abort
	normal! m'

	keepjumps normal! gg0VG
endfunction