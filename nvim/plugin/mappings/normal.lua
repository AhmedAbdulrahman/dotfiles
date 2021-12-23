local map = require('_.utils.map')

-- Quickly close current window.
-- map.nnoremap('<leader>q', ':quit<CR>', {
-- 	silent = true,
-- })

map.nnoremap('<leader>Q', ':quitall<CR>', {
  silent = true,
})
-- Override Ex mode with run @@ to record, Q to replay
map.nnoremap('Q', '@@')

-- Jump 5 lines/character UP|DOWN|RIGHT|LEFT
map.nnoremap('<C-j>', '5j')
map.nnoremap('<C-k>', '5k')
map.nnoremap('<C-h>', '5h')
map.nnoremap('<C-l>', '5l')

-- Insert an empty new line 							without entering insert mode
map.nnoremap('<leader>o', ':put =repeat(nr2char(10), v:count1)<CR>')
map.nnoremap('<leader>O', ':put! =repeat(nr2char(10), v:count1)<CR>')

-- Always search with 'very magic' mode.
map.nnoremap('/', '/\v')
map.nnoremap('?', '?\v')

-- Always send contents of a `x` command to the black hole register.
map.nnoremap('x', '"_x')

-- Refactor word under cursor.
map.nnoremap('c*', '/\\<<C-r>=expand("<cword>")<CR>\\>\\C<CR>``cgn')
map.nnoremap('c#', '?\\<<C-r>=expand("<cword>")<CR>\\>\\C<CR>``cgN')

-- Construct grep search.
map.nnoremap('g/', ':Grep<Space>')
map.nnoremap('gS', ':Grep!<Space>')

-- Resize current window sizes.
-- map.nnoremap('<S-Up>', '2<C-w>+')
-- map.nnoremap('<S-Down>', '2<C-w>-')
-- map.nnoremap('<S-Right>', '2<C-w>>')
-- map.nnoremap('<S-Left>', '2<C-w><')

-- Toggle floating terminal or create new one if there is none.
map.tnoremap(
  '<C-z>',
  '<C-\\><C-n>:lua require("_/config/mappings/normal/terminal").toggle()<CR>',
  {
    silent = true,
  }
)
map.nnoremap(
  '<C-z>',
  '<C-z> :lua require("_/config/mappings/normal/terminal").toggle()<CR>',
  {
    silent = true,
  }
)

-- Open URL under cursor in browser or open path in GUI explorer.
-- map.nnoremap('gb', ':execute printf('silent !xdg-open "%s" 2>/dev/null', expand('<cfile>'))<CR>', {
-- 	silent = true,
-- })

-- Toggle common options.
map.nnoremap('cos', ':set spell!<CR>', { silent = true })
map.nnoremap('cow', ':set wrap!<CR>', { silent = true })
map.nnoremap('coh', ':nohlsearch<CR>', { silent = true })
map.nnoremap('coH', ':set hlsearch!<CR>', { silent = true })

-- Toggle common options.
-- save using <C-s> and back to normal mode
map.nnoremap('<C-s>', ':write<Cr>', { silent = true })

-- Jump to a tag directly when there is only one match.
map.nnoremap('<C-]>', 'g<C-]>zt')

-- Go previous and next location list entry.
map.nnoremap('[l', ':labove<CR>', { silent = true })
map.nnoremap(']l', ':lbelow<CR>', { silent = true })

-- Go previous and next buffers in buffer list.
map.nnoremap('<M-p>', '<Cmd>bprevious<CR>', { silent = true })
map.nnoremap('<M-n>', '<Cmd>bnext<CR>', { silent = true })

-- Buffers and windows are independent.
-- That means you can navigate through one buffer in one window,
-- while the other buffer in the other window stays where you left

-- Go to Next/Previous Buffer
map.nnoremap('<Tab>', ':BufferLineCycleNext<CR>', { silent = true })
map.nnoremap('<S-Tab>', ':BufferLineCyclePrev<CR>', { silent = true })

-- Pick & Close buffer"
map.nnoremap('<leader>q', ':BufferLinePickClose<CR>', { silent = true })

-- Horizontal Split with New Buffer
map.nnoremap('<leader>bh', ':new<CR>', { silent = true })
-- Vertical Split with New Buffer
map.nnoremap('<leader>bv', ':vnew<CR>', { silent = true })
-- Vertical Split with New Buffer
-- map.nnoremap('<leader>b', ':set nomore <Bar> :ls <Bar> :set more <CR>:b<Space>', { silent = true })
-- Vertical split
map.nnoremap(
  '<leader>vl',
  ':ls<cr>:vsp<space>\\|<space>b<space>',
  { silent = true }
)
-- Horizontal split
map.nnoremap(
  '<leader>hl',
  ':ls<cr>:sp<space>\\|<space>b<space>',
  { silent = true }
)
-- Go to the alternate buffer.
map.nnoremap('<C-n>', '<C-^>')
-- Open a new buffer in current session
map.nnoremap('<leader>e', ':e <C-R>=expand("%:p:h") . "/" <CR>')
-- Indent the entire file 😯, do you believe in magic
map.nnoremap('<leader>i', 'mmgg=G`m<CR>')
-- QuickFix navigation mappings.
map.nnoremap('<Up>', ':cprevious<CR>', { silent = true })
map.nnoremap('<Down>', ':cnext<CR>', { silent = true })
map.nnoremap('<Left>', ':cpfile<CR>', { silent = true })
map.nnoremap('<Right>', ':cnfile<CR>', { silent = true })

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

-- Make arrowkey do something usefull, resize the viewports accordingly
map.nnoremap('<Right>', ':vertical resize -2<CR>', { silent = true })
map.nnoremap('<Left>', ':vertical resize +2<CR>', { silent = true })
map.nnoremap('<Down>', ':resize -2<CR>', { silent = true })
map.nnoremap('<Up>', ':resize +2<CR>', { silent = true })

map.nnoremap('<Leader>p', [[:t.<left><left>]])
map.nnoremap('<leader>e', [[:exe getline(line('.'))<cr>]])

map.nnoremap('<leader>z', ':call ahmed#utils#ZoomToggle()<cr>', {
  silent = true,
})

map.nnoremap('<C-g>', ':call ahmed#utils#SynStack()<cr>')

-- maintain the same shortcut as vim-gtfo becasue it's in my muscle memory.
map.nnoremap('gof', ':call ahmed#utils#OpenFileFolder()<cr>', {
  silent = true,
})

-- map.nnoremap(
--   'K',
--   [[:<C-U>exe 'help '. ahmed#utils#helptopic()<CR>]],
--   { silent = true, buffer = true }
-- )

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
