local map = require '_.utils.map'

-- https://github.com/mhinz/vim-galore#dont-lose-selection-when-shifting-sidewards
map.xnoremap('<', '<gv')
map.xnoremap('>', '>gv')

-- Make dot work in visual mode
map.vnoremap('.', ':norm.<CR>')


map.vmap('<Leader>hu', ':call ahmed#utils#HtmlUnEscape()<cr>', {
	silent = true,
})

map.vmap('<Leader>he', ':call ahmed#utils#HtmlEscape()<cr>', {
	silent = true,
})

-- Allows you to visually select a section and then hit @ to run a macro on all lines
-- https://medium.com/@schtoeffel/you-don-t-need-more-than-one-cursor-in-vim-2c44117d51db#.3dcn9prw6
vim.cmd [[function! ExecuteMacroOverVisualRange()
	echo '@'.getcmdline()
	execute ":'<,'>normal @".nr2char(getchar())
  endfunction]]

map.xnoremap('@', ':<C-u>call ExecuteMacroOverVisualRange()<CR>')

-- More easier increment/decrement mappings
map.xnoremap('+', 'g<C-a>')
map.xnoremap('-', 'g<C-x>')

-- Execute "q" macro over visual line selections
map.xnoremap('Q', [[:'<,'>:normal @q<CR>]])

-- Jump 5 lines/character UP|DOWN|RIGHT|LEFT
map.xnoremap('<C-j>', '5j')
map.xnoremap('<C-k>', '5k')
map.xnoremap('<C-h>', '5h')
map.xnoremap('<C-l>', '5l')

-- Always search with 'very magic' mode.
map.xnoremap('/', '/\v')
map.xnoremap('?', '?\v')

-- easy regex replace for current word
map.xnoremap('<leader>r', ':<c-u>%s/\\%V')

-- save using <C-s> and back to normal mode
map.vnoremap('<C-s>', '<C-c>:write<Cr>')

-- Move highlighted lines
map.xnoremap('K', ':call ahmed#mappings#visual#movelines#moveup()<CR>', { silent = true })
map.xnoremap('J', ':call ahmed#mappings#visual#movelines#movedown()<CR>', { silent = true })
