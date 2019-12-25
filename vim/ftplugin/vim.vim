" Define the command to be used when looking definition."
setlocal keywordprg=:help

setlocal iskeyword-=#

setlocal conceallevel=2

" Source current file."
nnoremap <buffer><silent> <LocalLeader>r :source %<Enter>

let b:undo_ftplugin = 'setlocal iskeyword< conceallevel<'
