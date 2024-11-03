local previewers = require('telescope.previewers')
local builtin    = require('telescope.builtin')

-- Implement delta as previewer for diffs

local M = {}

local delta_bcommits = previewers.new_termopen_previewer {
  get_command = function(entry)
    return { 'git', '-c', 'core.pager=delta', '-c', 'delta.side-by-side=false', 'diff', entry.value .. '^!', '--',
      entry.current_file }
  end
}

local delta = previewers.new_termopen_previewer {
  get_command = function(entry)
    return { 'git', '-c', 'core.pager=delta', '-c', 'delta.side-by-side=false', 'diff', entry.value .. '^!' }
  end
}

local function get_workspace_folder ()
  return vim.lsp.buf.list_workspace_folders()[1] or vim.fn.systemlist('git rev-parse --show-toplevel')[1]
end

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

-- Custom pickers

-- find or create configs
M.edit_dotfiles = function()
  builtin.git_files(
    require('telescope.themes').get_dropdown({
      color_devicons   = true,
      cwd              = "~/dotfiles", -- start in dotfiles dir
      previewer        = false,
      prompt_title     = '~ dotfiles ~',
      sorting_strategy = "ascending",
      winblend         = 4,
      layout_config    = {
        horizontal = {
          mirror = false,
        },
        vertical = {
          mirror = false,
        },
        prompt_position = "top",
      },
    }))
end

M.project_files = function(opts)
  opts = opts or {
    cwd = get_workspace_folder(),
    hidden = true,
    file_ignore_patterns = {
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
    },

  } -- define here if you want to define something
  local ok = pcall(require "telescope.builtin".git_files, {
    prompt_title   = ' Find',
    prompt_prefix  = '  ',
    results_title  = ' Repo Files',
    show_untracked = true,
  })

  if not ok then require "telescope.builtin".find_files(opts) end
end

M.command_history = function()
  builtin.command_history(
    require('telescope.themes').get_dropdown({
      color_devicons = true,
      winblend       = 4,
      layout_config  = {
        width = function(_, max_columns, _)
          return math.min(max_columns, 150)
        end,
        height = function(_, _, max_lines)
          return math.min(max_lines, 15)
        end,
      },
    }))
end

M.buffer_search = function()
  builtin.buffers(
    require('telescope.themes').get_dropdown({
      sort_mru       = true,
      sort_lastused  = true,
      previewer      = false,
      color_devicons = true,
      winblend       = 4,
      layout_config  = {
        width = function(_, max_columns, _)
          return math.min(max_columns, 100)
        end,
        height = function(_, _, max_lines)
          return math.min(max_lines, 15)
        end,
      },
    }))
end

return M
