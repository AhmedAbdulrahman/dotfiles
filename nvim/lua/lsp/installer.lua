-- luacheck: max line length 130

local lsp_installer = require('nvim-lsp-installer')
local au = require('utils.au')
local map = require('utils.map')

local function getBorder(highlight)
  return {
    { '╭', highlight or 'FloatBorder' },
    { '─', highlight or 'FloatBorder' },
    { '╮', highlight or 'FloatBorder' },
    { '│', highlight or 'FloatBorder' },
    { '╯', highlight or 'FloatBorder' },
    { '─', highlight or 'FloatBorder' },
    { '╰', highlight or 'FloatBorder' },
    { '│', highlight or 'FloatBorder' },
  }
end

-- wrap open_float to inspect diagnostics and use the severity color for border
-- https://neovim.discourse.group/t/lsp-diagnostics-how-and-where-to-retrieve-severity-level-to-customise-border-color/1679
vim.diagnostic.open_float = (function(orig)
  return function(bufnr, opts)
    local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1
    local opts = opts or {}
    -- A more robust solution would check the "scope" value in `opts` to
    -- determine where to get diagnostics from, but if you're only using
    -- this for your own purposes you can make it as simple as you like
    local diagnostics = vim.diagnostic.get(opts.bufnr or 0, { lnum = lnum })
    local max_severity = vim.diagnostic.severity.HINT
    for _, d in ipairs(diagnostics) do
      -- Equality is "less than" based on how the severities are encoded
      if d.severity < max_severity then
        max_severity = d.severity
      end
    end
    local border_color = ({
      [vim.diagnostic.severity.HINT] = 'DiagnosticHint',
      [vim.diagnostic.severity.INFO] = 'DiagnosticInfo',
      [vim.diagnostic.severity.WARN] = 'DiagnosticWarn',
      [vim.diagnostic.severity.ERROR] = 'DiagnosticError',
    })[max_severity]
    opts.border = getBorder(border_color)
    orig(bufnr, opts)
  end
end)(vim.diagnostic.open_float)

vim.diagnostic.config({
  virtual_text = false,
  -- float = {
  --   source = 'always',
  -- },
  -- underline = true,
  -- signs = true,
  -- update_in_insert = false,
  -- severity_sort = true,
})

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  -- Mappings.
  local opts = { noremap = true, silent = true }

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  map.nnoremap('gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  map.nnoremap('gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  map.nnoremap('K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  map.nnoremap('gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  map.nnoremap('<C-s>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  map.nnoremap(
    '<leader>wa',
    '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>',
    opts
  )
  map.nnoremap(
    '<leader>wr',
    '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>',
    opts
  )
  map.nnoremap(
    '<leader>wl',
    '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
    opts
  )
  map.nnoremap('<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  map.nnoremap('<leader>cr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  map.nnoremap('<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  map.vnoremap(
    '<leader>ca',
    "<cmd>'<,'>lua vim.lsp.buf.range_code_action()<CR>",
    opts
  )
  map.nnoremap('gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  map.nnoremap(
    '<leader>e',
    '<cmd>lua vim.diagnostic.open_float(nil, { focusable = false,  close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" }, source = "always" })<CR>',
    opts
  )
  map.nnoremap(
    '[d',
    '<cmd>lua vim.lsp.diagnostic.goto_prev({ float = { border = "rounded" }})<CR>',
    opts
  )
  map.nnoremap(
    ']d',
    '<cmd>lua vim.lsp.diagnostic.goto_next({ float = { border = "rounded" }})<CR>',
    opts
  )
  -- map.nnoremap( '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  map.nnoremap('<leader>cf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  map.vnoremap(
    '<leader>cf',
    "<cmd>'<.'>lua vim.lsp.buf.range_formatting()<CR>",
    opts
  )

  if client.resolved_capabilities.code_lens then
    au.group('__LSP_CODELENS__', function(g)
      au({ 'CursorHold', 'BufEnter', 'InsertLeave' }, {
        '<buffer>',
        function()
          vim.lsp.codelens.refresh()
        end,
      })
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
    { focusable = false, silent = true }
  ),
  ['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers.hover,
    { focusable = false, silent = true }
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
