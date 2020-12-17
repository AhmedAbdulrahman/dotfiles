" https://vimways.org/2019/personal-notetaking-in-vim/ "
" https://danishpraka.sh/2020/02/23/journaling-in-vim.html "

command! -complete=customlist,ahmed#autocmds#notes#getNotesCompletion -nargs=? Note call ahmed#autocmds#notes#note_edit(<f-args>)
command! -nargs=? Wiki call ahmed#autocmds#notes#wiki_edit(<f-args>)
command! -bang Notes call fzf#vim#files(ahmed#autocmds#notes#getDir())

nnoremap <silent> <leader>ww :Notes<CR>
