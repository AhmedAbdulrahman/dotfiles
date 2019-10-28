"Move lines"
inoremap <S-Down> <Esc>:m .+1<CR>==gi
inoremap <S-Up> <Esc>:m .-2<CR>==gi

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

" Go next and previous completion when popup menu is visible."
inoremap <silent><expr> <Tab> ahmed#mappings#insert#handle#tab({ 'key': "\<Tab>" })
inoremap <silent><expr> <S-Tab> ahmed#mappings#insert#handle#tab({ 'key': "\<S-Tab>" })

" Accept completion or expand snippet when popup menu is visible."
inoremap <expr> <Enter> ahmed#mappings#insert#handle#enter()

"This keybinding allows you to jump to the end of the line and we are switched back to insert mode"
inoremap <C-e> <C-o>$

"This keybinding allows you to instead jump to beginning of a line while in insert mode."
inoremap <C-a> <C-o>0
