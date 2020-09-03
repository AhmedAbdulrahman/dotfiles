" Jump to the beginning and end of line."
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" Navigate left and right characters."
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>

" Construct substitute command with 'very magic' mode."
cnoremap ;s substitute/\v//gc<Left><Left><Left><Left>

" Construct global command with 'very magic' mode."
cnoremap ;g global/\v/<Left>

" Construct search and replace with populated quickfix list."
cnoremap ;r cfdo %substitute/<C-r>=@/<CR>//gce<Left><Left><Left><Left>
