"Move lines"
inoremap <S-j> <Esc>:m .+1<CR>==gi
inoremap <S-k> <Esc>:m .-2<CR>==gi

"Disable arrow keys"
inoremap <Up>    <NOP>
inoremap <Down>  <NOP>

"when pairing some braces or quotes, put cursor between them"
inoremap <>   <><Left>
inoremap ()   ()<Left>
inoremap {}   {}<Left>
inoremap []   []<Left>
inoremap ""   ""<Left>
inoremap ''   ''<Left>
inoremap ``   ``<Left>

"save using <C-s> and back to normal mode"
inoremap <C-s> <Esc>:write<Cr>
