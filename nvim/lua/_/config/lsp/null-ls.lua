return function(on_attach)
  local ok, nls = pcall(require, 'null-ls')

  if not ok then
    return
  end

  local au = require('_.utils.au')

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
    on_attach = function(client)
      if client.resolved_capabilities.document_formatting then
        au.augroup('__LSP_FORMATTING__', function()
          au.autocmd(
            'BufWritePre',
            '<buffer>',
            'lua vim.lsp.buf.formatting_sync()'
          )
        end)
      end

      on_attach(client)
    end,
    sources = {
      refmt,
      jsonfmt,
      -- nixlinter,
      nls.builtins.formatting.prettier.with({
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
      nls.builtins.formatting.stylua,
      nls.builtins.formatting.gofmt,
      nls.builtins.formatting.goimports,
      -- nls.builtins.diagnostics.golint,
      nls.builtins.diagnostics.shellcheck.with({
        filetypes = { 'sh', 'bash' },
      }),
      nls.builtins.formatting.shfmt.with({
        filetypes = { 'sh', 'bash' },
      }),
      nls.builtins.formatting.rustfmt,
      nls.builtins.formatting.black,
      nls.builtins.diagnostics.pylint,
      nls.builtins.diagnostics.hadolint,
      nls.builtins.diagnostics.vint,
      nls.builtins.diagnostics.vale,
    },
  })
end
