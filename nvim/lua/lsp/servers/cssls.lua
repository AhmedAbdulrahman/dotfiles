local M = {}

M.settings = {}

M.on_attach = function(client)
  client.server_capabilities.documentFormattingProvider = true
  client.server_capabilities.documentRangeFormattingProvider = true
end

return M
