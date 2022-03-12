-- luacheck: max line length 150

local nvim_tree = require('nvim-tree')
local tree_cb = require('nvim-tree/config').nvim_tree_callback
local map = require('utils.map')
local opts = { noremap = true, silent = true }

vim.g.nvim_tree_respect_buf_cwd = 1
-- 0 is supposed to be the default (ie. don't close tree when opening a file),
-- but it closes anyway; see: https://github.com/kyazdani42/nvim-tree.lua/issues/502
vim.g.nvim_tree_quit_on_open = 1

vim.g.nvim_tree_disable_window_picker = 1

-- Only show the current folder as the root instead of full path.
vim.g.nvim_tree_root_folder_modifier = ':t'

-- Highlight nodes according to current git status.
-- vim.g.nvim_tree_git_hl = 1

-- Enable indent markers.
vim.g.nvim_tree_indent_markers = 1

-- Disable special files.
vim.g.nvim_tree_special_files = {
  'README.md',
  'LICENSE',
  'Makefile',
  'package.json',
  'package-lock.json',
}

-- Set whether or not to show certain icons.
vim.g.nvim_tree_show_icons = {
  git = 1,
  folders = 1,
  files = 1,
  folder_arrows = 1,
  lsp = 1,
}

-- Customize icons.
vim.g.nvim_tree_icons = {
  default = '',
  symlink = '',
  git = {
    unstaged = '',
    staged = '',
    unmerged = '',
    renamed = '',
    untracked = '',
    deleted = '',
    ignored = '◌',
  },
  folder = {
    default = '',
    open = '',
    empty = '',
    empty_open = '',
    symlink = '',
    symlink_open = '',
  },
  lsp = {
    hint = '',
    info = '',
    warning = '',
    error = '',
  },
}

nvim_tree.setup({
  -- disables netrw completely
  disable_netrw = false,
  -- hijack netrw window on startup
  hijack_netrw = true,
  -- open the tree when running this setup function
  open_on_setup = false,
  -- will not open on setup if the filetype is in this list
  ignore_ft_on_setup = {},
  -- closes neovim automatically when the tree is the last **WINDOW** in the view
  auto_close = false,
  -- opens the tree when changing/opening a new tab if the tree wasn't previously opened
  open_on_tab = false,
  -- hijacks new directory buffers when they are opened.
  update_to_buf_dir = {
    -- enable the feature
    enable = true,
    -- allow to open the tree if it was previously closed
    auto_open = true,
  },
  -- hijack the cursor in the tree to put it at the start of the filename
  hijack_cursor = false,
  -- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
  update_cwd = false,
  -- show lsp diagnostics in the signcolumn
  diagnostics = {
    enable = false,
    icons = {
      hint = '',
      info = '',
      warning = '',
      error = '',
    },
  },
  -- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
  update_focused_file = {
    -- enables the feature
    enable = true,
    -- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
    -- only relevant when `update_focused_file.enable` is true
    update_cwd = true,
    -- list of buffer names / filetypes that will not update the cwd if the file isn't found under the current root directory
    -- only relevant when `update_focused_file.update_cwd` is true and `update_focused_file.enable` is true
    ignore_list = {},
  },
  -- configuration options for the system open command (`s` in the tree by default)
  system_open = {
    -- the command to run this, leaving nil should work in most cases
    cmd = nil,
    -- the command arguments as a list
    args = {},
  },
  filters = {
    custom = {
      '.DS_Store',
      'fugitive:',
      '.git',
      'node_modules',
      '.cache',
      '__pycache__',
      'DS_Store',
      'bash',
      'bin',
      'tui',
      'vscode',
      'system',
      'spell',
      '4_archive',
      'android',
      'ios',
      '.dart_tool',
      '.idea',
    },
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 500,
  },
  view = {
    -- width of the window, can be either a number (columns) or a string in `%`
    width = 30,
    hide_root_folder = false,
    -- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
    side = 'left',
    -- if true the tree will resize itself after opening a file
    auto_resize = false,
    mappings = {
      -- custom only false will merge the list with the default mappings
      -- if true, it will only use your list to set the mappings
      custom_only = false,
      -- list of mappings to set on the tree manually
      list = {
        { key = { 'l', '<CR>', '<2-LeftMouse>' }, cb = tree_cb('edit') },
        { key = 'L', cb = tree_cb('cd') },
        { key = '<C-s>', cb = tree_cb('split') },
        { key = '<C-v>', cb = tree_cb('vsplit') },
        { key = '<C-t>', cb = tree_cb('tabnew') },
        { key = 'h', cb = tree_cb('close_node') },
        { key = 'i', cb = tree_cb('preview') },
        { key = 'R', cb = tree_cb('refresh') },
        { key = 'c', cb = tree_cb('create') },
        { key = 'D', cb = tree_cb('remove') },
        { key = 'r', cb = tree_cb('rename') },
        { key = '<C-r>', cb = tree_cb('full_rename') },
        { key = 'd', cb = tree_cb('cut') },
        { key = 'y', cb = tree_cb('copy') },
        { key = 'p', cb = tree_cb('paste') },
        { key = 'gyn', cb = tree_cb('copy_name') },
        { key = 'gyp', cb = tree_cb('copy_path') },
        { key = 'gya', cb = tree_cb('copy_absolute_path') },
        { key = '[c', cb = tree_cb('prev_git_item') },
        { key = ']c', cb = tree_cb('next_git_item') },
        { key = 'H', cb = tree_cb('dir_up') },
        { key = 's', cb = tree_cb('system_open') },
        { key = 'q', cb = tree_cb('close') },
        { key = 'g?', cb = tree_cb('toggle_help') },
        { key = 'I', cb = tree_cb('toggle_ignored') },
      },
    },
    number = true,
    relativenumber = true,
  },
  trash = {
    cmd = 'trash',
    require_confirm = true,
  },
})

map.nnoremap('<leader>f', '<Cmd>NvimTreeToggle<CR>', opts)
map.nnoremap('<leader>F', '<Cmd>NvimTreeFindFile<CR>z.', opts)
