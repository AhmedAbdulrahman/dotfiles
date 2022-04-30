-- luacheck: max line length 130

local lsp_installer = require('nvim-lsp-installer')
local keymap = vim.keymap
local silent = silent

local on_attach = function(client, bufnr)
  keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", silent)
  keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", silent)
  keymap.set("n", "<C-Space>", "<cmd>lua vim.lsp.buf.code_action()<CR>", silent)
  keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", silent)
  keymap.set("v", "<leader>ca", "<cmd>'<,'>lua vim.lsp.buf.range_code_action()<CR>", silent)
  keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", silent)
  keymap.set("n", "<leader>cf", "<cmd>lua vim.lsp.buf.formatting()<CR>", silent)
  keymap.set("v", "<leader>cf", "<cmd>'<.'>lua vim.lsp.buf.range_formatting()<CR>", silent)
  keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", silent)
  keymap.set("n", "L", "<cmd>lua vim.lsp.buf.signature_help()<CR>", silent)
  keymap.set("v", "gL", "<cmd>lua vim.lsp.buf.signature_help()<CR>", silent)
  keymap.set("n", "]g", "<cmd>lua vim.diagnostic.goto_next({ float = { border = 'rounded' }})<CR>", silent)
  keymap.set("n", "[g", "<cmd>lua vim.diagnostic.goto_prev({ float = { border = 'rounded' }})<CR>", silent)
  keymap.set("n", '<leader>e', '<cmd>lua vim.diagnostic.open_float(nil, { focusable = false,  close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" }, source = "always" })<CR>', silent)

-- map('n', 'gD', vim.lsp.buf.declaration, silent)
-- map('n', 'gi', vim.lsp.buf.implementation, silent)
-- map('n', '<leader>cl', vim.lsp.codelens.run, silent)
-- map('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, silent)
-- map('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, silent)

  -- Use LSP as the handler for formatexpr.
  --    See `:help formatexpr` for more information.
  vim.bo[bufnr].formatexpr = 'v:lua.vim.lsp.formatexpr()'

  -- Use LSP as the handler for omnifunc.
  --    See `:help omnifunc` and `:help ins-completion` for more information.
  --    Enable completion triggered by <c-x><c-o>
  vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

  require('aerial').on_attach(client, bufnr)
  map('n', '<leader>a', '<cmd>AerialToggle!<CR>')
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

lsp_installer.on_server_ready(function(server)
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  local has_cmp_lsp, cmp_lsp = pcall(require, 'cmp_nvm_lsp')

  if has_cmp_lsp then
    -- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers.
    capabilitiescapabilities = cmp_lsp.update_capabilities(
      vim.lsp.protocol.make_client_capabilities()
    )
  end

  local opts = {
    on_attach = on_attach,
    capabilities = capabilities,
    handlers = handlers,
    flags = {
      debounce_text_changes = 150,
    },
  }

  if server.name == 'bash' then
    opts.settings = require('lsp.servers.bash').settings
  end

  if server.name == 'cssls' then
    opts.settings = require('lsp.servers.css').settings
  end

  if server.name == 'eslint' then
    opts.on_attach = function(client, bufnr)
      -- neovim's LSP client does not currently support dynamic capabilities registration,
      -- so we need to set the resolved capabilities of the eslint server ourselves!
      --   client.resolved_capabilities.document_formatting = true
      on_attach(client, bufnr)
    end
    opts.settings = require('lsp.servers.eslint').settings
  end

  if server.name == 'graphql' then
    opts.settings = require('lsp.servers.graphql').settings
  end

  if server.name == 'html' then
    opts.capabilities = require('lsp.servers.html').capabilities
    opts.settings = require('lsp.servers.html').settings
  end

  if server.name == 'jsonls' then
    opts.settings = require('lsp.servers.json').settings
  end

  --   if server.name == 'sumneko_lua' then
  --     opts.settings = require('lsp.servers.lua').settings
  --   end

  if server.name == 'vuels' then
    opts.filetypes = require('lsp.servers.vue2').filetypes
    opts.init_options = require('lsp.servers.vue2').init_options
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
