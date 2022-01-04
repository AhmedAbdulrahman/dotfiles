local actions = require('telescope.actions')
local previewers = require('telescope.previewers')
local builtin = require('telescope.builtin')
local map = require('utils.map')
local opts = { noremap = true, silent = true }

require('telescope').setup({
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
    },
    borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
    layout_config = {
      horizontal = {
        width = 0.8,
        height = 0.8,
        preview_width = 0.6,
      },
      vertical = {
        height = 0.8,
        preview_height = 0.5,
      },
      prompt_position = 'top',
    },
    file_sorter = require('telescope.sorters').get_fzy_sorter,
    prompt_prefix = ' 🔍 ',
    color_devicons = true,

    sorting_strategy = 'ascending',
    scroll_strategy = 'cycle',
    selection_strategy = 'reset',
    layout_strategy = 'flex',

    file_previewer = require('telescope.previewers').vim_buffer_cat.new,
    grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
    qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,

    mappings = {
      i = {
        ['<C-x>'] = false,
        ['<C-j>'] = actions.move_selection_next,
        ['<C-k>'] = actions.move_selection_previous,
        ['<C-q>'] = actions.send_to_qflist,
        ['<C-s>'] = actions.cycle_previewers_next,
        ['<C-a>'] = actions.cycle_previewers_prev,
      },
      n = {
        ['<C-s>'] = actions.cycle_previewers_next,
        ['<C-a>'] = actions.cycle_previewers_prev,
      },
    },
  },
  pickers = {
    grep_string = {
      file_ignore_patterns = {
        '%.png',
        '%.jpg',
        '%.webp',
        'node_modules',
        '.yalc',
        '*%.min%.*',
        'dotbot',
        'LICENSE.txt',
      },
    },
    find_files = {
      file_ignore_patterns = {
        '%.png',
        '%.jpg',
        '%.webp',
        'node_modules',
        '.yalc',
        '*%.min%.*',
        'dotbot',
        'LICENSE.txt',
      },
    },
  },
  extensions = {
    fzf = {
      override_generic_sorter = false,
      override_file_sorter = true,
      case_mode = 'smart_case',
    },
  },
})

require('telescope').load_extension('fzf')
require('telescope').load_extension('repo')

map.nnoremap(
  '<Leader><TAB>',
  "<CMD>lua require('plugins.telescope').project_files()<CR>",
  { noremap = true }
)
map.nnoremap('<Leader>/', '<CMD>Telescope live_grep<CR>', { noremap = true })

-- Find word/file across project
map.nnoremap(
  '<Leader>pf',
  'yiw<CMD>Telescope git_files<CR><C-r>+<ESC>',
  { noremap = true }
)
map.nnoremap(
  '<Leader>pw',
  '<CMD>Telescope grep_string<CR><ESC>',
  { noremap = true }
)

-- Git
map.nnoremap(
  '<Leader>gla',
  "<CMD>lua require('plugins.telescope').my_git_commits()<CR>",
  opts
)
map.nnoremap(
  '<Leader>glc',
  "<CMD>lua require('plugins.telescope').my_git_bcommits()<CR>",
  opts
)

-- Implement delta as previewer for diffs

local M = {}

local delta_bcommits = previewers.new_termopen_previewer({
  get_command = function(entry)
    return {
      'git',
      '-c',
      'core.pager=delta',
      '-c',
      'delta.side-by-side=false',
      'diff',
      entry.value .. '^!',
      '--',
      entry.current_file,
    }
  end,
})

local delta = previewers.new_termopen_previewer({
  get_command = function(entry)
    return {
      'git',
      '-c',
      'core.pager=delta',
      '-c',
      'delta.side-by-side=false',
      'diff',
      entry.value .. '^!',
    }
  end,
})

M.my_git_commits = function(opts)
  opts = opts or {}
  opts.previewer = {
    delta,
    previewers.git_commit_message.new(opts),
    previewers.git_commit_diff_as_was.new(opts),
  }

  builtin.git_commits(opts)
end

M.my_git_bcommits = function(opts)
  opts = opts or {}
  opts.previewer = {
    delta_bcommits,
    previewers.git_commit_message.new(opts),
    previewers.git_commit_diff_as_was.new(opts),
  }

  builtin.git_bcommits(opts)
end

M.edit_neovim = function()
  builtin.git_files({
    cwd = '~/.config/nvim',
    prompt = '~ dotfiles ~',
    color_devicons = true,
    sorting_strategy = 'ascending',
    layout_config = {
      horizontal = {
        mirror = false,
      },
      vertical = {
        mirror = false,
      },
      prompt_position = 'top',
    },
  })
end

M.grep_prompt = function()
  require('telescope.builtin').grep_string({
    path_display = { 'shorten' },
    search = vim.fn.input('Grep String > '),
    only_sort_text = true,
    use_regex = true,
  })
end

M.npm_script = function()
  telescope.extensions.npm.scripts(M.no_preview())
end

M.npm_packages = function()
  telescope.extensions.npm.packages(M.no_preview())
end

M.project_files = function()
  local opts = {} -- define here if you want to define something
  local ok = pcall(require('telescope.builtin').git_files, opts)
  if not ok then
    require('telescope.builtin').find_files(opts)
  end
end

return M
