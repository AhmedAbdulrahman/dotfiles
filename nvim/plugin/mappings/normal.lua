local keymap = vim.keymap
local silent = { silent = true }


-- Plugins
-- Refactor with spectre
keymap.set('n', '<leader>pr', "<cmd>lua require('spectre').open_visual({select_word=true})<CR>", silent)

-- Lsp
keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", silent)
keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", silent)
keymap.set("n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", silent)
keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references({ includeDeclaration = false })<CR>", silent)
keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", silent)
keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", silent)
keymap.set("v", "<leader>ca", "<cmd>'<,'>lua vim.lsp.buf.range_code_action()<CR>", silent)
keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", silent)
keymap.set("n", "<leader>\\f", "<cmd>lua vim.lsp.buf.formatting()<CR>", silent)
keymap.set("n", "<leader>cf", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", silent)
keymap.set("v", "<leader>cf", "<cmd>'<.'>lua vim.lsp.buf.range_formatting()<CR>", silent)
keymap.set("n", "<leader>cl", "<cmd>lua vim.diagnostic.open_float(nil, { focusable = false, scope = 'line', header = false, border = 'rounded', max_width = 100, close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost' }})<CR>", silent)
keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", silent)
keymap.set("n", "L", "<cmd>lua vim.lsp.buf.signature_help()<CR>", silent)
keymap.set("n", "]g", "<cmd>lua vim.diagnostic.goto_next({ float = { border = 'rounded', max_width = 100 }})<CR>", silent)
keymap.set("n", "[g", "<cmd>lua vim.diagnostic.goto_prev({ float = { border = 'rounded', max_width = 100 }})<CR>", silent)

-- Avoid issues because of remapping <c-a> and <c-x> below
vim.cmd([[
  nnoremap <Plug>SpeedDatingFallbackUp <c-a>
  nnoremap <Plug>SpeedDatingFallbackDown <c-x>
]])

keymap.set('n', '<leader>Q', ':quitall<CR>', {
  silent = true,
})
-- Override Ex mode with run @@ to record, Q to replay
keymap.set('n', 'Q', '@@')

-- Make word uppercase
keymap.set('n', '<C-u>', 'viwU<ESC>', { noremap = true })

-- Easyalign
keymap.set('n', 'ga', '<Plug>(EasyAlign)', silent)

-- Better window movement
keymap.set('n', '<C-h>', '<C-w>h', silent)
keymap.set('n', '<C-j>', '<C-w>j', silent)
keymap.set('n', '<C-k>', '<C-w>k', silent)
keymap.set('n', '<C-l>', '<C-w>l', silent)

-- Insert an empty new line 							without entering insert mode
keymap.set('n', '<leader>o', ':put =repeat(nr2char(10), v:count1)<CR>')
keymap.set('n', '<leader>O', ':put! =repeat(nr2char(10), v:count1)<CR>')

-- -- Always search with 'very magic' mode.
-- keymap.set('n', '/', '/\v')
-- keymap.set('n', '?', '?\v')

-- Always send contents of a `x` command to the black hole register.
-- Don't yank on delete char
keymap.set('n', 'x', '"_x', silent)
keymap.set('n', 'X', '"_X', silent)

-- Refactor word under cursor.
keymap.set('n', 'c*', '/\\<<C-r>=expand("<cword>")<CR>\\>\\C<CR>``cgn')
keymap.set('n', 'c#', '?\\<<C-r>=expand("<cword>")<CR>\\>\\C<CR>``cgN')

-- Reveal syntax group under cursor.
keymap.set(
  'n',
  '<F10>',
  "<Cmd>lua require('mappings/normal/syntax').reveal_syntax_group()<CR>",
  silent
)

-- Construct grep search.
keymap.set('n', 'g/', ':Grep<Space>')
keymap.set('n', 'gS', ':Grep!<Space>')

-- Open URL under cursor in browser or open path in GUI explorer.
-- keymap.set('gb', ':execute printf('silent !xdg-open "%s" 2>/dev/null', expand('<cfile>'))<CR>', {
-- 	silent = true,
-- })

-- Toggle common options.
keymap.set('n', 'cos', ':set spell!<CR>', silent)
keymap.set('n', 'cow', ':set wrap!<CR>', silent)
keymap.set('n', 'coh', ':nohlsearch<CR>', silent)
keymap.set('n', 'coH', ':set hlsearch!<CR>', silent)

-- save file using CTRL-S
-- keymap.set('<C-s>', ':write<Cr>', silent)

-- Jump to a tag directly when there is only one match.
keymap.set('n', '<C-]>', 'g<C-]>zt')

-- Go previous and next location list entry.
keymap.set('n', '[l', ':labove<CR>', silent)
keymap.set('n', ']l', ':lbelow<CR>', silent)

-- Buffers and windows are independent.
-- That means you can navigate through one buffer in one window,
-- while the other buffer in the other window stays where you left

-- Go previous and next buffers in buffer list.
keymap.set('n', '<M-p>', '<Cmd>bprevious<CR>', silent)
keymap.set('n', '<M-n>', '<Cmd>bnext<CR>', silent)

-- Horizontal Split with New Buffer
keymap.set('n', '<leader>bh', ':new<CR>', silent)

-- Vertical Split with New Buffer
keymap.set('n', '<leader>bv', ':vnew<CR>', silent)

-- Vertical Split with New Buffer
keymap.set(
  'n',
  '<leader>b',
  ':set nomore <Bar> :ls <Bar> :set more <CR>:b<Space>',
  silent
)

-- Vertical split with current buffer
keymap.set(
  'n',
  '<leader>vs',
  '<C-W>v',
  silent
)
-- Horizontal split with current buffer
keymap.set(
  'n',
  '<leader>hl',
  '<C-W>s',
  silent
)

-- Space to NOP to prevent Leader issues
keymap.set('n', '<Space>', '<NOP>', silent)

-- Open links under cursor in browser with gx
if vim.fn.has('macunix') == 1 then
  keymap.set(
    'n',
    'gx',
    "<cmd>silent execute '!open ' . shellescape('<cWORD>')<CR>",
    silent
  )
else
  keymap.set(
    'n',
    'gx',
    "<cmd>silent execute '!xdg-open ' . shellescape('<cWORD>')<CR>",
    silent
  )
end

-- Make arrowkey do something usefull, resize the viewports accordingly
keymap.set('n', '<Right>', ':vertical resize -2<CR>', silent)
keymap.set('n', '<Left>', ':vertical resize +2<CR>', silent)
keymap.set('n', '<Down>', ':resize -2<CR>', silent)
keymap.set('n', '<Up>', ':resize +2<CR>', silent)

-- Go to the alternate buffer.
-- keymap.set('<C-n>', '<C-^>')
-- Open a new buffer in current session
-- keymap.set('<leader>e', ':e <C-R>=expand("%:p:h") . "/" <CR>')
-- Indent the entire file 😯, do you believe in magic
keymap.set('n', '<leader>i', 'mmgg=G`m<CR>')

-- QuickFix navigation mappings.
keymap.set('n', '<Up>', ':cprevious<CR>', silent)
keymap.set('n', '<Down>', ':cnext<CR>', silent)
keymap.set('n', '<Left>', ':cpfile<CR>', silent)
keymap.set('n', '<Right>', ':cnfile<CR>', silent)

keymap.set('n', '<Space>,', ':cp<CR>', silent)
keymap.set('n', '<Space>.', ':cn<CR>', silent)

-- Toggle quicklist
keymap.set(
  'n',
  '<leader>q',
  '<cmd>lua require("utils").toggle_quicklist()<CR>',
  { noremap = true, silent = true }
)

-- highlight last inserted text
keymap.set('n', 'gV', [[`[v`]']])

-- From https://bitbucket.org/sjl/dotfiles/src/tip/vim/vimrc
-- The `zzzv` keeps search matches in the middle of the window.
-- and make sure n will go forward when searching with ? or #
-- https://vi.stackexchange.com/a/2366/4600
keymap.set('n', 'n', [[(v:searchforward ? 'n' : 'N') . 'zzzv']], { expr = true })
keymap.set('n', 'N', [[(v:searchforward ? 'N' : 'n') . 'zzzv']], { expr = true })

-- Center { & } movements
keymap.set('n', '{', '{zz')
keymap.set('n', '}', '}zz')

-- Move by 'display lines' rather than 'logical lines' if no v:count was
-- provided.  When a v:count is provided, move by logical lines.
-- Store relative line number jumps in the jumplist if they exceed a threshold.
keymap.set(
  'n',
  'j',
  [[v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj']],
  { expr = true }
)
keymap.set(
  'x',
  'j',
  [[v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj']],
  { expr = true }
)
keymap.set(
  'n',
  'k',
  [[v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk']],
  { expr = true }
)
keymap.set(
  'x',
  'k',
  [[v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk']],
  { expr = true }
)

-- Make `Y` behave like `C` and `D` (to the end of line)
if not vim.fn.has('nvim-0.6') then
  keymap.set('n', 'Y', 'y$')
end

-- keymap.set('n', '<Leader>p', [[:t.<left><left>]])
-- keymap.set('n', '<leader>e', [[:exe getline(line('.'))<cr>]])

-- keymap.set('n', '<leader>z', ':call ahmed#utils#ZoomToggle()<cr>', {
--   silent = true,
-- })

-- keymap.set('n', '<C-g>', ':call ahmed#utils#SynStack()<cr>')

-- maintain the same shortcut as vim-gtfo becasue it's in my muscle memory.
-- keymap.set('n', 'gof', ':call ahmed#utils#OpenFileFolder()<cr>', {
--   silent = true,
-- })

-- Quick note taking per project
keymap.set('n', '<Localleader>t', ':tab drop .git/todo.md<CR>')

-- More easier increment/decrement mappings
keymap.set('n', '+', '<C-a>')
keymap.set('n', '-', '<C-x>')

-- Redirect change operations to the blackhole
keymap.set('n', 'c', '"_c')
keymap.set('n', 'C', '"_C')

-- Create a directory if it doesn't exist
keymap.set('n', '<leader>mkd', ':!mkdir -p %:p:h<', {
  silent = true,
})

-- new file in current directory
keymap.set('n', '<Leader>n', [[:e <C-R>=expand("%:p:h") . "/" <CR>]])

-- Remove highlights
keymap.set('n', '<CR>', ':noh<CR><CR>', silent)

-- Manually invoke speeddating in case switch.vim didn't work
keymap.set(
  'n',
  '<C-a>',
  ':if !switch#Switch() <bar> call speeddating#increment(v:count1) <bar> endif<CR>',
  silent
)
keymap.set(
  'n',
  '<C-x>',
  ":if !switch#Switch({'reverse': 1}) <bar> call speeddating#increment(-v:count1) <bar> endif<CR>",
  silent
)
