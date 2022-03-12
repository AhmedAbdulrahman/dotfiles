local map = require('utils.map')

require('gitsigns').setup({
  signs = {
    add = { hl = 'GitGutterAdd', text = '│', numhl = 'GitSignsAddNr' },
    change = { hl = 'GitGutterChange', text = '│', numhl = 'GitSignsChangeNr' },
    delete = { hl = 'GitGutterDelete', text = '_', numhl = 'GitSignsDeleteNr' },
    topdelete = {
      hl = 'GitGutterDelete',
      text = '‾',
      numhl = 'GitSignsDeleteNr',
    },
    changedelete = {
      hl = 'GitGutterChange',
      text = '~',
      numhl = 'GitSignsChangeNr',
    },
  },
  signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
  numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    interval = 700,
    follow_files = true,
  },
  attach_to_untracked = true,
  current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 700,
    ignore_whitespace = false,
  },
  current_line_blame_formatter_opts = {
    relative_time = false,
  },
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000,
  preview_config = {
    -- Options passed to nvim_open_win
    border = NvimConfig.ui.float.border,
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1,
  },
  use_internal_diff = true, -- If vim.diff or luajit is present
  yadm = {
    enable = false,
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    -- Navigation
    map.nnoremap(']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'")
    map.nnoremap('[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'")

    -- Actions
    map.nnoremap('<leader>ghs', gs.stage_hunk)
    map.vnoremap('<leader>ghs', gs.stage_hunk)
    map.nnoremap('<leader>ghr', gs.reset_hunk)
    map.vnoremap('<leader>ghr', gs.reset_hunk)
    map.nnoremap('<leader>ghS', gs.stage_buffer)
    map.nnoremap('<leader>ghu', gs.undo_stage_hunk)
    map.nnoremap('<leader>ghR', gs.reset_buffer)
    map.nnoremap('<leader>ghp', gs.preview_hunk)
    map.nnoremap('<leader>gm', function()
      gs.blame_line({ full = true })
    end)
    map.nnoremap('<leader>ghd', gs.diffthis)
    map.nnoremap('<leader>ght', gs.toggle_deleted)

    -- Text object
    map.onoremap('ih', ':<C-U>Gitsigns select_hunk<CR>')
    map.xnoremap('ih', ':<C-U>Gitsigns select_hunk<CR>')
  end,
})
