require('nvim-treesitter.configs').setup({
  ensure_installed = {}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
  ignore_install = { 'haskell', 'verilog' }, -- list of parsers to ignore installing

  query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_events = { 'BufWrite', 'CursorHold' },
  },

  highlight = {
    enable = true,
    -- disable = { "c", "rust" },  -- list of language that will be disabled
    -- additional_vim_regex_highlighting = false,
  },

  incremental_selection = {
    enable = false,
    keymaps = {
      init_selection = '<leader>gnn',
      node_incremental = '<leader>gnr',
      scope_incremental = '<leader>gne',
      node_decremental = '<leader>gnt',
    },
  },

  indent = {
    enable = true,
  },

  rainbow = {
    enable = false,
  },

  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },

  textobjects = {
    select = {
      enable = true,
      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
        ['aC'] = '@conditional.outer',
        ['iC'] = '@conditional.inner',
      },
    },
  },

  autotag = {
    enable = true,
    filetypes = {
      'html',
      'javascript',
      'javascriptreact',
      'typescriptreact',
      'svelte',
      'vue',
      'javascript.jsx',
      'typescript.tsx',
    },
  },

  move = {
    enable = true,
    set_jumps = true, -- whether to set jumps in the jumplist
    goto_next_start = {
      [']]'] = '@function.outer',
      [']m'] = '@class.outer',
    },
    goto_next_end = {
      [']['] = '@function.outer',
      [']M'] = '@class.outer',
    },
    goto_previous_start = {
      ['[['] = '@function.outer',
      ['[m'] = '@class.outer',
    },
    goto_previous_end = {
      ['[]'] = '@function.outer',
      ['[M'] = '@class.outer',
    },
  },

  autopairs = {
    enable = true,
  },

  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
  },

  textsubjects = {
    enable = true,
    keymaps = {
      ['<cr>'] = 'textsubjects-smart', -- works in visual mode
    },
  },
})
