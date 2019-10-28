if !has('nvim')
	finish
endif

" Disable built-in ftplugin."
let b:did_ftplugin = v:true

" Initialize the manual page."
if !exists('b:man_sect')
	call man#init_pager()
endif

" Set common buffer-only settings."
setlocal buftype=nofile bufhidden=hide noswapfile nomodified readonly nomodifiable
setlocal noexpandtab tabstop=8 softtabstop=8 shiftwidth=8
setlocal nonumber norelativenumber
setlocal foldmethod=indent nofoldenable

" Define mappings."
nnoremap <buffer><silent> gO :call ahmed#ftplugin#man#showtoc()<Enter>
nnoremap <buffer><silent> <C-]> :call ahmed#ftplugin#man#jumptag()<Enter>
nnoremap <buffer><silent> [g :call ahmed#ftplugin#man#poptag()<Enter>
