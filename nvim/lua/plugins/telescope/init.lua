-- Telescope 🔭 - setup and customized pickers

local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

telescope.load_extension("media_files")

require('plugins.telescope.mappings')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local utils = require('telescope.utils')
local command_palette = require('plugins.telescope.command_palette')
local icons = NvimConfig.icons

-- https://github.com/nvim-telescope/telescope.nvim/issues/1048
local telescope_custom_actions = {}

local git_icons = {
  added = icons.git.Add,
  changed = icons.git.Diff,
  copied = '>',
  deleted = icons.git.Remove,
  renamed = '➡',
  unmerged = '‡',
  untracked = '?',
}

function telescope_custom_actions._multiopen(prompt_bufnr, open_cmd)
  local picker = action_state.get_current_picker(prompt_bufnr)
  local num_selections = #picker:get_multi_selection()
  if not num_selections or num_selections <= 1 then
    actions.add_selection(prompt_bufnr)
  end
  actions.send_selected_to_qflist(prompt_bufnr)
  vim.cmd('cfdo ' .. open_cmd)
end

function telescope_custom_actions.multi_selection_open(prompt_bufnr)
  telescope_custom_actions._multiopen(prompt_bufnr, 'edit')
end

function get_workspace_folder ()
  return vim.lsp.buf.list_workspace_folders()[1] or vim.fn.systemlist('git rev-parse --show-toplevel')[1]
end

-- @TODOUA: create a git history keyword search picker
-- @TODOUA: add action to commits pickers to yank commit hash

require('telescope').setup({
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = 'smart_case', -- this is default
    },
    file_browser = {
      hidden = true,
    },
    ['ui-select'] = {
      require('telescope.themes').get_cursor(),
    },
    bookmarks = {
      selected_browser = 'chrome',
      url_open_command = 'open',
    },
    extensions = {
      media_files = {
        -- filetypes whitelist
        -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
        filetypes = { "png", "webp", "jpg", "jpeg", "mp4", "pdf"},
        find_cmd = "rg", -- find command (defaults to `fd`)
      },
      zoxide = {
        ['<CR>'] = {
          keepinsert = true,
          action = function(selection)
            require('telescope').extensions.file_browser.file_browser { cwb = selection.path }
          end
        },
      },
      -- Your extension configuration goes here:
      -- extension_name = {
      --   extension_config_key = value,
      -- }
      -- please take a look at the readme of the extension you want to configure
    },
    command_palette = command_palette,
  },
  defaults = {
    preview = {
      timeout = 500,
      msg_bg_fillchar = '',
    },
    multi_icon = ' ',
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--hidden',
    },
    prompt_prefix = ' 🔍 ',
    selection_caret = '❯ ',
    path_display = { "smart" },
    sorting_strategy = 'ascending',
    color_devicons = true,
    git_icons = git_icons,
    layout_config = {
      horizontal = {
        prompt_position = 'top',
        width_padding = 0.04,
        height_padding = 0.1,
        preview_width = 0.6,
      },
      vertical = {
        width_padding = 0.05,
        height_padding = 1,
        preview_height = 0.5,
      },
    },

    -- using custom temp multi-select maps
    -- https://github.com/nvim-telescope/telescope.nvim/issues/1048
    mappings = {
      n = {
        ["<esc>"] = actions.close,

        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,
        ['<M-q>'] = telescope_custom_actions.multi_selection_open,
        ['<C-s>'] = actions.cycle_previewers_next,
        ['<C-a>'] = actions.cycle_previewers_prev,

        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,

        ["j"] = actions.move_selection_next,
        ["k"] = actions.move_selection_previous,
        ["H"] = actions.move_to_top,
        ["M"] = actions.move_to_middle,
        ["L"] = actions.move_to_bottom,

        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,
        ["gg"] = actions.move_to_top,
        ["G"] = actions.move_to_bottom,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,

        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,

        ["?"] = actions.which_key,
      },
      i = {
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,

        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,

        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,

        ["<C-c>"] = actions.close,

        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,

        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,

        ['<M-q>'] = telescope_custom_actions.multi_selection_open,

        ['<C-q>'] = actions.smart_send_to_qflist + actions.open_qflist,
        ['<C-s>'] = actions.cycle_previewers_next,
        ['<C-a>'] = actions.cycle_previewers_prev,

        ["<C-l>"] = actions.complete_tag,
        ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
      },
    },
    dynamic_preview_title = true,
    winblend = 4,
  },
})

-- 🔭 Extensions --
-- https://github.com/nvim-telescope/telescope-file-browser.nvim
require('telescope').load_extension('file_browser')
-- https://github.com/nvim-telescope/telescope-ui-select.nvim
require('telescope').load_extension('ui-select')
-- https://github.com/nvim-telescope/telescope-fzf-native.nvim#telescope-fzf-nativenvim
require('telescope').load_extension('fzf')
-- https://github.com/LinArcX/telescope-command-palette.nvim
require('telescope').load_extension('command_palette')
-- https://github.com/dhruvmanila/telescope-bookmarks.nvim
-- <space>b
require('telescope').load_extension('bookmarks')

