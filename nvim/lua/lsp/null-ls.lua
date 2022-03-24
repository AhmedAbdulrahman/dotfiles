local null_ls = require('null-ls')

-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
  debug = true,
  debounce = 150,
  sources = {
    diagnostics.shellcheck.with({
      extra_args = {
        '--shell',
        'bash',
        '--exclude',
        table.concat({
          '1003', -- Want to escape a single quote? echo 'This is how it'\''s done'.
        }, ','),
      },
    }),
    diagnostics.flake8.with({
      extra_args = function(params)
        -- params.root is set to the first parent dir with with either .git or
        -- Makefile
        if vim.loop.fs_stat(params.root .. '/setup.cfg') then
          return {}
        end
        -- These ignores will override setup.cfg
        return {
          '--ignore',
          table.concat({
            'E501', -- line too long
            'E221', -- multiple space before operators
            'E201', -- whitespace before/after '['/']'
            'E202', -- whitespace before ']'
            'E272', -- multiple spaces before keyword
            'E241', -- multiple spaces after ':'
            'E231', -- missing whitespace after ':'
            'E203', -- whitespace before ':'
            'E741', -- ambiguous variable name
            'E226', -- missing whitespace around arithmetic operator
            'E305',
            'E302', -- expected 2 blank lines after class
            'E251', -- unexpected spaces around keyword / parameter equals (E251)
          }, ','),
        }
      end,
    }),
    diagnostics.pylint,
    diagnostics.hadolint,
    diagnostics.vint,
    diagnostics.vale,
    diagnostics.statix,
  },
  diagnostics_format = '#{s}: #{m} (#{c})',
  on_attach = on_attach,
})
