""
" Generate Documentation"
""
" nnnoremap <leader>n :call <SID>NumberToggle()<CR>"
""
function! ahmed#mappings#normal#numbertoggle#() abort
	if(&number == 1) | set nu! | set rnu! | else | set rnu | set nu | endif
endfunctio
