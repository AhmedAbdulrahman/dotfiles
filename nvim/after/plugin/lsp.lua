-- for debugging
-- :lua require('vim.lsp.log').set_level("debug")
-- :lua print(vim.inspect(vim.lsp.buf_get_clients()))
-- :lua print(vim.lsp.get_log_path())
-- :lua print(vim.inspect(vim.tbl_keys(vim.lsp.callbacks)))
local has_lsp, nvim_lsp = pcall(require, 'lspconfig')
local protocol = require 'vim.lsp.protocol'
local utils = require '_.utils'
local au = require '_.utils.au'
local map = require '_.utils.map'
local map_opts = { buffer = true, silent = true }

if not has_lsp then
  utils.notify 'LSP config failed to setup'
  return
end

local signs = { 'Error', 'Warn', 'Hint', 'Info' }

for _, type in pairs(signs) do
	vim.fn.sign_define('DiagnosticSign' .. type, {
	  text = utils.get_icon(string.lower(type)),
	  texthl = 'DiagnosticSign' .. type,
	  linehl = '',
	  numhl = '',
})
end

vim.api.nvim_buf_set_option(buffer, "omnifunc", "v:lua.vim.lsp.omnifunc")

local mappings = {
  ['<leader>a'] = { '<cmd>lua vim.lsp.buf.code_action()<CR>' },
--   ['<leader>f'] = { '<cmd>lua vim.lsp.buf.references()<CR>' },
  ['<leader>r'] = { '<cmd>lua vim.lsp.buf.rename()<CR>' },
  ['K'] = { '<cmd>lua vim.lsp.buf.hover()<CR>' },
  ['<leader>ld'] = {
    '<cmd>lua vim.diagnostic.open_float(0, { focusable = false,  border = "single", close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" }, source = "always" })<CR>',
  },
  ['[d'] = {
    '<cmd>lua vim.diagnostic.goto_next()<cr>',
  },
  [']d'] = {
    '<cmd>lua vim.lsp.diagnostic.goto_prev({ popup_opts = { border = "single", focusable = false, source = "always" }})<CR>',
  },
  ['<C-]>'] = { '<cmd>lua vim.lsp.buf.definition()<CR>' },
  ['<leader>D'] = { '<cmd>lua vim.lsp.buf.declaration()<CR>' },
  ['<leader>I'] = { '<cmd>lua vim.lsp.buf.implementation()<CR>' },
}

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
  vim.lsp.handlers.hover,
  { border = 'single', focusable = false, silent = true }
)

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
  vim.lsp.handlers.hover,
  { border = 'single', focusable = false, silent = true }
)

vim.diagnostic.config {
	virtual_text = { spacing = 4, prefix = "●" },
	underline = true,
	signs = true,
	severity_sort = true,
	update_in_insert = false,
}

local on_attach = function(client)
  -- ---------------
  -- GENERAL
  -- ---------------
  client.config.flags.allow_incremental_sync = true

  -- ---------------
  -- MAPPINGS
  -- ---------------
  for lhs, rhs in pairs(mappings) do
    if lhs == 'K' then
      if vim.api.nvim_buf_get_option(0, 'filetype') ~= 'vim' then
        map.nnoremap(lhs, rhs[1], map_opts)
      end
    else
      map.nnoremap(lhs, rhs[1], map_opts)
      if #rhs == 2 then
        map.vnoremap(lhs, rhs[2], map_opts)
      end
    end
  end

  -- ---------------
  -- AUTOCMDS
  -- ---------------
  au.augroup('__LSP__', function()
	-- Show diagnostics on cursor over
    -- au.autocmd(
    --   'CursorHold',
    --   '<buffer>',
    --   'lua vim.lsp.diagnostic.show_line_diagnostics()'
    -- )

	au.autocmd(
      'CursorHoldI',
      '<buffer>',
      'lua vim.lsp.buf.signature_help()'
    )
  end)

  if client.resolved_capabilities.document_highlight then
    -- vim.api.nvim_exec(
    --   [[
    --   hi! link LspReferenceRead SignColumn
    --   hi! link LspReferenceText Module
    --   hi! link LspReferenceWrite SpecialKey
    --   ]],
    --   false
    -- )

    au.augroup('__LSP_HIGHLIGHTS__', function()
      au.autocmd(
        'CursorHold',
        '<buffer>',
        'lua vim.lsp.buf.document_highlight()'
      )
      au.autocmd(
        'CursorHoldI',
        '<buffer>',
        'lua vim.lsp.buf.document_highlight()'
      )
      au.autocmd(
        'CursorMoved',
        '<buffer>',
        'lua vim.lsp.buf.clear_references()'
      )
    end)
  end

  if client.resolved_capabilities.document_formatting then
    vim.api.nvim_command [[augroup Format]]
    vim.api.nvim_command [[autocmd! * <buffer>]]
    vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]]
    vim.api.nvim_command [[augroup END]]
  end

  if client.resolved_capabilities.code_lens then
    au.augroup('__LSP_CODELENS__', function()
      au.autocmd(
        'CursorHold,BufEnter,InsertLeave',
        '<buffer>',
        'lua vim.lsp.codelens.refresh()'
      )
    end)
  end

