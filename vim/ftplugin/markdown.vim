" Enable spell checking."
setlocal spell

" Wrap lines longer than the width of the window."
setlocal wrap

" Disable all line numbers."
setlocal nonumber
setlocal norelativenumber

" Toggle local preview server."
nnoremap <buffer><silent> <LocalLeader>r :call ahmed#ftplugin#markdown#preview()<Enter>
