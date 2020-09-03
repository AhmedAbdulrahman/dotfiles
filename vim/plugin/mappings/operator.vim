" Make `cw` operation consistent by parting ways with `ce`."
onoremap w :<C-u>normal! vwh<CR>
onoremap W :<C-u>normal! vWh<CR>

" Send given motion to appropriate REPL operator."
nnoremap <silent> gx :let b:executeoperatorview = winsaveview() <Bar> set operatorfunc=ahmed#mappings#operator#execute#<CR>g@
xnoremap <silent> gx :<C-u>call ahmed#mappings#operator#execute#(visualmode())<CR>

" Comment and uncomment operator."
nnoremap <silent> gc :set operatorfunc=ahmed#mappings#operator#comment#<CR>g@
xnoremap <silent> gc :<C-u>call ahmed#mappings#operator#comment#(visualmode())<CR>

" Search and replace operator."
nnoremap <silent> go :set operatorfunc=ahmed#mappings#operator#search#<CR>g@
xnoremap <silent> go :<C-u>call ahmed#mappings#operator#search#(visualmode())<CR>
