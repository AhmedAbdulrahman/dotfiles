""
" Set current working directory to git root.
"
" autocmd VimEnter,BufEnter * call ahmed#autocmds#setroot#()
""
function! ahmed#autocmds#setroot#() abort
	let l:currentdir = escape(expand('%:p:h'), ' ')

	if !isdirectory(l:currentdir)
		return v:false
	endif

	let l:gitdir = finddir('.git', l:currentdir . ';')
	let l:rootdir = fnameescape(fnamemodify(l:gitdir, ':h'))

	if l:rootdir !=# $HOME
		execute 'cd' l:rootdir
	endif
endfunction
