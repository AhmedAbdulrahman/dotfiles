""
" Show COC documentation in preview window."
""
" nnoremap <silent> K :call <SID>ahmed#autocmds#showdocumentation#()<CR>"
""
function! ahmed#autocmds#showdocumentation#() abort
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction