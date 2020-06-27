" General {{{ "
    " Source VIMRC "
    nnoremap rc :source $MYVIMRC<CR>

    " Toggle colors to optimize based on light or dark background "
    nnoremap <leader>c :call ahmed#mappings#normal#toggletheme#()<CR>

    " Override Ex mode with run @q."
    nnoremap Q @q

    " Always send contents of a `x` command to the black hole register."
    nnoremap x "_x"

    " Correct bad indent while pasting."
    nnoremap gp p=`]
    nnoremap gP P=`]

    " Correct previous and next spelling mistakes."
    nnoremap [gs [s1z=
    nnoremap ]gs ]s1z=

    " Add [count] blank lines above or below the cursor."
    nnoremap [<Space> :<C-u>put! =repeat(nr2char(10), v:count1) <Bar> ']+1<Enter>
    nnoremap ]<Space> :<C-u>put =repeat(nr2char(10), v:count1) <Bar> '[-1<Enter>

    "Close pane using <C-w> - Disabled due to using buftabline!"
    "noremap <silent> <C-w> :call <SID>ahmed#autocmds#closetab#()<Cr>"

    " Lookup definition under cursor."
    nnoremap <silent> gt :call ahmed#mappings#normal#lookup#()<Enter>

    " Open URL under cursor in browser or open path in GUI explorer."
    "nnoremap <silent> gb :execute printf('silent !xdg-open "%s" 2>/dev/null', fnameescape(expand('<cfile>')))<Enter>"

    " Scroll viewport faster."
    nnoremap <C-e> 2<C-e>
    nnoremap <C-y> 2<C-y>

    " Store relative line number jumps in the jumplist if they exceed a threshold."
    nnoremap <expr> j v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj'
    nnoremap <expr> k v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk'

    " Toggle common options. "
    nnoremap <silent> cos :set spell!<Enter>
    nnoremap <silent> cow :set wrap!<Enter>
    nnoremap <silent> coh :set hlsearch!<Enter>
    nnoremap <silent> coH :let @/ = ''<Enter>
    nnoremap <silent> col :set list!<Enter>
    nnoremap <silent> cop :set paste!<Enter>
" }}} General "

" Save & Quit {{{ "
    "save using <C-s> and back to normal mode"
    nnoremap <C-s> :write<Cr>

    "Fast save/exiting"
    nnoremap <leader>q :q!<CR>
    nnoremap <leader>z ZZ
    nnoremap <leader>w :w<CR>
" }}} Save & Quit "

" Faster Movement {{{ "
    "Jump 5 lines/character UP|DOWN|RIGHT|LEFT"
    nnoremap <C-j> 5j
    nnoremap <C-k> 5k
    "nnoremap <C-h> 5h"
    "nnoremap <C-l> 5l"

    " Alternative beginning and end of line mappings."
    nnoremap H ^
    xnoremap H ^
    onoremap H ^
    nnoremap L $
    xnoremap L g_
    onoremap L $
" }}} Faster Movement "

" Search {{{ "
    " Always search with 'very magic' mode."
    nnoremap / /\v
    nnoremap ? ?\v

    " Construct grep search."
    "nnoremap gs :Search ''<Left>"
    "nnoremap gS :Search! ''<Left>"

    " Easy regex replace for current word"
    nnoremap <Leader>s :%s/\<<C-r><C-w>\>/

    " select but dont jump"
    nnoremap <Leader>8 *#
    nnoremap <Leader>3 #*

" }}} Search "

" Change & Replace & Remove {{{ "
    " Refactor word under cursor."
    nnoremap c* /\<<C-R>=expand('<cword>')<Enter>\>\C<Enter>``cgn
    nnoremap c# ?\<<C-R>=expand('<cword>')<Enter>\>\C<Enter>``cgN

    " Delete word under cursor."
    nnoremap d* /\<<C-r>=expand('<cword>')<Enter>\>\C<Enter>``dgn
    nnoremap d# ?\<<C-r>=expand('<cword>')<Enter>\>\C<Enter>``dgN
" }}} Change & Replace & Remove "

" Copy {{{ "
    " Make `Y` acting like `C`, `D`."
    nnoremap Y y$

    "copy line and leave a marker"
    nnoremap yy yymy

    " [y]ank [p]ath [f]ull."
    nnoremap <silent> ypf :let @+ = expand('%:p')<Enter>
    " [y]ank [p]ath [r]elative."
    nnoremap <silent> ypr :let @+ = expand('%')<Enter>
    " [y]ank [p]ath [n]ame of the file."
    nnoremap <silent> ypn :let @+ = expand('%:t')<Enter>

    " Select last changed or yanked area."
    nnoremap <expr> gV '`[' . strpart(getregtype(), 0, 1) . '`]'

" }}} Copy "

