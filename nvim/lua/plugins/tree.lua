-- luacheck: max line length 150

local map = require('utils.map')
local opts = { noremap = true, silent = true }

vim.g.nvim_tree_respect_buf_cwd = 1

-- Only show the current folder as the root instead of full path.
vim.g.nvim_tree_root_folder_modifier = ':t'

-- Highlight nodes according to current git status.
-- vim.g.nvim_tree_git_hl = 1

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

local keymappings = {
  { key = { '<CR>', 'o', '<2-LeftMouse>' }, action = 'edit' },
  { key = '<C-e>', action = 'edit_in_place' },
  { key = { 'O' }, action = 'edit_no_picker' },
  { key = { '<2-RightMouse>', '<C-]>' }, action = 'cd' },
  { key = '<C-v>', action = 'vsplit' },
  { key = '<C-x>', action = 'split' },
  { key = '<C-t>', action = 'tabnew' },
  { key = '<', action = 'prev_sibling' },
  { key = '>', action = 'next_sibling' },
  { key = 'P', action = 'parent_node' },
  { key = '<BS>', action = 'close_node' },
  { key = '<Tab>', action = 'preview' },
  { key = 'K', action = 'first_sibling' },
  { key = 'J', action = 'last_sibling' },
  { key = 'I', action = 'toggle_ignored' },
  { key = 'H', action = 'toggle_dotfiles' },
  { key = 'R', action = 'refresh' },
  { key = 'a', action = 'create' },
  { key = 'd', action = 'remove' },
  { key = 'D', action = 'trash' },
  { key = 'r', action = 'rename' },
  { key = '<C-r>', action = 'full_rename' },
  { key = 'x', action = 'cut' },
  { key = 'c', action = 'copy' },
  { key = 'p', action = 'paste' },
  { key = 'y', action = 'copy_name' },
  { key = 'Y', action = 'copy_path' },
  { key = 'gy', action = 'copy_absolute_path' },
  { key = '[c', action = 'prev_git_item' },
  { key = ']c', action = 'next_git_item' },
  { key = '-', action = 'dir_up' },
  { key = 's', action = 'system_open' },
  { key = 'q', action = 'close' },
  { key = 'g?', action = 'toggle_help' },
  { key = 'W', action = 'collapse_all' },
  { key = 'S', action = 'search_node' },
}

require('nvim-tree').setup({
  -- disables netrw completely
  disable_netrw = false,
  -- hijack netrw window on startup
  hijack_netrw = true,
  -- open the tree when running this setup function
  open_on_setup = false,
  -- will not open on setup if the filetype is in this list
  ignore_ft_on_setup = {},
  -- opens the tree when changing/opening a new tab if the tree wasn't previously opened
  open_on_tab = false,
  -- hijack the cursor in the tree to put it at the start of the filename
  hijack_cursor = false,
  -- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
  update_cwd = true,
  -- opens in place of the unnamed buffer if it's empty
  hijack_unnamed_buffer_when_opening = false,
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
    -- auto_resize = false, unknown option
    mappings = {
      -- custom only false will merge the list with the default mappings
      -- if true, it will only use your list to set the mappings
      custom_only = true,
      -- list of mappings to set on the tree manually
      list = keymappings,
    },
    number = true,
    relativenumber = true,
  },
  trash = {
    cmd = 'trash',
    require_confirm = true,
  },
  actions = {
    open_file = {
      quit_on_open = true,
    },
  },
   renderer = {
	indent_markers = {
		enable = true, -- Enable indent markers
	  },
   }
})

map.nnoremap('<leader>f', '<Cmd>NvimTreeToggle<CR>', opts)
map.nnoremap('<leader>F', '<Cmd>NvimTreeFindFile<CR>z.', opts)
