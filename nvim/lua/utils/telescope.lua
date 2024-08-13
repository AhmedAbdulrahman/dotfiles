-- my telescopic customizations

local utils = require('telescope.utils')

local function get_workspace_folder ()
  return vim.lsp.buf.list_workspace_folders()[1] or vim.fn.systemlist('git rev-parse --show-toplevel')[1]
end

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
