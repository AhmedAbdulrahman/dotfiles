-- 🔭 Navigating (Telescope/Tree/Refactor)

local icons = NvimConfig.icons

local git_icons = {
  added = icons.git.Add,
  changed = icons.git.Diff,
  copied = '>',
  deleted = icons.git.Remove,
  renamed = '➡',
  unmerged = '‡',
  untracked = '?',
}
-- https://github.com/nvim-telescope/telescope.nvim/issues/1048
local telescope_custom_actions = {}

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

return {
  {
    "nvim-telescope/telescope.nvim",
    config = function()
      local actions = require('telescope.actions')
      local action_state = require('telescope.actions.state')
      local utils = require('telescope.utils')
      local command_palette = require('plugins.telescope.command_palette')
      require('telescope').setup {
        defaults = {
          preview = {
            timeout = 500,
            msg_bg_fillchar = '',
          },
          border            = true,
          hl_result_eol     = true,
          multi_icon        = '',
          vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '--hidden',
            '--trim', -- add this value to remove whitespace from the beginning of the line
          },
          layout_config     = {
            vertical = {
              preview_cutoff = 120,
            },
            prompt_position = "top",
          },
          pickers = {
            find_files = {
              theme = "dropdown",
              find_command = {
                "fd",
                "--type",
                "f",
                "--no-ignore",
                "--hidden",
                "--strip-cwd-prefix",
                "--exclude",
                "**/.git/*",
              },
            },
            live_grep = {
              glob_pattern = {
                "!.git/*",
              },
              additional_args = {
                "--no-ignore",
                "--hidden",
              },
            },
          },
          file_sorter       = require('telescope.sorters').get_fzy_sorter,
          prompt_prefix     = ' 🔍 ',
          selection_caret = '❯ ',
          path_display = { "smart" },
          color_devicons    = true,
          git_icons         = git_icons,
          sorting_strategy  = "ascending",
          dynamic_preview_title = true,
          winblend = 4,
          file_previewer    = require('telescope.previewers').vim_buffer_cat.new,
          grep_previewer    = require('telescope.previewers').vim_buffer_vimgrep.new,
          qflist_previewer  = require('telescope.previewers').vim_buffer_qflist.new,
          mappings          = {
            i = {
              ["<C-x>"] = false,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
              ["<C-s>"] = actions.cycle_previewers_next,
              ["<C-a>"] = actions.cycle_previewers_prev,
              ["<C-d>"] = actions.delete_buffer,
              -- ["<C-h>"] = "which_key",
              ["<ESC>"] = actions.close,
            },
            n = {
              ["<C-s>"] = actions.cycle_previewers_next,
              ["<C-a>"] = actions.cycle_previewers_prev,
            }
          }
        },
        extensions = {
          fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = false,
            override_file_sorter = true,
            case_mode = "smart_case", -- this is default
          },
          file_browser = {
            hidden = true,
          },
          ['ui-select'] = {
            require('telescope.themes').get_cursor(),
            require('telescope.themes').get_dropdown {
              layout_config = {
                width = 0.8,
                height = 0.8,
              }
            },
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
        }
      }

      require('plugins.telescope.mappings')

      -- Telescope 🔭 - setup and customized pickers
      require('telescope').load_extension('fzf')
      require('telescope').load_extension('repo')
      require("telescope").load_extension("git_worktree")
      require("telescope").load_extension("media_files")
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

    end,
    dependencies = {
      { "nvim-lua/popup.nvim" },
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      { "cljoly/telescope-repo.nvim" },
      { 'nvim-telescope/telescope-file-browser.nvim' },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'LinArcX/telescope-command-palette.nvim' },
      { 'nvim-telescope/telescope-github.nvim' },
      { 'jvgrootveld/telescope-zoxide' },
      { 'nvim-telescope/telescope-media-files.nvim' }
    },
    cmd = "Telescope",
    keys = {
      { "<C-p>",      "<CMD>lua require('plugins.telescope.pickers').project_files()<CR>" },
      { "<S-p>",      "<CMD>lua require('plugins.telescope.multi-rg')()<CR>" },
      { "<Leader>pf", "<CMD>lua require('plugins.telescope.pickers').project_files({ default_text = vim.fn.expand('<cword>'), initial_mode = 'normal' })<CR>" },
      { "<Leader>pw", "<CMD>lua require('telescope.builtin').grep_string({ initial_mode = 'normal' })<CR>" }
    }
  },
  {
    'dhruvmanila/browser-bookmarks.nvim',
    version = '*',
    -- Only required to override the default options
    opts = {
      selected_browser = 'chrome',
      url_open_command = 'open',
    },
    dependencies = {
      -- Only if your selected browser is Firefox, Waterfox or buku
      -- 'kkharji/sqlite.lua',

      -- Only if you're using the Telescope extension
      'nvim-telescope/telescope.nvim',
    }
  }
}
