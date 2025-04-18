-- -- luacheck: globals _LAZYGIT_TOGGLE _HTOP_TOGGLE
return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()

      local keymap = vim.keymap
      local silent = { silent = true }

      function _G.set_terminal_keymaps()
        local opts = { noremap = true }
        vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
        vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
        vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
        vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
        vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
      end

      vim.cmd('autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()')

      require('toggleterm').setup({
        -- size can be a number or function which is passed the current terminal
        size = function(term)
          if term.direction == "horizontal" then
            return 15
          elseif term.direction == "vertical" then
            return math.floor(vim.o.columns * 0.4)
          end
        end,
        open_mapping = [[<F12>]],
        ---@diagnostic disable-next-line: unused-local
        on_open = function(term)
        end,
        ---@diagnostic disable-next-line: unused-local
        on_close = function(term)
        end,
        highlights = {
          -- highlights which map to a highlight group name and a table of it's values
          -- NOTE: this is only a subset of values, any group placed here will be set for the terminal window split
          Normal = {
            link = 'Normal'
          },
          NormalFloat = {
            link = 'Normal'
          },
          FloatBorder = {
            -- guifg = <VALUE-HERE>,
            -- guibg = <VALUE-HERE>,
            link = 'FloatBorder'
          },
        },
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 1,       -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
        start_in_insert = true,
        insert_mappings = true,   -- whether or not the open mapping applies in insert mode
        persist_size = true,
        direction = 'vertical', -- | 'horizontal' | 'window' | 'float',
        close_on_exit = true,     -- close the terminal window when the process exits
        shell = vim.o.shell,      -- change the default shell
        -- This field is only relevant if direction is set to 'float'
        float_opts = {
          -- The border key is *almost* the same as 'nvim_win_open'
          -- see :h nvim_win_open for details on borders however
          -- the 'curved' border is a custom border type
          -- not natively supported but implemented in this plugin.
          border = 'curved', -- single/double/shadow/curved
          width = math.floor(0.7 * vim.fn.winwidth(0)),
          height = math.floor(0.8 * vim.fn.winheight(0)),
          winblend = 4,
          highlights = {
            border = 'Normal',
            background = 'Normal',
          },
        },
        winbar = {
          enabled = true,
        },
      })

      local float_handler = function(term)
        vim.cmd('startinsert!')
        vim.api.nvim_buf_set_keymap(
          term.bufnr,
          'n',
          'q',
          '<cmd>close<CR>',
          { noremap = true, silent = true }
        )
        -- this is the trick to make <esc> work properly since it's mapped below
        vim.api.nvim_buf_set_keymap(
          term.bufnr,
          't',
          '<esc>',
          '<esc>',
          { noremap = true }
        )
      end

      local Terminal = require('toggleterm.terminal').Terminal
      local lazygit = Terminal:new({
        cmd = 'lazygit',
        dir = 'git_dir',
        hidden = true,
        direction = 'float',
        on_open = float_handler,
        float_opts = {
          border = 'curved',
          winblend = 3,
        },
      })

      local htop = Terminal:new({
        cmd = 'htop',
        hidden = 'true',
        direction = 'float',
        on_open = float_handler,
      })

      function _LAZYGIT_TOGGLE()
        lazygit:toggle()
      end

      function _HTOP_TOGGLE()
        htop:toggle()
      end

      vim.cmd('autocmd! Htop lua _HTOP_TOGGLE()')
      keymap.set('n', '<Space>gg', '<cmd>lua _LAZYGIT_TOGGLE()<CR>', silent)
    end,
    keys = {
      { "<F12>" },
      { "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", desc = "Toggle terminal float" },
      { "<leader>th", "<cmd>ToggleTerm direction=horizontal<CR>", desc = "Toggle terminal horizontal" }
    }
  }
}