-- Custom completion icons
	protocol.CompletionItemKind = {
		'', -- Text
		'', -- Method
		'', -- Function
		'', -- Constructor
		'', -- Field
		'', -- Variable
		'', -- Class
		'ﰮ', -- Interface
		'', -- Module
		'', -- Property
		'', -- Unit
		'', -- Value
		'', -- Enum
		'', -- Keyword
		'﬌', -- Snippet
		'', -- Color
		'', -- File
		'', -- Reference
		'', -- Folder
		'', -- EnumMember
		'', -- Constant
		'', -- Struct
		'', -- Event
		'ﬦ', -- Operator
		'', -- TypeParameter
  }

end

local servers = {
  cssls = {},
  bashls = {},
  vimls = {},
  pyright = {},
  dockerls = {},
  clojure_lsp = {},
  eslint = {},
  tailwindcss = {
    init_options = {
      userLanguages = {
        eruby = 'erb',
        eelixir = 'html-eex',
        ['javascript.jsx'] = 'javascriptreact',
        ['typescript.tsx'] = 'typescriptreact',
      },
    },
    handlers = {
      ['tailwindcss/getConfiguration'] = function(_, _, context)
        -- tailwindcss lang server waits for this repsonse before providing hover
        vim.lsp.buf_notify(
          context.bufnr,
          'tailwindcss/getConfigurationResponse',
          { _id = context.params._id }
        )
      end,
    },
  },
  efm = require '_.config.lsp.efm',
  rust_analyzer = {},
  gopls = {
    cmd = { 'gopls', 'serve' },
    root_dir = function(fname)
      return nvim_lsp.util.root_pattern('go.mod', '.git')(fname)
        or nvim_lsp.util.path.dirname(fname)
    end,
  },
  tsserver = {
    root_dir = function(fname)
      return not nvim_lsp.util.root_pattern '.flowconfig'(fname)
        and (
          nvim_lsp.util.root_pattern 'tsconfig.json'(fname)
          or nvim_lsp.util.root_pattern('package.json', 'jsconfig.json', '.git')(
            fname
          )
          or nvim_lsp.util.path.dirname(fname)
        )
    end,
  },
  jsonls = {
    filetypes = { 'json', 'jsonc' },
    settings = {
      json = {
        -- Schemas https://www.schemastore.org
        schemas = {
          {
            fileMatch = { 'package.json' },
            url = 'https://json.schemastore.org/package.json',
          },
          {
            fileMatch = { 'tsconfig*.json' },
            url = 'https://json.schemastore.org/tsconfig.json',
          },
          {
            fileMatch = {
              '.prettierrc',
              '.prettierrc.json',
              'prettier.config.json',
            },
            url = 'https://json.schemastore.org/prettierrc.json',
          },
          {
            fileMatch = { '.eslintrc', '.eslintrc.json' },
            url = 'https://json.schemastore.org/eslintrc.json',
          },
          {
            fileMatch = { '.babelrc', '.babelrc.json', 'babel.config.json' },
            url = 'https://json.schemastore.org/babelrc.json',
          },
          {
            fileMatch = { 'lerna.json' },
            url = 'https://json.schemastore.org/lerna.json',
          },
          {
            fileMatch = { 'now.json', 'vercel.json' },
            url = 'https://json.schemastore.org/now.json',
          },
          {
            fileMatch = {
              '.stylelintrc',
              '.stylelintrc.json',
              'stylelint.config.json',
            },
            url = 'http://json.schemastore.org/stylelintrc.json',
          },
        },
      },
    },
  },
  yamlls = {
    settings = {
      yaml = {
        -- Schemas https://www.schemastore.org
        schemas = {
          ['http://json.schemastore.org/gitlab-ci.json'] = {
            '.gitlab-ci.yml',
          },
          ['https://json.schemastore.org/bamboo-spec.json'] = {
            'bamboo-specs/*.{yml,yaml}',
          },
          ['https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json'] = {
            'docker-compose*.{yml,yaml}',
          },
          ['http://json.schemastore.org/github-workflow.json'] = '.github/workflows/*.{yml,yaml}',
          ['http://json.schemastore.org/github-action.json'] = '.github/action.{yml,yaml}',
          ['http://json.schemastore.org/prettierrc.json'] = '.prettierrc.{yml,yaml}',
          ['http://json.schemastore.org/stylelintrc.json'] = '.stylelintrc.{yml,yaml}',
          ['http://json.schemastore.org/circleciconfig'] = '.circleci/**/*.{yml,yaml}',
        },
      },
    },
  },
}

local capabilities = vim.lsp.protocol.make_client_capabilities()

if pcall(require, 'cmp_nvim_lsp') then
  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
else
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      'documentation',
      'detail',
      'additionalTextEdits',
    },
  }
end

for server, config in pairs(servers) do
  local server_disabled = (config.disabled ~= nil and config.disabled) or false

	if not server_disabled then
		nvim_lsp[server].setup(
			vim.tbl_deep_extend(
			'force',
			{ on_attach = on_attach, capabilities = capabilities },
			config
			)
		)
		require "lsp_signature".setup({
			bind = true, -- This is mandatory, otherwise border config won't get registered.
			handler_opts = {
			border = "rounded"
			}
		})
	end
end
