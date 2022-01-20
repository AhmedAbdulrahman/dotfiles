-- luacheck: max line length 130

local lsp_installer = require('nvim-lsp-installer')
local au = require('utils.au')
local map = require('utils.map')

vim.diagnostic.config {
	virtual_text = false,
	-- float = {
	--   source = 'always',
	-- },
	-- underline = true,
	-- signs = true,
	-- update_in_insert = false,
	-- severity_sort = true,
  }

local on_attach = function(client, bufnr)

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- Mappings.
	local opts = { noremap=true, silent=true }

	-- Enable completion triggered by <c-x><c-o>
	buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	map.nnoremap( 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	map.nnoremap( 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
	map.nnoremap( 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
	map.nnoremap( 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	map.nnoremap( '<C-s>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	map.nnoremap( '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
	map.nnoremap( '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
	map.nnoremap( '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
	map.nnoremap( '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	map.nnoremap( '<leader>cr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	map.nnoremap( '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
	map.vnoremap( '<leader>ca', "<cmd>'<,'>lua vim.lsp.buf.range_code_action()<CR>", opts )
	map.nnoremap( 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	map.nnoremap( '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
	map.nnoremap( '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev({ float = { border = "rounded" }})<CR>', opts)
	map.nnoremap( ']d', '<cmd>lua vim.lsp.diagnostic.goto_next({ float = { border = "rounded" }})<CR>', opts)
	map.nnoremap( '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
	map.nnoremap( '<leader>cf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
	map.vnoremap( '<leader>cf', "<cmd>'<.'>lua vim.lsp.buf.range_formatting()<CR>", opts)

  if client.resolved_capabilities.code_lens then
	au.group('__LSP_CODELENS__', function(g)
		au(
			{'CursorHold', 'BufEnter', 'InsertLeave'},
			{ '<buffer>', function() vim.lsp.codelens.refresh() end }
		)
	end)
  end

  -- Formatting on save is handled by null
  if
    client.name == 'null-ls'
    and client.resolved_capabilities.document_formatting
  then
    au.group('LspFormat', function(g)
      g.BufWritePre = {
        '<buffer>',
        function()
          -- https://github.com/akinsho/dotfiles/blob/1f8fe569e2/.config/nvim/lua/as/plugins/lspconfig.lua
          -- BUG: folds are are removed when formatting is done, so we save the current state of the
          -- view and re-apply it manually after formatting the buffer
          -- @see: https://github.com/nvim-treesitter/nvim-treesitter/issues/1424#issuecomment-909181939
          vim.cmd('mkview!')
          vim.lsp.buf.formatting_sync()
          vim.cmd('loadview')
        end,
      }
    end)
  else
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  end
end

local handlers = {
  ['textDocument/hover'] = vim.lsp.with(
    vim.lsp.handlers.hover,
    { border = NvimConfig.ui.float.border }
  ),
  ['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    { border = NvimConfig.ui.float.border }
  ),
}

require('lsp.null-ls')(on_attach)

lsp_installer.on_server_ready(function(server)
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  local status_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
  if status_ok then
    capabilities = cmp_nvim_lsp.update_capabilities(
      vim.lsp.protocol.make_client_capabilities()
    )
  end

  local opts = {
    on_attach = on_attach,
    capabilities = capabilities,
    handlers = handlers,
  }

  if server.name == 'bash' then
    opts.settings = require('lsp.servers.bash').settings
  end

  if server.name == 'cssls' then
    opts.settings = require('lsp.servers.css').settings
  end

  if server.name == 'eslint' then
    opts.settings = require('lsp.servers.eslint').settings
  end

  if server.name == 'html' then
    opts.capabilities = require('lsp.servers.html').capabilities
    opts.settings = require('lsp.servers.html').settings
  end

  if server.name == 'jsonls' then
    opts.settings = require('lsp.servers.json').settings
  end

  if server.name == 'sumneko_lua' then
    opts.settings = require('lsp.servers.lua').settings
  end

  if server.name == 'vuels' then
    opts.init_options = require('lsp.servers.vue').init_options
  end

  -- (How to) Customize the options passed to the server
  -- if server.name == "tsserver" then
  --     opts.root_dir = function() ... end
  --     opts.on_attach = function(client, bufnr) ... end
  -- end

  -- This setup() function is exactly the same as lspconfig's setup function (:help lspconfig-quickstart)
  server:setup(opts)
  vim.cmd([[ do User LspAttachBuffers ]])
end)
