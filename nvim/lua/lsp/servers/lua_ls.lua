local M = {}

-- if server == "lua_ls" then
--   require("neodev").setup {}
-- end

M.settings = {
  Lua = {
    diagnostics = {
      globals = { 'vim', 'bit', 'packer_plugins' }
    },
    hint = { enable = true },
  }
}

return M
