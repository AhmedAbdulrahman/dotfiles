" General {{{ "
    " Source VIMRC "
    nnoremap rc :source $MYVIMRC<CR>

	"Setting"
	" Toggle colors to optimize based on light or dark background "
	nnoremap <leader>c :call ahmed#mappings#normal#toggletheme#()<CR>
	" toggle number "
	nnoremap <silent> <leader>n :call ahmed#mappings#normal#numbertoggle#()<CR>

	" generate doc "
  	nnoremap <silent> <leader>gd :<C-u>call ahmed#mappings#normal#generatedoc#()<CR>

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
    nnoremap [<Space> :<C-u>put! =repeat(nr2char(10), v:count1) <Bar> ']+1<CR>
    nnoremap ]<Space> :<C-u>put =repeat(nr2char(10), v:count1) <Bar> '[-1<CR>

    "Close pane using <C-w> - Disabled due to using buftabline!"
    "noremap <silent> <C-w> :call <SID>ahmed#autocmds#closetab#()<Cr>"

    " Lookup definition under cursor."
    nnoremap <silent> gt :call ahmed#mappings#normal#lookup#()<CR>

    " Open URL under cursor in browser or open path in GUI explorer."
    "nnoremap <silent> gb :execute printf('silent !xdg-open "%s" 2>/dev/null', fnameescape(expand('<cfile>')))<CR>"

    " Scroll viewport faster."
    nnoremap <C-e> 2<C-e>
    nnoremap <C-y> 2<C-y>

    " Store relative line number jumps in the jumplist if they exceed a threshold."
    nnoremap <expr> j v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj'
    nnoremap <expr> k v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk'

    " Toggle common options. "
    nnoremap <silent> cos :set spell!<CR>
    nnoremap <silent> cow :set wrap!<CR>
    nnoremap <silent> coh :set hlsearch!<CR>
    nnoremap <silent> coH :let @/ = ''<CR>
    nnoremap <silent> col :set list!<CR>
    nnoremap <silent> cop :set paste!<CR>
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
    nnoremap <Leader>r :%s/\<<C-r><C-w>\>/

    " select but dont jump"
    nnoremap <Leader>8 *#
    nnoremap <Leader>3 #*

" }}} Search "

" Change & Replace & Remove {{{ "
    " Refactor word under cursor."
    nnoremap c* /\<<C-R>=expand('<cword>')<CR>\>\C<CR>``cgn
    nnoremap c# ?\<<C-R>=expand('<cword>')<CR>\>\C<CR>``cgN

    " Delete word under cursor."
    nnoremap d* /\<<C-r>=expand('<cword>')<CR>\>\C<CR>``dgn
    nnoremap d# ?\<<C-r>=expand('<cword>')<CR>\>\C<CR>``dgN
" }}} Change & Replace & Remove "

" Copy {{{ "
    " Make `Y` acting like `C`, `D`."
    nnoremap Y y$

    "copy line and leave a marker"
    nnoremap yy yymy

    " [y]ank [p]ath [f]ull."
    nnoremap <silent> ypf :let @+ = expand('%:p')<CR>
    " [y]ank [p]ath [r]elative."
    nnoremap <silent> ypr :let @+ = expand('%')<CR>
    " [y]ank [p]ath [n]ame of the file."
    nnoremap <silent> ypn :let @+ = expand('%:t')<CR>

    " Select last changed or yanked area."
    nnoremap <expr> gV '`[' . strpart(getregtype(), 0, 1) . '`]'

" }}} Copy "

" Buffers & Windows {{{ "
    " Buffers and windows are independent. That means you can navigate through one buffer in one window while the other buffer in the other window stays where you left."

    " Horizontal Split with New Buffer "
    nnoremap <silent> <leader>bh :new<CR>

    " Vertical Split with New Buffer "
    nnoremap <silent> <leader>bv :vnew<CR>

	" Vertical Split with New Buffer "
	nnoremap <leader>b :set nomore <Bar> :ls <Bar> :set more <CR>:b<Space>

	"vertical split"
	nnoremap <leader>vl :ls<cr>:vsp<space>\|<space>b<space>
	"horizontal split"
	nnoremap <leader>hl :ls<cr>:sp<space>\|<space>b<space>

    " Switch between Current and Last buffer"
    nnoremap <silent> <leader>bb <C-^>

	" Cursor Movement in Windows"
	nnoremap <C-l> <C-w>l
	nnoremap <C-h> <C-w>h

	" Go to Next/Previous Buffer"
	nnoremap <silent> <Tab> :bn<CR>
	nnoremap <silent> <S-Tab> :bp<CR>

    " Close buffer"
    nnoremap <silent> <C-w> :bd<CR>

    " List Buffers "
    nnoremap <silent> <leader>bl :ls<CR>

    " List and Select Buffer "
    nnoremap <silent> <leader>bg :ls<CR>:buffer<Space>

    " Close Split"
    nnoremap <C-w>c :close<CR>
    nnoremap <C-w>q :q<CR>
    nnoremap <C-w>o :only<CR>

    " Toggle terminal buffer."
    " - Toggle terminal buffer in Terminal Mode"
    tnoremap <silent> <C-z> <C-\><C-n>:call ahmed#mappings#normal#terminal#()<CR>
    "- Toggle terminal buffer in Normal Mode"
    nnoremap <silsent> <C-z> :call ahmed#mappings#normal#terminal#()<CR>
    " - Open SHELL in Vertical Split"
    nnoremap <silent> <leader>tv :vnew<CR>:call ahmed#mappings#normal#terminal#()<CR>
    "- Open SHELL in Horizontal Split"
    nnoremap <silent> <leader>th :new<CR>:call ahmed#mappings#normal#terminal#()<CR>
    "- Quite SHELL"
    tnoremap <C-x> <C-\><C-n><C-w>q

    " Toggle zoom current buffer in the new tab."
    nnoremap <silent> <leader>gz :call ahmed#mappings#normal#zoom#()<CR>

" }}} Buffers & Windows "

" Quickfix {{{ "
    nnoremap <silent> =oq :copen<CR>
    nnoremap <silent> =oQ :chistory<CR>
    nnoremap <silent> [q :cprevious<CR>
    nnoremap <silent> ]q :cnext<CR>
    nnoremap <silent> [Q :cpfile<CR>
    nnoremap <silent> ]Q :cnfile<CR>
    nnoremap <silent> <Up> :cprevious<CR>
    nnoremap <silent> <Down> :cnext<CR>
    nnoremap <silent> <Left> :cpfile<CR>
    nnoremap <silent> <Right> :cnfile<CR>
    nnoremap <silent> [<C-q> :cfirst<CR>
    nnoremap <silent> ]<C-q> :clast<CR>
" }}} Quickfix "

" Location {{{ "
    nnoremap <silent> =ol :lopen<CR>
    nnoremap <silent> =oL :lhistory<CR>
    nnoremap <silent> [l :lprevious<CR>
    nnoremap <silent> ]l :lnext<CR>
    nnoremap <silent> [L :lpfile<CR>
    nnoremap <silent> ]L :lnfile<CR>
    nnoremap <silent> [<C-l> :lfirst<CR>
    nnoremap <silent> ]<C-l> :llast<CR>
" }}} Location "

" Argument {{{ "
    nnoremap <silent> =oa :args<CR>
    nnoremap <silent> [a :previous<CR>
    nnoremap <silent> ]a :next<CR>
    nnoremap <silent> [A :first<CR>
    nnoremap <silent> ]A :last<CR>
" }}} Argument "

" Tabs {{{ "
    nnoremap <silent> [t :tabprevious<CR>
    nnoremap <silent> ]t :tabnext<CR>
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
    nnoremap <silent> =og :tags<CR>
    nnoremap <silent> [g :pop<CR>
    nnoremap <silent> ]g :tag<CR>
" }}} Tags "

" Slugify word under cursor "
nnoremap <silent> <Plug>SlugifyNormal ciw<C-R>=ahmed#mappings#normal#slugify#(getreg('"'))<CR> :silent! call repeat#set("\<Plug>SlugifyNormal")<CR>
nmap <silent> <leader>s <Plug>SlugifyNormal
