setlocal conceallevel=2

" Execute current file."
nnoremap <buffer><silent> <LocalLeader>r :execute 'split <Bar> terminal python' shellescape(@%, 1)<Enter>

let b:undo_ftplugin = 'setlocal conceallevel<'