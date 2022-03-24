local map = require('utils.map')
local opts = { noremap = true, silent = true }

-- https://github.com/mhinz/vim-galore#dont-lose-selection-when-shifting-sidewards
map.xnoremap('<', '<gv')
map.xnoremap('>', '>gv')

-- Keep visual mode indenting
map.vnoremap('<', '<gv', opts)
map.vnoremap('>', '>gv', opts)

-- Don't yank on delete char
map.vnoremap('x', '"_x', opts)
map.vnoremap('X', '"_X', opts)

-- Don't yank on visual paste
map.vnoremap('p', '"_dP', opts)

-- Make dot work in visual mode
map.vnoremap('.', ':norm.<CR>')

-- Easyalign
map.xnoremap('ga', '<Plug>(EasyAlign)', { silent = true })

map.vmap('<Leader>hu', ':call utils#HtmlUnEscape()<cr>', {
  silent = true,
})

map.vmap('<Leader>he', ':call utils#HtmlEscape()<cr>', {
  silent = true,
})

-- Allows you to visually select a section and then hit @ to run a macro on all lines
-- https://medium.com/@schtoeffel/you-don-t-need-more-than-one-cursor-in-vim-2c44117d51db#.3dcn9prw6
vim.cmd([[function! ExecuteMacroOverVisualRange()
	echo '@'.getcmdline()
	execute ":'<,'>normal @".nr2char(getchar())
  endfunction]])

map.xnoremap('@', ':<C-u>call ExecuteMacroOverVisualRange()<CR>')

-- More easier increment/decrement mappings
map.xnoremap('+', 'g<C-a>')
map.xnoremap('-', 'g<C-x>')

-- Execute "q" macro over visual line selections
map.xnoremap('Q', [[:'<,'>:normal @q<CR>]])

-- Always search with 'very magic' mode.
map.xnoremap('/', '/\v')
map.xnoremap('?', '?\v')

-- easy regex replace for current word
map.xnoremap('<leader>r', ':<c-u>%s/\\%V')

-- Move highlighted lines
map.xnoremap(
  'K',
  ':call mappings#visual#movelines#moveup()<CR>',
  { silent = true }
)
map.xnoremap(
  'J',
  ':call mappings#visual#movelines#movedown()<CR>',
  { silent = true }
)

-- -- Move selected line / block of text in visual mode
-- map.xnoremap('K', ":move '<-2<CR>gv-gv", opts)
-- map.xnoremap('J', ":move '>+1<CR>gv-gv", opts)