-- https://github.com/jvgrootveld/telescope-zoxide
-- <leader>z
require('telescope').load_extension('zoxide')

-- https://github.com/cljoly/telescope-repo.nvim
-- <leader>rl
-- require('telescope').load_extension('repo')

-- https://github.com/AckslD/nvim-neoclip.lua
-- <C-n>
require('telescope').load_extension('neoclip')

-- GitHub CLI → local version
require('telescope').load_extension('gh')

require('telescope').load_extension('zoxide')

-- my telescopic customizations
local M = {}

-- requires repo extension
M.repo_list = function()
  local opts = {}
  opts.prompt_title = ' Repos'
  require('telescope').extensions.repo.list(opts)
end

-- requires GitHub extension
M.gh_issues = function()
  local opts = {}
  opts.prompt_title = ' Issues'
  require('telescope').extensions.gh.issues(opts)
end

M.gh_prs = function()
  local opts = {}
  opts.prompt_title = ' Pull Requests'
  require('telescope').extensions.gh.pull_request(opts)
end

-- grep_string pre-filtered from grep_prompt
local function grep_filtered(opts)
  opts = opts or {}
  require('telescope.builtin').grep_string({
    path_display = { 'smart' },
    search = opts.filter_word or '',
  })
end

-- open vim.ui.input dressing prompt for initial filter
M.grep_prompt = function()
  vim.ui.input({ prompt = 'Rg ' }, function(input)
    grep_filtered({ filter_word = input })
  end)
end

-- search Neovim related todos
M.search_todos = function()
  require('telescope.builtin').grep_string({
    prompt_title = ' Search TODOUAs',
    prompt_prefix = ' ',
    results_title = 'Neovim TODOUAs',
    path_display = { 'smart' },
    search = 'TODOUA',
  })
end

M.project_files = function()
  local _, ret, _ = utils.get_os_command_output({
    'git',
    'rev-parse',
    '--is-inside-work-tree',
  })

  local gopts = {}
  local fopts = {}

  gopts.prompt_title = ' Find'
  gopts.prompt_prefix = '  '
  gopts.results_title = ' Repo Files'
  gopts.show_untracked = true

  fopts.hidden = true
  fopts.file_ignore_patterns = {
    '.vim/',
    '.local/',
    '.cache/',
    'Downloads/',
    '.git/',
    'Dropbox/.*',
    'Library/.*',
    '.rustup/.*',
    'Movies/',
    '.cargo/registry/',
  }

  fopts.cwd = get_workspace_folder()

  if ret == 0 then
    require('telescope.builtin').git_files(gopts)
  else
    fopts.results_title = 'CWD: ' .. vim.fn.getcwd()
    require('telescope.builtin').find_files(fopts)
  end
end

-- @TODOUA: break up notes and configs
M.grep_notes = function()
  local opts = {}
  opts.hidden = true
  opts.search_dirs = {
    vim.env.NOTES_DIR,
  }
  opts.prompt_prefix = '   '
  opts.prompt_title = ' Grep Notes'
  opts.path_display = { 'smart' }
  require('telescope.builtin').live_grep(opts)
end

M.find_notes = function()
  require('telescope.builtin').find_files({
    prompt_title = ' Find Notes',
    path_display = { 'smart' },
    cwd = '~/Documents/notes/',
    layout_strategy = 'horizontal',
    layout_config = { preview_width = 0.65, width = 0.75 },
  })
end

M.browse_notes = function()
  require('telescope').extensions.file_browser.file_browser({
    prompt_title = ' Browse Notes',
    prompt_prefix = ' ﮷ ',
    cwd = '~/Documents/notes/',
    layout_strategy = 'horizontal',
    layout_config = { preview_width = 0.65, width = 0.75 },
  })
end

M.find_configs = function()
  require('telescope.builtin').find_files({
    prompt_title = ' NVim & Term Config Find',
    results_title = 'Config Files Results',
    path_display = { 'smart' },
    search_dirs = {
      '~/.oh-my-zsh/custom',
      '~/.config/nvim',
      '~/.config/alacritty',
    },
    -- cwd = "~/.config/nvim/",
    layout_strategy = 'horizontal',
    layout_config = { preview_width = 0.65, width = 0.75 },
  })
end

M.edit_dotfiles = function()
  require('telescope.builtin').git_files({
    cwd = '~/dotfiles',
    prompt_title = '~ dotfiles ~',
    color_devicons = true,
    layout_strategy = 'horizontal',
    layout_config = { preview_width = 0.65, width = 0.75 },
  })
end

M.file_explorer = function()
  require('telescope').extensions.file_browser.file_browser({
    prompt_title = ' File Browser',
    path_display = { 'smart' },
    cwd = '~',
    layout_strategy = 'horizontal',
    layout_config = { preview_width = 0.65, width = 0.75 },
  })
end

return M
