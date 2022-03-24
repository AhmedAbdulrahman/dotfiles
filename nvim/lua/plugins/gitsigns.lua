local gitsigns = require('gitsigns')

local line = vim.fn.line

vim.keymap.set('n', 'm', function()
  gitsigns.dump_cache()
end)
vim.keymap.set('n', 'M', function()
  gitsigns.debug_messages()
end)

local function on_attach(bufnr)
  local function map(mode, l, r, opts)
    opts = opts or {}
    opts.buffer = bufnr
    vim.keymap.set(mode, l, r, opts)
  end

  map(
    'n',
    ']c',
    "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'",
    { expr = true }
  )
  map(
    'n',
    '[c',
    "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'",
    { expr = true }
  )

  map('n', '<leader>hs', gitsigns.stage_hunk)
  map('n', '<leader>hr', gitsigns.reset_hunk)
  map('v', '<leader>hs', function()
    gitsigns.stage_hunk({ line('.'), line('v') })
  end)
  map('v', '<leader>hr', function()
    gitsigns.reset_hunk({ line('.'), line('v') })
  end)
  map('n', '<leader>hS', gitsigns.stage_buffer)
  map('n', '<leader>hu', gitsigns.undo_stage_hunk)
  map('n', '<leader>hR', gitsigns.reset_buffer)
  map('n', '<leader>hp', gitsigns.preview_hunk)
  map('n', '<leader>hb', function()
    gitsigns.blame_line({ full = true })
  end)
  map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
  map('n', '<leader>hd', gitsigns.diffthis)
  map('n', '<leader>hD', function()
    gitsigns.diffthis('~')
  end)
  map('n', '<leader>td', gitsigns.toggle_deleted)

  map('n', '<leader>hQ', function()
    gitsigns.setqflist('all')
  end)
  map('n', '<leader>hq', function()
    gitsigns.setqflist()
  end)

  map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
end

gitsigns.setup({
  debug_mode = true,
  max_file_length = 1000000000,
  signs = {
    add = { show_count = false, text = '┃' },
    change = { show_count = false, text = '┃' },
    delete = { show_count = true },
    topdelete = { show_count = true },
    changedelete = { show_count = true },
  },
  on_attach = on_attach,
  preview_config = {
    border = 'rounded',
  },
  current_line_blame = true,
  current_line_blame_formatter_opts = {
    relative_time = true,
  },
  current_line_blame_opts = {
    delay = 0,
  },
  count_chars = {
    '⒈',
    '⒉',
    '⒊',
    '⒋',
    '⒌',
    '⒍',
    '⒎',
    '⒏',
    '⒐',
    '⒑',
    '⒒',
    '⒓',
    '⒔',
    '⒕',
    '⒖',
    '⒗',
    '⒘',
    '⒙',
    '⒚',
    '⒛',
  },
  _refresh_staged_on_update = false,
  word_diff = true,
})

-- require('gitsigns').setup {
--     signs = {
--       add          = {hl = 'GitGutterAdd',    text = '│', numhl='GitSignsAddNr'},
--       change       = {hl = 'GitGutterChange', text = '│', numhl='GitSignsChangeNr'},
--       delete       = {hl = 'GitGutterDelete', text = '_', numhl='GitSignsDeleteNr'},
--       topdelete    = {hl = 'GitGutterDelete', text = '‾', numhl='GitSignsDeleteNr'},
--       changedelete = {hl = 'GitGutterChange', text = '~', numhl='GitSignsChangeNr'},
--     },
--     signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
--     numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
--     linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
--     word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
--     watch_gitdir = {
--       interval = 700,
--       follow_files = true
--     },
--     attach_to_untracked = true,
--     current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
--     current_line_blame_opts = {
--       virt_text = true,
--       virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
--       delay = 700,
--       ignore_whitespace = false,
--     },
--     current_line_blame_formatter_opts = {
--       relative_time = false
--     },
--     sign_priority = 6,
--     update_debounce = 100,
--     status_formatter = nil, -- Use default
--     max_file_length = 40000,
--     preview_config = {
--       -- Options passed to nvim_open_win
--       border = NvimConfig.ui.float.border,
--       style = 'minimal',
--       relative = 'cursor',
--       row = 0,
--       col = 1
--     },
--     yadm = {
--       enable = false
--     },
--     on_attach = function(bufnr)
--       local gs = package.loaded.gitsigns

--       local function map(mode, l, r, opts)
--         opts = opts or {}
--         opts.buffer = bufnr
--         vim.keymap.set(mode, l, r, opts)
--       end

--       -- Navigation
--       map('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", {expr=true})
--       map('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", {expr=true})

--       -- Actions
--       map({'n', 'v'}, '<leader>ghs', gs.stage_hunk)
--       map({'n', 'v'}, '<leader>ghr', gs.reset_hunk)
--       map('n', '<leader>ghS', gs.stage_buffer)
--       map('n', '<leader>ghu', gs.undo_stage_hunk)
--       map('n', '<leader>ghR', gs.reset_buffer)
--       map('n', '<leader>ghp', gs.preview_hunk)
--       map('n', '<leader>gm', function() gs.blame_line{full=true} end)
--       map('n', '<leader>ghd', gs.diffthis)
--       map('n', '<leader>ght', gs.toggle_deleted)

--       -- Text object
--       map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
--     end
--   }
