local au = require('utils.au')
local keymap = vim.keymap
local silent = { silent = true }

-- Make word uppercase
keymap.set('i', '<C-u>', '<ESC>viwUi', slient)

-- Disable arrow keys
keymap.set('i', '<up>', '<nop>')
keymap.set('i', '<down>', '<nop>')
keymap.set('i', '<left>', '<nop>')
keymap.set('i', '<right>', '<nop>')
-- "BUG: 🐛 vim ≥ 8.2, the below mapping TOTALLY breaks mouse actions ie.
-- ...no scrolling with `vimdiff`
-- if vim.fn.has 'nvim'
--   nnoremap <esc> :
-- end

-- NOTE: - the below insert mappings will bind 'jk' / 'kj' to ESC
-- key functionality, so need to use <ESC> in insert mode
keymap.set('i', 'jk', '<esc>')
keymap.set('i', 'kj', '<esc>')
keymap.set('i', 'jj', '<esc>')
keymap.set('i', 'kk', '<esc>')

keymap.set('i', '<Down>', '<ESC><Down>', {
  silent = true,
})

-- save file using CTRL-S and back to normal mode
keymap.set('i', '<C-s>', '<ESC> :w<CR>', slient)

-- This keybinding allows you to jump to the end of the line
-- and we are switched back to insert mode
keymap.set('i', '<C-l>', '<C-o>$')

-- This keybinding allows you to instead jump to beginning of a line
-- while in insert mode.
keymap.set('i', '<C-a>', '<C-o>0')

-- https://twitter.com/vimgifs/status/913390282242232320
-- :h i_CTRL-G_u
au.group('__prose_mappings__', {
    {
        'FileType',
        'markdown,text',
        function()
            keymap.set('i', '.', '.<c-g>u', { buffer = true })
        end,
    },
    {
        'FileType',
        'markdown,text',
        function()
            keymap.set('i', '?', '?<c-g>u', { buffer = true })
        end,
    },
	{
        'FileType',
        'markdown,text',
        function()
			keymap.set('i', '!', '!<c-g>u', { buffer = true })
        end,
    },
	{
        'FileType',
        'markdown,text',
        function()
            keymap.set('i', ',', ',<c-g>u', { buffer = true })
        end,
    },
})
