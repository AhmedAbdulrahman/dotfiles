-- my telescopic customizations

local utils = require('telescope.utils')

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


return M
