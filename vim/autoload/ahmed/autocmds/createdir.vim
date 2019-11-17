""
" Create directory path if it's not exist."
" copied from https://github.com/duggiefresh/vim-easydir/blob/80f7fc2fd78d1c09cd6f8370012f20b58b5c6305/plugin/easydir.vim"
""
" autocmd BufWritePre,FileWritePre * call ahmed#autocmds#createdir#()"
function! ahmed#autocmds#createdir#() abort
  let s:directory = expand('<afile>:p:h')
  if s:directory !~# '^\(scp\|ftp\|dav\|fetch\|ftp\|http\|rcp\|rsync\|sftp\|file\):'
        \ && !isdirectory(s:directory)
    call mkdir(s:directory, 'p')
  endif
endfunction