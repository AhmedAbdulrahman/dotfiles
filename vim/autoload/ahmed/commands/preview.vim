""
" Preview Markdown files."
" command! -nargs=* -complete=file Preview call ahmed#commands#preview(<f-args>)"
""

function! s:preview(file) abort
  " TODO: remove this hack once new version of Marked 2 is out:"
  " http://support.markedapp.com/discussions/questions/8670"
  silent! execute '!xattr -d com.apple.quarantine ' . shellescape(a:file)
  call s:Open('Marked 2.app', a:file)
endfunction

function! ahmed#commands#preview#(...) abort
  if a:0 == 0
    call s:preview(expand('%'))
  else
    for l:file in a:000
      call s:preview(l:file)
    endfor
  endif
endfunction
