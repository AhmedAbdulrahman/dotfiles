local M = {}

local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if cmp_nvim_lsp_ok then
  capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.preselectSupport = true
  capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
  capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
  capabilities.textDocument.completion.completionItem.deprecatedSupport = true
  capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
  capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      'documentation',
      'detail',
      'additionalTextEdits',
    }
  }
  capabilities.textDocument.codeAction = {
    dynamicRegistration = false,
    codeActionLiteralSupport = {
      codeActionKind = {
        valueSet = {
          "",
          "quickfix",
          "refactor",
          "refactor.extract",
          "refactor.inline",
          "refactor.rewrite",
          "source",
          "source.organizeImports",
        },
      },
    },
  }
end

local on_attach = function(client, bufnr)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false

  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
  vim.keymap.set("n", "${", '<cmd>lua require("functions").change_template_string_quotes()<CR>', { nowait = true })
  vim.keymap.set("i", "${", '<cmd>lua require("functions").change_template_string_quotes()<CR>')

  vim.api.nvim_buf_create_user_command(bufnr, 'CssToJs', 'lua require("functions").css_to_jss()', { range = true })
  vim.keymap.set("n", "gx", ":set opfunc=v:lua.css_to_jss<CR>g@", { buffer = bufnr })
  vim.keymap.set("n", "gxx", ":CssToJs<CR>", { buffer = bufnr })
  vim.keymap.set("v", "gx", ":CssToJs<CR>", { buffer = bufnr })
end

M.capabilities = capabilities;
M.on_attach = on_attach;

return M
