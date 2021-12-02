" Save the current buffer while keeping marks."
" autocmd InsertLeave,TextChanged * call ahmed#autocmds#savebuffer#() "

function! ahmed#autocmds#savebuffer#() abort
  if empty(&buftype)
    \ && !empty(bufname(''))
    \ && &filetype !=# 'gitcommit'
    let l:save = {
      \ 'marks': {
        \ "'[": getpos("'["),
        \ "']": getpos("']")
      \ }
    \ }

    silent! update

    for [l:key, l:value] in items(l:save.marks)
      call setpos(l:key, l:value)
    endfor
  endif
endfunction
