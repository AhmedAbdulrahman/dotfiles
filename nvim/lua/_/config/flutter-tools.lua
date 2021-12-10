return function()
	local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true;


-- alternatively you can override the default configs
require('flutter-tools').setup {
  lsp = {
    on_attach = function (client, bufnr)
      local opts = { noremap=true, silent=false }
      local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
      require('lsp').on_attach(client, bufnr)

      buf_set_keymap('n', '<Leader>fr', '<Cmd>FlutterRun<CR>', opts)
    end,
	--- This is necessary to prevent lsp-status' capabilities being
	--- given priority over that of the default config
    capabilities = capabilities, -- e.g. lsp_status capabilities
    settings = {
      showTodos = true,
      completeFunctionCalls = true,
      analysisExcludedFolders = {''}
    }
  },
	ui = { border = 'rounded' },
	decorations = {statusline = {app_version = true, device = true}},
	debugger = { enabled = true, run_via_dap = true },
	closing_tags = {
		highlight = "Comment", -- highlight for the closing tag
		prefix = "❯ ", -- character to use for close tag e.g. > Widget
		enabled = true -- set to false to disable
	},
	dev_log = {
		open_cmd = "tabedit" -- command to use to open the log buffer
	},
	outline = {
		open_cmd = "30vnew", -- command to use to open the outline buffer
		auto_open = false -- if true this will open the outline automatically when it is first populated
	},
	widget_guides = { enabled = true, debug = true },
}
end
