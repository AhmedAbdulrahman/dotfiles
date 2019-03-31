"Move faster UP|DOWN|RIGHT|LEFT"
nnoremap <C-j> 5j
nnoremap <C-k> 5k
nnoremap <C-h> 5h
nnoremap <C-l> 5l

" Always search with 'very magic' mode."
nnoremap / /\v
nnoremap ? ?\v

"Move lines"
nnoremap <S-j> :m .+1<CR>==
nnoremap <S-k> :m .-2<CR>==

" Refactor word under cursor."
nnoremap c* *``cgn
nnoremap c# #``cgN

"copy line and leave a marker"
nnoremap yy yymy

" Alternative mappings for finding the next pair."
nnoremap <C-n> %
xnoremap <C-n> %
onoremap <C-n> %

" Construct grep search."
nnoremap gs :Search ''<Left>
nnoremap gS :Search! ''<Left>

" Correct bad indent while pasting."
nnoremap gp p=`]
nnoremap gP P=`]

" Correct previous and next spelling mistakes."
nnoremap [gs [s1z=
nnoremap ]gs ]s1z=

" Scroll viewport faster."
nnoremap <C-e> 2<C-e>
nnoremap <C-y> 2<C-y>

" Disable arrow keys"
nnoremap <Up>    <NOP>
nnoremap <Down>  <NOP>

" Split current window"
nnoremap <C-w>n :new file<CR>
nnoremap <C-w>s :split file<CR>
nnoremap <C-w>v :vsplit file<CR>
nnoremap <leader>- :split file<CR>
nnoremap <leader>\ :vsplit file<CR>

" Close Split"
nnoremap <C-w>c :close<CR>
nnoremap <C-w>q :q<CR>
nnoremap <C-w>o :only<CR>

"Resize window sizes."
nnoremap <S-Up> 2<C-w>+
nnoremap <S-Down> 2<C-w>-
nnoremap <S-Right> 2<C-w>>
nnoremap <S-Left> 2<C-w><

" Easy regex replace for current word"
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/

" select but dont jump"
nnoremap <Leader>8 *#
nnoremap <Leader>3 #*

" Store relative line number jumps in the jumplist if they exceed a threshold."
nnoremap <expr> j v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj'
nnoremap <expr> k v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk'

" Add [count] blank lines above or below the cursor."
nnoremap [<Space> :<C-u>put! =repeat(nr2char(10), v:count1) <Bar> ']+1<Enter>
nnoremap ]<Space> :<C-u>put =repeat(nr2char(10), v:count1) <Bar> '[-1<Enter>

"Buffer resizing"
nnoremap <Leader>H :vertical resize -4<cr>
nnoremap <Leader>J :resize +5<cr>
nnoremap <Leader>K :resize -5<cr>
nnoremap <Leader>L :vertical resize +5<cr>

"save using <C-s> and back to normal mode"
nnoremap <C-s> :write<Cr>

"Fast save/exiting"
nnoremap <leader>q :q!<CR>
nnoremap <leader>z ZZ
nnoremap <leader>w :w<CR>

"Close pane using <C-w>"
"noremap <silent> <C-w> :call <SID>ahmed#autocmds#closetab#()<Cr>

" Tab managment "
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
