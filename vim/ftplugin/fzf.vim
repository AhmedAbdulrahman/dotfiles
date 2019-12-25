silent! match None

setlocal nonumber

nmap <buffer> <silent>  q :q<cr>

let b:undo_ftplugin = 'setlocal nonumber<'