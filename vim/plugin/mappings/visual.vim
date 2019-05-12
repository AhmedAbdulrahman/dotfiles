"Move faster UP|DOWN|RIGHT|LEFT"
xmap <C-j> 5j
xmap <C-k> 5k
xmap <C-h> 5h
xmap <C-l> 5l

"Move lines"
vnoremap <S-j> :m '<-2'<CR>gv=gv
vnoremap <S-k> :m '>+1'<CR>gv=gv

" Stay in visual mode when indenting."
xnoremap < <gv
xnoremap > >gv

" Always search with 'very magic' mode."
xnoremap / /\v
xnoremap ? ?\v

" Execute a macro over visual selection."
xnoremap <silent> @ :<C-u>execute printf("'<,'>normal! @%s", nr2char(getchar()))<Enter>

" Bubble lines in visual line mode, jump in character-wise visual mode."
xnoremap <expr> J mode() ==# 'V' ? ":move '>+1<Enter>gv=gv" : '5j'
xnoremap <expr> K mode() ==# 'V' ? ":move '<-2<Enter>gv=gv" : '5k'

"easy regex replace for current word"
xnoremap <leader>s :<c-u>%s/\%V

"save using <C-s> and back to normal mode"
vnoremap <C-s> <C-c>:write<Cr>

"Pressing * or # on Visual mode, and make current visual selection active search text."
xnoremap * :<C-u>call ahmed#autocmds#visual#setsearch#('/')<Enter>/<C-r>=@/<Enter><Enter>
xnoremap \# :<C-u>call ahmed#autocmds#visual#setsearch#('?')<Enter>?<C-r>=@/<Enter><Enter>