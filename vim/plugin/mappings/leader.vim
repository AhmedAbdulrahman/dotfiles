" Shortcuts for quiting."
nnoremap <silent> <Leader>q :quit<CR>
nnoremap <silent> <Leader>Q :quitall<CR>

" Insert an empty new line without entering insert mode."
nnoremap <Leader>o :put =repeat(nr2char(10), v:count1)<CR>
nnoremap <Leader>O :put! =repeat(nr2char(10), v:count1)<CR>
