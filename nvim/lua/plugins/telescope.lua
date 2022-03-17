local actions = require('telescope.actions')

local function setup()
  require('telescope').setup({
    defaults = {
      preview = false,
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
        preview_cutoff = 20,
      },
      file_sorter = require('telescope.sorters').get_fzy_sorter,
      prompt_prefix = ' 🔍 ',
      color_devicons = true,

      sorting_strategy = 'ascending',
      winblend = 15,
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
          ['<C-q>'] = actions.send_selected_to_qflist,
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
        override_generic_sorter = false, -- Causes crashes
        override_file_sorter = true,
        case_mode = 'smart_case',
      },
    },
  })
  require('telescope').load_extension('fzf')
  require('telescope').load_extension('ui-select')
  setup = nil
end

local keymap = function(key, fun, opts)
  vim.api.nvim_set_keymap('n', key, '', {
    desc = 'Telescope ' .. fun .. vim.inspect(
      opts or '',
      { newline = '', indent = '' }
    ),
    callback = function()
      if setup then
        setup()
      end
      require('telescope.builtin')[fun](opts)
    end,
    noremap = true,
    silent = true,
  })
end

-- default: CTRL-B   scroll N screens Backwards
keymap('<C-b>', 'buffers')

-- default:  CTRL-P same as "k"
keymap('<C-p>', 'git_files', { preview = true, use_git_root = true })

-- default: none
keymap(
  '<C- >',
  'git_files',
  { preview = true, cwd = '$HOME/dotfiles', hidden = true }
)

keymap('<leader><TAB>', 'find_files')
keymap('<leader>/', 'live_grep', { preview = true })

-- Find word/file across project
keymap('<leader>pf', 'grep_string', { preview = true })
