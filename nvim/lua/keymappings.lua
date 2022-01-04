-- luacheck: max line length 130

local map = require('utils.map')
local opts = { noremap = true, silent = true }

-- Better window movement
map.nnoremap('<C-h>', '<C-w>h', { silent = true })
map.nnoremap('<C-j>', '<C-w>j', { silent = true })
map.nnoremap('<C-k>', '<C-w>k', { silent = true })
map.nnoremap('<C-l>', '<C-w>l', { silent = true })

-- Move selected line / block of text in visual mode
map.xnoremap('K', ":move '<-2<CR>gv-gv", opts)
map.xnoremap('J', ":move '>+1<CR>gv-gv", opts)

-- Keep visual mode indenting
map.vnoremap('<', '<gv', opts)
map.vnoremap('>', '>gv', opts)

-- Make word uppercase
map.nnoremap('<C-u>', 'viwU<ESC>', { noremap = true })
map.inoremap('<C-u>', '<ESC>viwUi', { noremap = true })

-- Remove highlights
map.nnoremap('<CR>', ':noh<CR><CR>', opts)

-- Don't yank on delete char
map.nnoremap('x', '"_x', opts)
map.nnoremap('X', '"_X', opts)
map.vnoremap('x', '"_x', opts)
map.vnoremap('X', '"_X', opts)

-- Avoid issues because of remapping <c-a> and <c-x> below
vim.cmd([[
  nnoremap <Plug>SpeedDatingFallbackUp <c-a>
  nnoremap <Plug>SpeedDatingFallbackDown <c-x>
]])

-- Quickfix
map.nnoremap('<Space>,', ':cp<CR>', { silent = true })
map.nnoremap('<Space>.', ':cn<CR>', { silent = true })
map.nnoremap('<Space>cc', ':cclose<CR>', { silent = true })

-- Easyalign
map.nnoremap('ga', '<Plug>(EasyAlign)', { silent = true })
map.xnoremap('ga', '<Plug>(EasyAlign)', { silent = true })

-- Manually invoke speeddating in case switch.vim didn't work
map.nnoremap(
  '<C-a>',
  ':if !switch#Switch() <bar> call speeddating#increment(v:count1) <bar> endif<CR>',
  opts
)
map.nnoremap(
  '<C-x>',
  ":if !switch#Switch({'reverse': 1}) <bar> call speeddating#increment(-v:count1) <bar> endif<CR>",
  opts
)

-- Space to NOP to prevent Leader issues
map.nnoremap('<Space>', '<NOP>', opts)

-- Open links under cursor in browser with gx
if vim.fn.has('macunix') == 1 then
  map.nnoremap(
    'gx',
    "<cmd>silent execute '!open ' . shellescape('<cWORD>')<CR>",
    { silent = true }
  )
else
  map.nnoremap(
    'gx',
    "<cmd>silent execute '!xdg-open ' . shellescape('<cWORD>')<CR>",
    { silent = true }
  )
end

-- Erase painter line
map.nnoremap(
  '<F4>',
  "<cmd>lua require('functions').erase_painter_line()<CR>",
  opts
)
