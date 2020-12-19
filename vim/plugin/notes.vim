if !has('nvim')
  finish
endif

" https://vimways.org/2019/personal-notetaking-in-vim/ "
" https://danishpraka.sh/2020/02/23/journaling-in-vim.html "

command! -complete=customlist,ahmed#autocmds#notes#getNotesCompletion -nargs=? Note call ahmed#autocmds#notes#note_edit(<f-args>)
command! -nargs=? Wiki call ahmed#autocmds#notes#wiki_edit(<f-args>)

" use Ripgrep for search notes if avaiable"
if executable('rg')
	command! -bang -nargs=? -complete=dir Notes
		\ call fzf#run(fzf#wrap(fzf#vim#with_preview({
		\   'source': "rg --files --hidden --follow --no-messages --smart-case ".expand(ahmed#autocmds#notes#getDir())
		\ }, 'right:60%', '?')))
else
	command! -bang Notes call fzf#vim#files(ahmed#autocmds#notes#getDir())
endif

nnoremap <silent> <leader>sn :Notes<CR>
