scriptencoding UTF-8

let g:currentmode={
      \ 'n'  : 'N ',
      \ 'no' : 'N·Operator Pending ',
      \ 'v'  : 'V ',
      \ 'V'  : 'V·Line ',
      \ 'x22' : 'V·Block ',
      \ 's'  : 'Select ',
      \ 'S'  : 'S·Line ',
      \ 'x19' : 'S·Block ',
      \ 'i'  : 'I ',
      \ 'R'  : 'R ',
      \ 'Rv' : 'V·Replace ',
      \ 'c'  : 'Command ',
      \ 'cv' : 'Vim Ex ',
      \ 'ce' : 'Ex ',
      \ 'r'  : 'Prompt ',
      \ 'rm' : 'More ',
      \ 'r?' : 'Confirm ',
      \ '!'  : 'Shell ',
      \ 't'  : 'Terminal '
      \}

" [1] Linter status, error and warnings count with Unicode symbols."
set statusline+=%{repeat('\ ',4)} " Generate space characters given number of times."
set statusline+=%{ahmed#statusline#linter()}
set statusline+=%{repeat('\ ',4)}

" Truncate lines to left if they are too long."
set statusline+=%<

" [2] Relative path to file's directory with trailing '/'."
set statusline+=%{ahmed#statusline#fileprefix()}

" [3] File name for current buffer."
set statusline+=%t

" [4] FileType Unicode symbol."
set statusline+=%{repeat('\ ',1)}
set statusline+=%{ahmed#statusline#filetypesymbol()}

" Align all items to right from this point on."
set statusline+=%=

" [5] Show an icon for common options if they are enabled."
set statusline+=%{ahmed#statusline#markdownpreview()}
set statusline+=%{ahmed#statusline#hlsearch()}
set statusline+=%{ahmed#statusline#spell()}
set statusline+=%{repeat('\ ',2)}

" [6] Line numbers and column numbers in <Line>:<Column> format."
set statusline+=%02l/%02L:%02c
set statusline+=%{repeat('\ ',2)}

" [7] Git HEAD status."
set statusline+=%{ahmed#statusline#git()}
set statusline+=%{repeat('\ ',2)}

" [8] Vim Mode."
set statusline+=%0*\ %{toupper(g:currentmode[mode()])}   " Current mode
set statusline+=%{repeat('\ ',2)}