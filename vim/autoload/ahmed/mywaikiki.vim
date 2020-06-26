let g:waikiki_wiki_roots=['~/Documents/notes']
let g:waikiki_wiki_patterns = ['/wiki/', '\d+' ]
let g:waikiki_default_maps  = 1

function! mywaikiki#Load() abort
  if !get(g:, 'waikiki_loaded', 0)
    packadd vim-waikiki
    call waikiki#CheckBuffer(expand('%:p'))
  endif
endfun
