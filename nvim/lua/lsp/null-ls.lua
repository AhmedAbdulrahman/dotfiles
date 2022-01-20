return function(on_attach)
  local ok, nls = pcall(require, 'null-ls')

  if not ok then
    return
  end

  local h = require('null-ls.helpers')

-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/lua/null-ls/builtins/formatting
local formatting = nls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/lua/null-ls/builtins/diagnostics
local diagnostics = nls.builtins.diagnostics

  local refmt = {
    method = nls.methods.FORMATTING,
    filetypes = { 'rescript', 'reason' },
    generator = nls.formatter({
      command = 'refmt',
      to_stdin = true,
    }),
  }

  local jsonfmt = {
    method = nls.methods.FORMATTING,
    filetypes = { 'json' },
    generator = nls.formatter({
      command = 'jq',
      to_stdin = true,
    }),
  }

  nls.setup({
    debug = true,
    debounce = 150,
    on_attach = on_attach,
    sources = {
      refmt,
      jsonfmt,
      formatting.prettier.with({
        filetypes = {
          'typescript',
          'javascript',
          'typescript.tsx',
          'javascript.jsx',
          'typescriptreact',
          'javascriptreact',
          'vue',
          'yaml',
          'html',
          'scss',
          'css',
          'markdown',
          'mdx',
          'json',
        },
        extra_args = {
          '--config-precedence',
          'prefer-file',
          '--single-quote',
          '--no-bracket-spacing',
          '--prose-wrap',
          'always',
          '--arrow-parens',
          'always',
          '--trailing-comma',
          'all',
          '--no-semi',
          '--end-of-line',
          'lf',
          '--print-width',
          vim.bo.textwidth <= 80 and 80 or vim.bo.textwidth,
        },
      }),
      formatting.stylua,
      -- goimports runs gofmt too
      -- https://pkg.go.dev/golang.org/x/tools/cmd/goimports
      formatting.goimports,
      -- diagnostics.golint,
      diagnostics.shellcheck.with({
        filetypes = { 'sh', 'bash' },
      }),
      formatting.shfmt.with({
        filetypes = { 'sh', 'bash' },
      }),
      formatting.rustfmt,
      formatting.black.with({
        extra_args = { '--fast' },
      }),
      diagnostics.pylint,
      diagnostics.hadolint,
      diagnostics.vint,
      diagnostics.vale,
    },
  })
end
