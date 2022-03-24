local map = require('utils.map')
local opts = { noremap = true, silent = true }

-- Set barbar's options
vim.g.bufferline = {
  -- Enable/disable animations
  animation = true,

  -- Enable/disable auto-hiding the tab bar when there is a single buffer
  auto_hide = false,

  -- Enable/disable current/total tabpages indicator (top right corner)
  tabpages = true,

  -- Enable/disable close button
  closable = false,

  -- Enables/disable clickable tabs
  --  - left-click: go to buffer
  --  - middle-click: delete buffer
  clickable = true,

  -- Excludes buffers from the tabline
  -- exclude_ft = ['javascript'],
  -- exclude_name = ['package.json'],

  -- Enable/disable icons
  -- if set to 'numbers', will show buffer index in the tabline
  -- if set to 'both', will show buffer index and icons in the tabline
  icons = 'both',

  -- If set, the icon color will follow its corresponding buffer
  -- highlight group. By default, the Buffer*Icon group is linked to the
  -- Buffer* group (see Highlighting below). Otherwise, it will take its
  -- default value as defined by devicons.
  icon_custom_colors = false,

  -- Configure icons on the bufferline.
  icon_separator_active = '▎',
  icon_separator_inactive = '▎',
  icon_close_tab = '',
  icon_close_tab_modified = '●',
  icon_pinned = '車',

  -- If true, new buffers will be inserted at the end of the list.
  -- Default is to insert after current buffer.
  insert_at_end = false,

  -- Sets the maximum padding width with which to surround each tab
  maximum_padding = 2,

  -- Sets the maximum buffer name length.
  maximum_length = 30,

  -- If set, the letters for each buffer in buffer-pick mode will be
  -- assigned based on their name. Otherwise or in case all letters are
  -- already assigned, the behavior is to assign letters in order of
  -- usability (see order below)
  semantic_letters = true,

  -- New buffer letters are assigned in this order. This order is
  -- optimal for the qwerty keyboard layout but might need adjustement
  -- for other layouts.
  letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',

  -- Sets the name of unnamed buffers. By default format is "[Buffer X]"
  -- where X is the buffer number. But only a static string is accepted here.
  no_name_title = nil,
}

-- Buffers (Barbar)
-- Go to Next/Previous Buffer
map.nnoremap('<Tab>', ':BufferNext<CR>', opts)
map.nnoremap('gn', ':bn<CR>', opts)
map.nnoremap('<S-Tab>', ':BufferPrevious<CR>', opts)
map.nnoremap('gp', ':bp<CR>', opts)
map.nnoremap('<S-q>', ':BufferClose<CR>', opts)

-- Move between barbar buffers
map.nnoremap('<Space>1', ':BufferGoto 1<CR>', { silent = true })
map.nnoremap('<Space>2', ':BufferGoto 2<CR>', { silent = true })
map.nnoremap('<Space>3', ':BufferGoto 3<CR>', { silent = true })
map.nnoremap('<Space>4', ':BufferGoto 4<CR>', { silent = true })
map.nnoremap('<Space>5', ':BufferGoto 5<CR>', { silent = true })
map.nnoremap('<Space>6', ':BufferGoto 6<CR>', { silent = true })
map.nnoremap('<Space>7', ':BufferGoto 7<CR>', { silent = true })
map.nnoremap('<Space>8', ':BufferGoto 8<CR>', { silent = true })
map.nnoremap('<Space>9', ':BufferGoto 9<CR>', { silent = true })
map.nnoremap('<A-1>', ':BufferGoto 1<CR>', { silent = true })
map.nnoremap('<A-2>', ':BufferGoto 2<CR>', { silent = true })
map.nnoremap('<A-3>', ':BufferGoto 3<CR>', { silent = true })
map.nnoremap('<A-4>', ':BufferGoto 4<CR>', { silent = true })
map.nnoremap('<A-5>', ':BufferGoto 5<CR>', { silent = true })
map.nnoremap('<A-6>', ':BufferGoto 6<CR>', { silent = true })
map.nnoremap('<A-7>', ':BufferGoto 7<CR>', { silent = true })
map.nnoremap('<A-8>', ':BufferGoto 8<CR>', { silent = true })
map.nnoremap('<A-9>', ':BufferGoto 9<CR>', { silent = true })
