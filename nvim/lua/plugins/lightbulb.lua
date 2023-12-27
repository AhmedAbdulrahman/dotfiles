local status_ok, lightbulb = pcall(require, 'nvim-lightbulb')
if not status_ok then
  require("notify")("Plugin not found!", "warn", { title = "Lightbulb", timeout = 2000 })
  return
end

-- Showing defaults
lightbulb.setup {
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
    enabled = true,
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
