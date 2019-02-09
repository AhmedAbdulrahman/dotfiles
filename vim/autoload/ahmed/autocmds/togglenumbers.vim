""
" Toggle relative numbers in Insert/Normal mode." 
""
function! ahmed#autocmds#togglenumbers#(command) abort
	if &l:number && empty(&buftype)
		execute a:command
	endif
endfunction
