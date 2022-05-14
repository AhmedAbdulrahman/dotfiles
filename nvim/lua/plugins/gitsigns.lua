local gitsigns = require('gitsigns')
local keymap = vim.keymap
local line = vim.fn.line

local function on_attach(bufnr)
  local gs = package.loaded.gitsigns

  keymap.set(
    'n',
    ']c',
    "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'",
    { expr = true }
  )
  keymap.set(
    'n',
    '[c',
    "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'",
    { expr = true }
  )

  keymap.set('n', '<leader>hs', gs.stage_hunk)
  keymap.set('v', '<leader>hs', function()
    gs.stage_hunk({ line('.'), line('v') })
  end)

  keymap.set('n', '<leader>hr', gs.reset_hunk)
  keymap.set('v', '<leader>hr', function()
    gs.reset_hunk({ line('.'), line('v') })
  end)

  keymap.set('n', '<leader>ghS', gs.stage_buffer)
  keymap.set('n', '<leader>ghu', gs.undo_stage_hunk)
  keymap.set('n', '<leader>ghR', gs.reset_buffer)
  keymap.set('n', '<leader>ghp', gs.preview_hunk)
  keymap.set('n', '<leader>gm', function()
    gs.blame_line({ full = true })
  end)
  keymap.set('n', '<leader>gtb', gs.toggle_current_line_blame)

  keymap.set('n', '<leader>ghd', gs.diffthis)
  keymap.set('n', '<leader>hD', function()
    gs.diffthis('~')
  end)

  keymap.set('n', '<leader>ght', gs.toggle_deleted)

  keymap.set('n', '<leader>hQ', function()
    gs.setqflist('all')
  end)
  keymap.set('n', '<leader>hq', function()
    gs.setqflist()
  end)

  keymap.set({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
end

gitsigns.setup({
  debug_mode = true,
  max_file_length = 30000,
  signs = {
    add = {
      show_count = false,
      hl = 'GitGutterAdd',
      text = '▎',
      numhl = 'GitSignsAddNr',
    },
    change = {
      show_count = false,
      hl = 'GitGutterChange',
      text = '▎',
      numhl = 'GitSignsChangeNr',
    },
    delete = {
      show_count = true,
      hl = 'GitGutterDelete',
      text = '_',
      numhl = 'GitSignsDeleteNr',
    },
    topdelete = {
      show_count = true,
      hl = 'GitGutterDelete',
      text = '‾',
      numhl = 'GitSignsDeleteNr',
    },
    changedelete = {
      show_count = true,
      hl = 'GitGutterChange',
      text = '~',
      numhl = 'GitSignsChangeNr',
    },
  },
  on_attach = on_attach,
  preview_config = {
    -- Options passed to nvim_open_win
    border = NvimConfig.ui.float.border,
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1,
  },
  current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_formatter_opts = {
    relative_time = false,
  },
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 700,
    ignore_whitespace = false,
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
  signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
  numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    interval = 700,
    follow_files = true,
  },
  attach_to_untracked = true,
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  yadm = {
    enable = false,
  },
})
