""
" Show COC documentation in preview window."
""
" nnoremap <silent> K :call <SID>ahmed#autocmds#showdocumentation#()<CR>"
""
function! ahmed#autocmds#showdocumentation#() abort
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction