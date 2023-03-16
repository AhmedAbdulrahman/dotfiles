local keymap = vim.keymap
local silent = { silent = true }

-- Plugins
-- Refactor with spectre
keymap.set('x', '<leader>pr', "<cmd>lua require('spectre').open_visual()<CR>")

-- https://github.com/mhinz/vim-galore#dont-lose-selection-when-shifting-sidewards
keymap.set('x', '<', '<gv')
keymap.set('x', '>', '>gv')

-- Keep visual mode indenting
keymap.set('x', '<', '<gv', silent)
keymap.set('x', '>', '>gv', silent)

-- Don't yank on delete char
keymap.set('x', 'x', '"_x', silent)
keymap.set('x', 'X', '"_X', silent)

-- Don't yank on visual paste
keymap.set('x', 'p', '"_dP', silent)

-- Make dot work in visual mode
keymap.set('x', '.', ':norm.<CR>')

keymap.set('x', '<Leader>hu', ':call utils#HtmlUnEscape()<cr>', {
  silent = true,
})

keymap.set('x', '<Leader>he', ':call utils#HtmlEscape()<cr>', {
  silent = true,
})

-- Allows you to visually select a section and then hit @ to run a macro on all lines
-- https://medium.com/@schtoeffel/you-don-t-need-more-than-one-cursor-in-vim-2c44117d51db#.3dcn9prw6
vim.cmd([[function! ExecuteMacroOverVisualRange()
	echo '@'.getcmdline()
	execute ":'<,'>normal @".nr2char(getchar())
  endfunction]])

keymap.set('x', '@', ':<C-u>call ExecuteMacroOverVisualRange()<CR>')

-- More easier increment/decrement mappings
keymap.set('x', '+', 'g<C-a>')
keymap.set('x', '-', 'g<C-x>')

-- Execute "q" macro over visual line selections
keymap.set('x', 'Q', [[:'<,'>:normal @q<CR>]])

-- Always search with 'very magic' mode.
keymap.set('x', '/', '/\v')
keymap.set('x', '?', '?\v')

-- easy regex replace for current word
keymap.set('x', '<leader>r', ':<c-u>%s/\\%V')

-- Move highlighted lines
keymap.set('x', 'K', ':call mappings#visual#movelines#moveup()<CR>', silent)
keymap.set('x', 'J', ':call mappings#visual#movelines#movedown()<CR>', silent)

-- -- Move selected line / block of text in visual mode
-- keymap.set('x', 'K', ":move '<-2<CR>gv-gv", silent)
-- keymap.set('x', 'J', ":move '>+1<CR>gv-gv", silent)
