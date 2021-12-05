local map = require('_.utils.map')
local au = require('_.utils.au')

-- Move lines
-- map.inoremap('<S-Down>', '<Esc>:m .+1<CR>==gi')
-- map.inoremap('<S-Up>', '<Esc>:m .-2<CR>==gi')

-- Disable arrow keys
map.imap('<up>', '<nop>')
map.imap('<down>', '<nop>')
map.imap('<left>', '<nop>')
map.imap('<right>', '<nop>')
-- "BUG: 🐛 vim ≥ 8.2, the below mapping TOTALLY breaks mouse actions ie.
-- ...no scrolling with `vimdiff`
-- if vim.fn.has 'nvim'
--   nnoremap <esc> :
-- end

-- NOTE: - the below insert mappings will bind 'jk' / 'kj' to ESC
-- key functionality, so need to use <ESC> in insert mode
map.imap('jk', '<esc>')
map.imap('kj', '<esc>')
map.imap('jj', '<esc>')
map.imap('kk', '<esc>')

map.inoremap('<Down>', '<ESC><Down>', {
  silent = true,
})

-- when pairing some braces or quotes, put cursor between them
-- map.inoremap('<>', '<><Left>')
-- map.inoremap('()', '()<Left>')
-- map.inoremap('{}', '{}<Left>')
-- map.inoremap('[]', '[]<Left>')
-- map.inoremap('""', '""<Left>')
-- map.inoremap('''', '''<Left>')
-- map.inoremap('``', '``<Left>')

-- save using <C-s> and back to normal mode
map.inoremap('<C-s>', '<Esc>:write<Cr>')

-- This keybinding allows you to jump to the end of the line and we are switched back to insert mode
map.inoremap('<C-l>', '<C-o>$')

-- This keybinding allows you to instead jump to beginning of a line while in insert mode.
map.inoremap('<C-a>', '<C-o>0')

-- https://twitter.com/vimgifs/status/913390282242232320
-- :h i_CTRL-G_u
au.augroup('__prose_mappings__', function()
  au.autocmd('FileType', 'markdown,text', function()
    map.inoremap('.', '.<c-g>u', { buffer = true })
  end)
  au.autocmd('FileType', 'markdown,text', function()
    map.inoremap('?', '?<c-g>u', { buffer = true })
  end)
  au.autocmd('FileType', 'markdown,text', function()
    map.inoremap('!', '!<c-g>u', { buffer = true })
  end)
  au.autocmd('FileType', 'markdown,text', function()
    map.inoremap(',', ',<c-g>u', { buffer = true })
  end)
end)