" Buffers & Windows {{{ "
    " Buffers and windows are independent. That means you can navigate through one buffer in one window while the other buffer in the other window stays where you left."

    " Horizontal Split with New Buffer "
    nnoremap <silent> <leader>bh :new<CR>

    " Vertical Split with New Buffer "
    nnoremap <silent> <leader>bv :vnew<CR>

    " Switch between Current and Last buffer"
    nnoremap <silent> <leader>bb <C-^>

    " Go to Next/Previous Buffer"
    nnoremap <silent> <C-h> :bn<CR>
    nnoremap <silent> <C-l> :bp<CR>

    " Close buffer"
    nnoremap <silent> <C-w> :bd<CR>

    " List Buffers "
    nnoremap <silent> <leader>bl :ls<CR>

    " List and Select Buffer "
    nnoremap <silent> <leader>bg :ls<CR>:buffer<Space>

    " Window Split navigations "
    nnoremap <S-J> <C-W><C-J>
    nnoremap <S-K> <C-W><C-K>
    nnoremap <S-L> <C-W><C-L>
    nnoremap <S-H> <C-W><C-H>

    " Close Split"
    nnoremap <C-w>c :close<CR>
    nnoremap <C-w>q :q<CR>
    nnoremap <C-w>o :only<CR>

    " Improved split keyboard navigation "
    nnoremap <leader>h <C-w>h
    nnoremap <leader>j <C-w>j
    nnoremap <leader>k <C-w>k
    nnoremap <leader>l <C-w>l

    " Toggle terminal buffer."
    " - Toggle terminal buffer in Terminal Mode"
    tnoremap <silent> <C-z> <C-\><C-n>:call ahmed#mappings#normal#terminal#()<Enter>
    "- Toggle terminal buffer in Normal Mode"
    nnoremap <silsent> <C-z> :call ahmed#mappings#normal#terminal#()<Enter>
    " - Open SHELL in Vertical Split"
    nnoremap <silent> <leader>tv :vnew<CR>:call ahmed#mappings#normal#terminal#()<Enter>
    "- Open SHELL in Horizontal Split"
    nnoremap <silent> <leader>th :new<CR>:call ahmed#mappings#normal#terminal#()<Enter>
    "- Quite SHELL"
    tnoremap <C-x> <C-\><C-n><C-w>q

    " Toggle zoom current buffer in the new tab."
    nnoremap <silent> <leader>gz :call ahmed#mappings#normal#zoom#()<Enter>

" }}} Buffers & Windows "

" Quickfix {{{ "
    nnoremap <silent> =oq :copen<Enter>
    nnoremap <silent> =oQ :chistory<Enter>
    nnoremap <silent> [q :cprevious<Enter>
    nnoremap <silent> ]q :cnext<Enter>
    nnoremap <silent> [Q :cpfile<Enter>
    nnoremap <silent> ]Q :cnfile<Enter>
    nnoremap <silent> <Up> :cprevious<Enter>
    nnoremap <silent> <Down> :cnext<Enter>
    nnoremap <silent> <Left> :cpfile<Enter>
    nnoremap <silent> <Right> :cnfile<Enter>
    nnoremap <silent> [<C-q> :cfirst<Enter>
    nnoremap <silent> ]<C-q> :clast<Enter>
" }}} Quickfix "

" Location {{{ "
    nnoremap <silent> =ol :lopen<Enter>
    nnoremap <silent> =oL :lhistory<Enter>
    nnoremap <silent> [l :lprevious<Enter>
    nnoremap <silent> ]l :lnext<Enter>
    nnoremap <silent> [L :lpfile<Enter>
    nnoremap <silent> ]L :lnfile<Enter>
    nnoremap <silent> [<C-l> :lfirst<Enter>
    nnoremap <silent> ]<C-l> :llast<Enter>
" }}} Location "

" Argument {{{ "
    nnoremap <silent> =oa :args<Enter>
    nnoremap <silent> [a :previous<Enter>
    nnoremap <silent> ]a :next<Enter>
    nnoremap <silent> [A :first<Enter>
    nnoremap <silent> ]A :last<Enter>
" }}} Argument "

" Tabs {{{ "
    nnoremap <silent> [t :tabprevious<Enter>
    nnoremap <silent> ]t :tabnext<Enter>
    nnoremap <silent> <leader>te <esc>:tabedit <tab>
    nnoremap <silent> <leader>tn <esc>:tabnew<cr>:silent! Startify<cr> "Normal mode"
    inoremap <silent> <C-t> <esc>:tabnew<cr>:silent! Startify<cr> "Insert mode"
    nnoremap <silent> <leader>to <esc>:tabonly<cr>
    nnoremap <silent> <leader>tc <esc>:tabclose<cr> "Normal mode"
    "inoremap <silent> <C-w> <esc>:tabclose<cr>" "Insert mode"
    nnoremap <silent> <leader>tm <esc>:tabmove<Space>
    nnoremap <silent> <leader>tb <esc>:tab ball<cr>
    nnoremap <silent> <leader>tl <esc>:tabs<cr>
" }}} Tabs "

" Tags {{{ "
    nnoremap <C-]> g<C-]>zt
    nnoremap <silent> =og :tags<Enter>
    nnoremap <silent> [g :pop<Enter>
    nnoremap <silent> ]g :tag<Enter>
" }}} Tags "
