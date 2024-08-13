return {
  {
    'sidebar-nvim/sidebar.nvim',
    config = function()
      local status_ok, sidebar = pcall(require, 'sidebar-nvim')
      local keymap = vim.keymap
      local lazy = require('utils').lazy
      local tree_width = require('utils').tree_width

      local symbols = require('sidebar-nvim.builtin.symbols')
      symbols.bindings['<CR>'] = require('sidebar-nvim.builtin.symbols').bindings['e']

      if not status_ok then
        return
      end

      -- user profile ( switch configurations based on the active profile )
      local M = {
        config = {
          default_profile = 'personal',
          env_name = 'NVIM_PROFILE',
        },
      }

      -- @return string the current active profile
      local function get_active_profile()
        local env_profile = vim.env[M.config.env_name]
        if type(env_profile) == 'string' and env_profile ~= '' then
          return env_profile
        end

        return M.config.default_profile
      end

      -- index `tbl` with the current active profile
      -- the special profile `default` can be used as a fallback if none of the keys match
      -- @param tbl table keys are profile names, values can be anything
      -- @return the value of they key matching the current profile
      local function with_profile_table(tbl)
        local active_profile = get_active_profile()

        local ret = tbl[active_profile]

        if not ret then
          return tbl['default']
        end

        return ret
      end

      sidebar.setup({
        open = false,
        disable_default_keybindings = true,
        side = 'right',
        initial_width = tree_width(0.2),
        update_interval = 2000,
        enable_profile = false,
        hide_statusline = true,
        section_separator = { '-----', '' },
        sections = with_profile_table({
          default = { 'symbols', 'git', 'diagnostics', 'containers' },
          test = {
            'buffers',
            'todos',
            'diagnostics',
            'git',
            'symbols',
            'files',
            'containers',
          },
          work = { 'git', 'diagnostics', 'containers' },
        }),
        bindings = {
          ['q'] = function()
            require('sidebar-nvim').close()
          end,
          ['<C-q>'] = function()
            require('sidebar-nvim').close()
          end,
        },
        datetime = {
          format = '%a %b %d, %l:%M %p',
          clocks = {
            naem = "andrew's clock",
          },
        },
        todos = { initially_closed = true, ignored_paths = { '~' } },
        buffers = { sorting = 'name', ignore_not_loaded = true },
        files = {
          follow = false,
          icon = '',
          show_hidden = false,
          ignored_paths = { '%.git$' },
        },
      })

      keymap.set(
        'n',
        '<C-m>',
        lazy(sidebar.toggle),
        { noremap = true, silent = true }
      )

    end
  }
}
