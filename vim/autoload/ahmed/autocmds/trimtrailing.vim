""
" Trim trailing whitespace characters from end of each line."
""
" autocmd BufWritePre * call ahmed#autocmds#trimtrailing#()"
""
function! ahmed#autocmds#trimtrailing#() abort
	if &l:modifiable && !&l:binary
		let l:view = winsaveview()

		try
			keeppatterns silent! 1,$substitute/\s\+$//e
		finally
			call winrestview(l:view)
		endtry
	endif
endfunction
