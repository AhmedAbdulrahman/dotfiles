local map = require '_.utils.map'
local au = require '_.utils.au'

-- For neovim terminal :term
-- nnoremap <leader>t  :vsplit +terminal<cr>
map.tnoremap(
  '<esc>',
  [[&filetype == 'fzf' ? "\<esc>" : "\<c-\>\<c-n>"]],
  { expr = true }
)

map.tnoremap('<M-h>', '<c-><c-n><c-w>h')
map.tnoremap('<M-j>', '<c-><c-n><c-w>j')
map.tnoremap('<M-k>', '<c-><c-n><c-w>k')
map.tnoremap('<M-l>', '<c-><c-n><c-w>l')

au.augroup('__MyTerm__', function()
	au.autocmd('TermOpen', '*', 'setl nonumber norelativenumber')
	au.autocmd('TermOpen', 'term://*', 'startinsert')
	au.autocmd('TermClose', 'term://*', 'stopinsert')
end)
