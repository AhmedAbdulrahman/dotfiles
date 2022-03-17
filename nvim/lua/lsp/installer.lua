-- luacheck: max line length 130

local lsp_installer = require('nvim-lsp-installer')

local on_attach = function(client, bufnr)
  local function map(mode, key, result, opts)
    opts = opts or {}
    opts.buffer = bufnr
    opts.silent = true
    vim.keymap.set(mode, key, result, opts)
  end

  map('n', 'gd', vim.lsp.buf.definition)
  map('n', 'gD', vim.lsp.buf.declaration)
  map('n', 'gi', vim.lsp.buf.implementation)
  map('n', '<leader>cl', vim.lsp.codelens.run)
  map('n', 'K', vim.lsp.buf.hover)
  map('n', 'gK', vim.lsp.buf.signature_help)
  map('v', '<C-s>', vim.lsp.buf.signature_help)
  --   map('gr'        , 'vim.lsp.buf.references()')
  map('n', 'gr', '<cmd>Trouble lsp_references<cr>')
  map('n', '<leader>rn', vim.lsp.buf.rename)
  map('n', '<leader>ca', vim.lsp.buf.code_action)
  map('v', '<leader>ca', vim.lsp.buf.range_code_action)
  map('n', '<leader>cf', vim.lsp.buf.formatting)
  map('v', '<leader>cf', vim.lsp.buf.range_formatting)
  map('n', '<leader>wa', vim.lsp.buf.add_workspace_folder)
  map('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder)

  map(
    'n',
    '<leader>e',
    '<cmd>lua vim.diagnostic.open_float(nil, { focusable = false,  close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" }, source = "always" })<CR>'
  )
  map(
    'n',
    '[d',
    '<cmd>lua vim.lsp.diagnostic.goto_prev({ float = { border = "rounded" }})<CR>'
  )
  map(
    'n',
    ']d',
    '<cmd>lua vim.lsp.diagnostic.goto_next({ float = { border = "rounded" }})<CR>'
  )

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

  if server.name == 'sumneko_lua' then
    opts.settings = require('lsp.servers.lua').settings
  end

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
