local map = require('utils.map')
local opts = { noremap = true, silent = true }

-- Avoid issues because of remapping <c-a> and <c-x> below
vim.cmd([[
  nnoremap <Plug>SpeedDatingFallbackUp <c-a>
  nnoremap <Plug>SpeedDatingFallbackDown <c-x>
]])

map.nnoremap('<leader>Q', ':quitall<CR>', {
  silent = true,
})
-- Override Ex mode with run @@ to record, Q to replay
map.nnoremap('Q', '@@')

-- Make word uppercase
map.nnoremap('<C-u>', 'viwU<ESC>', { noremap = true })

-- Easyalign
map.nnoremap('ga', '<Plug>(EasyAlign)', { silent = true })

-- Better window movement
map.nnoremap('<C-h>', '<C-w>h', { silent = true })
map.nnoremap('<C-j>', '<C-w>j', { silent = true })
map.nnoremap('<C-k>', '<C-w>k', { silent = true })
map.nnoremap('<C-l>', '<C-w>l', { silent = true })

-- Insert an empty new line 							without entering insert mode
map.nnoremap('<leader>o', ':put =repeat(nr2char(10), v:count1)<CR>')
map.nnoremap('<leader>O', ':put! =repeat(nr2char(10), v:count1)<CR>')

-- -- Always search with 'very magic' mode.
-- map.nnoremap('/', '/\v')
-- map.nnoremap('?', '?\v')

-- Always send contents of a `x` command to the black hole register.
-- Don't yank on delete char
map.nnoremap('x', '"_x', opts)
map.nnoremap('X', '"_X', opts)

-- Refactor word under cursor.
map.nnoremap('c*', '/\\<<C-r>=expand("<cword>")<CR>\\>\\C<CR>``cgn')
map.nnoremap('c#', '?\\<<C-r>=expand("<cword>")<CR>\\>\\C<CR>``cgN')

-- Reveal syntax group under cursor.
map.nnoremap(
  '<F10>',
  "<Cmd>lua require('mappings/normal/syntax').reveal_syntax_group()<CR>",
  { silent = true }
)

-- Construct grep search.
map.nnoremap('g/', ':Grep<Space>')
map.nnoremap('gS', ':Grep!<Space>')

-- Open URL under cursor in browser or open path in GUI explorer.
-- map.nnoremap('gb', ':execute printf('silent !xdg-open "%s" 2>/dev/null', expand('<cfile>'))<CR>', {
-- 	silent = true,
-- })

-- Toggle common options.
map.nnoremap('cos', ':set spell!<CR>', { silent = true })
map.nnoremap('cow', ':set wrap!<CR>', { silent = true })
map.nnoremap('coh', ':nohlsearch<CR>', { silent = true })
map.nnoremap('coH', ':set hlsearch!<CR>', { silent = true })

-- save file using CTRL-S
-- map.nnoremap('<C-s>', ':write<Cr>', { silent = true })

-- Jump to a tag directly when there is only one match.
map.nnoremap('<C-]>', 'g<C-]>zt')

-- Go previous and next location list entry.
map.nnoremap('[l', ':labove<CR>', { silent = true })
map.nnoremap(']l', ':lbelow<CR>', { silent = true })

-- Buffers and windows are independent.
-- That means you can navigate through one buffer in one window,
-- while the other buffer in the other window stays where you left

-- Go previous and next buffers in buffer list.
map.nnoremap('<M-p>', '<Cmd>bprevious<CR>', { silent = true })
map.nnoremap('<M-n>', '<Cmd>bnext<CR>', { silent = true })

-- Horizontal Split with New Buffer
map.nnoremap('<leader>bh', ':new<CR>', { silent = true })

-- Vertical Split with New Buffer
map.nnoremap('<leader>bv', ':vnew<CR>', { silent = true })

-- Vertical Split with New Buffer
map.nnoremap(
  '<leader>b',
  ':set nomore <Bar> :ls <Bar> :set more <CR>:b<Space>',
  { silent = true }
)

-- Vertical split with current buffer
map.nnoremap(
  '<leader>vl',
  ':ls<cr>:vsp<space>\\|<space>b<space>',
  { silent = true }
)
-- Horizontal split with current buffer
map.nnoremap(
  '<leader>hl',
  ':ls<cr>:sp<space>\\|<space>b<space>',
  { silent = true }
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

-- Make arrowkey do something usefull, resize the viewports accordingly
map.nnoremap('<Right>', ':vertical resize -2<CR>', { silent = true })
map.nnoremap('<Left>', ':vertical resize +2<CR>', { silent = true })
map.nnoremap('<Down>', ':resize -2<CR>', { silent = true })
map.nnoremap('<Up>', ':resize +2<CR>', { silent = true })

-- Go to the alternate buffer.
map.nnoremap('<C-n>', '<C-^>')
-- Open a new buffer in current session
-- map.nnoremap('<leader>e', ':e <C-R>=expand("%:p:h") . "/" <CR>')
-- Indent the entire file 😯, do you believe in magic
map.nnoremap('<leader>i', 'mmgg=G`m<CR>')

-- QuickFix navigation mappings.
map.nnoremap('<Up>', ':cprevious<CR>', { silent = true })
map.nnoremap('<Down>', ':cnext<CR>', { silent = true })
map.nnoremap('<Left>', ':cpfile<CR>', { silent = true })
map.nnoremap('<Right>', ':cnfile<CR>', { silent = true })

map.nnoremap('<Space>,', ':cp<CR>', { silent = true })
map.nnoremap('<Space>.', ':cn<CR>', { silent = true })

-- Toggle quicklist
map.nnoremap(
  '<leader>q',
  '<cmd>lua require("utils").toggle_quicklist()<CR>',
  { noremap = true, silent = true }
)

-- highlight last inserted text
map.nnoremap('gV', [[`[v`]']])

-- From https://bitbucket.org/sjl/dotfiles/src/tip/vim/vimrc
-- The `zzzv` keeps search matches in the middle of the window.
-- and make sure n will go forward when searching with ? or #
-- https://vi.stackexchange.com/a/2366/4600
map.nnoremap('n', [[(v:searchforward ? 'n' : 'N') . 'zzzv']], { expr = true })
map.nnoremap('N', [[(v:searchforward ? 'N' : 'n') . 'zzzv']], { expr = true })

-- Center { & } movements
map.nnoremap('{', '{zz')
map.nnoremap('}', '}zz')

-- Move by 'display lines' rather than 'logical lines' if no v:count was
-- provided.  When a v:count is provided, move by logical lines.
-- Store relative line number jumps in the jumplist if they exceed a threshold.
map.nnoremap(
  'j',
  [[v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj']],
  { expr = true }
)
map.xnoremap(
  'j',
  [[v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj']],
  { expr = true }
)
map.nnoremap(
  'k',
  [[v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk']],
  { expr = true }
)
map.xnoremap(
  'k',
  [[v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk']],
  { expr = true }
)

-- Make `Y` behave like `C` and `D` (to the end of line)
if not vim.fn.has('nvim-0.6') then
  map.nnoremap('Y', 'y$')
end

-- map.nnoremap('<Leader>p', [[:t.<left><left>]])
-- map.nnoremap('<leader>e', [[:exe getline(line('.'))<cr>]])

-- map.nnoremap('<leader>z', ':call ahmed#utils#ZoomToggle()<cr>', {
--   silent = true,
-- })

-- map.nnoremap('<C-g>', ':call ahmed#utils#SynStack()<cr>')

-- maintain the same shortcut as vim-gtfo becasue it's in my muscle memory.
-- map.nnoremap('gof', ':call ahmed#utils#OpenFileFolder()<cr>', {
--   silent = true,
-- })

-- Quick note taking per project
map.nmap('<Localleader>t', ':tab drop .git/todo.md<CR>')

-- More easier increment/decrement mappings
map.nnoremap('+', '<C-a>')
map.nnoremap('-', '<C-x>')

-- Redirect change operations to the blackhole
map.nnoremap('c', '"_c')
map.nnoremap('C', '"_C')

-- Create a directory if it doesn't exist
map.nnoremap('<leader>mkd', ':!mkdir -p %:p:h<', {
  silent = true,
})

-- new file in current directory
map.nnoremap('<Leader>n', [[:e <C-R>=expand("%:p:h") . "/" <CR>]])

-- Remove highlights
map.nnoremap('<CR>', ':noh<CR><CR>', opts)

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
