""
" Toggle colors to optimize based on light or dark background"
""
"nnoremap <leader>c :call ahmed#mappings#normal#toggletheme#()<CR>"
""

function! ahmed#mappings#normal#toggletheme#()abort
  if &bg ==# "light"
    call Dark()
  else
    call Light()
  endif
endfunction

function! Light() abort
    echom "set bg=light"
    set bg=light
    colorscheme minimal-light
    set list
endfunction

function! Dark() abort
    echom "set bg=dark"
    set bg=dark
    colorscheme minimal-dark
    "darcula fix to hide the indents:"
    set nolist
endfunction