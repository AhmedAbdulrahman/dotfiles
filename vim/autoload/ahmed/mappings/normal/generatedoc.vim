""
" Generate Documentation"
""
" nnoremap <silent> <leader>d :<C-u>call <SID>ahmed#mappings#normal#()<CR>"
""
function! ahmed#mappings#normal#generatedoc#() abort
  if &ft ==# 'javascript' || &ft ==# 'typescript'
    exe "JsDoc"
  elseif &ft ==# 'css'
    let lines = ['/*', ' * ', ' */']
    exe "normal! j?{$\<CR>:noh\<CR>"
    let lnum = getpos('.')[1]
    call append(lnum - 1, lines)
    exe "normal! kk$"
    startinsert!
  elseif &ft ==# 'html'
    let lnum = getpos('.')[1]
    let ind = matchstr(getline('.'), '\v\s*')
    call append(lnum - 1, ind . '<!--  -->')
    exe "normal! k^Ell"
    startinsert
  elseif &filetype ==# 'vim'
    let lnum = getpos('.')[1]
    let ind = matchstr(getline('.'), '\v\s*')
    call append(lnum - 1, ind . '" ')
    exe "normal! k$"
    startinsert!
  else
    let lnum = getpos('.')[1]
    let ind = matchstr(getline('.'), '\v\s*')
    call append(lnum - 1, ind. '# ')
    exe "normal! k$"
    startinsert!
  endif
endfunction
