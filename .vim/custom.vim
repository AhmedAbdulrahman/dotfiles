"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Functions"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" NERDTress File highlighting"
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

"Close pane using <C-w>"
function! s:__bclose()
  if (len(getbufinfo({'buflisted': 1})) > 1)
    bdelete
  endif
endfunction

" Visual mode related"
" Visual mode pressing * or # searches for the current selection"

function! VisualSelection(direction) range
    let l:saved_reg = @
    execute "normal! vgvy"

    let l:pattern = escape(@, '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @ = l:saved_reg
endfunction

" Returns true if paste mode is enabled"
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

"Rename file name"
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction