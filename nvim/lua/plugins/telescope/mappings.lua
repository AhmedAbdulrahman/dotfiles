local telescope = require('telescope')
local themes = require('telescope.themes')
local builtin = require('telescope.builtin')
local dropdown_theme = themes.get_dropdown()

local keymap = vim.keymap
local silent = { silent = true }

-- TELESCOPE keymaps 🔭 --
-- command palette
keymap.set(
  'n',
  '<leader>cp',
  function()
    telescope.extensions.command_palette.command_palette()
  end,
  silent
)
-- open available commands & run it
keymap.set(
  'n',
  ',c',
  function()
    builtin.commands({
      results_title = 'Commands Results',
      prompt_title = 'Search Commands',
    })
  end,
  silent
)
-- telescope notify history
keymap.set(
  'n',
  '<leader>nh',
  function()
    telescope.extensions.notify.notify({
      results_title='Notification History',
      prompt_title='Search Messages'
    })
  end,
  silent
)
-- show Workspace Diagnostics
keymap.set(
  'n',
  ',d',
  function()
    builtin.diagnostics()
  end,
  silent
)
-- Telescope oldfiles
keymap.set(
  'n',
  '<leader>?',
  function()
    builtin.oldfiles({
      results_title = '[?] Find recently opened files',
    })
  end,
  silent
)
-- Telescope resume (last picker)
keymap.set(
  'n',
  '<leader>tr',
  function()
    builtin.resume()
  end,
  silent
)

-- LSP!
-- show LSP implementations
keymap.set(
  'n',
  '<leader>ti',
  function()
    builtin.lsp_implementations()
  end,
  silent
)
keymap.set(
  'n',
  '<leader>w',
  function()
    builtin.lsp_references(dropdown_theme)
  end,
  silent
)
-- show LSP definitions
keymap.set(
  'n',
  '<leader>td',
  function()
    builtin.lsp_definitions({
      layout_config = {
        preview_width = 0.50,
        width = 0.92,
      },
      path_display = {
        'shorten',
      },
      results_title = 'Definitions',
    })
  end,
  silent
)
-- show DOCUMENT Symbols
keymap.set(
  'n',
  ',ws',
  function()
    builtin.lsp_document_symbols()
  end,
  silent
)

-- Github
-- issues
keymap.set(
  'n',
  '<leader>is',
  function()
    require'plugins.telescope'.gh_issues()
  end,
  silent
)
-- Pull Requests - PRs
keymap.set(
  'n',
  '<leader>pl',
  function()
    require'plugins.telescope'.gh_prs()
  end,
  silent
)
-- telescope-repo
keymap.set(
  'n',
  '<leader>rl',
  function()
    require'plugins.telescope'.repo_list()
  end,
  silent
)
-- git telescope goodness
-- git_branches
keymap.set(
  'n',
  '<leader>gb',
  function()
    builtin.git_branches({
      prompt_title = '',
      results_title = 'Git Branches',
    })
  end,
  {
    noremap = true,
    silent = true,
  }
)
-- git_bcommits - file scoped commits with diff preview. <C-V> for vsp diff to parent
keymap.set(
  'n',
  '<leader>gfc',
  function()
    builtin.git_bcommits({
      prompt_title = '  ',
      results_title = 'Git File Commits',
    })
  end,
  silent
)
-- git_commits (log) git log
keymap.set(
  'n',
  '<leader>gc',
  function()
    builtin.git_commits()
  end,
  silent
)
-- git_status - <tab> to toggle staging
keymap.set(
  'n',
  '<leader>gs',
  function()
    builtin.git_status()
  end,
  silent
)

-- Find registers
keymap.set(
  'n',
  '<leader>r',
  function()
    builtin.registers()
  end,
  silent
)
-- Find current buffer
keymap.set(
  'n',
  ',bf',
  function()
    builtin.current_buffer_fuzzy_find()
  end,
  silent
)
-- Find keymaps
keymap.set(
  'n',
  ',k',
  function()
    builtin.keymaps({
      results_title = 'Key Maps Results',
    })
  end,
  silent
)
-- Find buffers
keymap.set(
  'n',
  ',b',
  function()
    builtin.buffers({
      results_title='[ ] Find existing buffers',
      winblend = 3,
      layout_strategy = 'vertical',
      layout_config = {
        width = 0.60,
        height = 0.55
      }
    })
  end,
  silent
)
-- Find help tags
keymap.set(
  'n',
  '<leader>h',
  function()
    builtin.help_tags({
      results_title = '[!] Help Tags',
    })
  end,
  silent
)
-- Find marks
keymap.set(
  'n',
  '<leader>m',
  function()
    builtin.marks({
      results_title = '[⏹] Marks',
    })
  end,
  silent
)

-- Find files with gitfiles & fallback on find_files
keymap.set(
  'n',
  '<leader><TAB>',
  function()
    require'plugins.telescope'.project_files()
  end,
  silent
)
-- Find files including gitignored
keymap.set(
  'n',
  ',<leader>',
  function()
    builtin.find_files({ find_command={'fd','--no-ignore-vcs'} })
  end,
  silent
)

-- Explore files starting at $HOME
keymap.set(
  'n',
  '<leader>e',
  function()
    require'plugins.telescope'.file_browser()
  end,
  silent
)
-- Browse files from cwd - File Browser
keymap.set(
  'n',
  '<leader>fb',
  function()
    telescope.extensions.file_browser.file_browser()
  end,
  silent
)
-- Grep word under cursor
-- keymap.set(
--   'n',
--   '<leader>g',
--   [[<Cmd>lua require'telescope.builtin'.grep_string()<CR>]],
--   silent
-- )
-- Grep word under cursor - case-sensitive (exact word) - made for use with Replace All - see <leader>ra
keymap.set(
  'n',
  '<leader>gw',
  function()
    builtin.grep_string({
      word_match = '-w',
    })
  end,
  silent
)
-- Grep for a string
keymap.set(
  'n',
  '<leader>gp',
  function()
    require'plugins.telescope'.grep_prompt()
  end,
  silent
)

-- Multi grep
keymap.set(
  'n',
  '<leader>/',
  function()
    require'plugins.telescope'.pickers.multi_rg()
  end,
  silent
)

-- Grep open files
keymap.set(
  'n',
  '<leader>lg',
  function()
    builtin.live_grep({
      grep_open_files = true,
      preview = true,
    })
  end,
  silent
)

-- Find files in config dirs
keymap.set(
  'n',
  '<leader>fc',
  function()
    require'plugins.telescope'.find_configs()
  end,
  silent
)
-- find or create neovim configs
keymap.set(
  'n',
  '<leader>nc',
  function()
    require'plugins.telescope'.nvim_config()
  end,
  silent
)

-- neoclip
keymap.set(
  'n',
  '<leader>ce',
  function()
    telescope.extensions.neoclip.default()
  end,
  silent
)
