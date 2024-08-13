return {
  {
    "kosayoda/nvim-lightbulb",
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('nvim-lightbulb').setup {
        -- LSP client names to ignore
        ignore = {
          -- Example: {"null-ls", "lua_ls"}
          clients = { "null-ls" },
        },
        sign = {
          enabled = true,
          -- Priority of the gutter sign
          priority = 10,
        },
        autocmd = {
          enabled = false,
        },
        float = {
          enabled = false,
        },
        virtual_text = {
          enabled = false,
          -- Text to show at virtual text
          text = "💡",
          -- highlight mode to use for virtual text (replace, combine, blend), see :help nvim_buf_set_extmark() for reference
          hl_mode = "replace",
        },
        status_text = {
          enabled = false,
        }
      }

      vim.api.nvim_create_augroup("Lightbulb", { clear=true })

      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        group = 'Lightbulb',
        desc = [[require"nvim-lightbulb".update_lightbulb()]],
        callback = function()
          require "nvim-lightbulb".update_lightbulb()
        end,
      })
    end,
  }
}
