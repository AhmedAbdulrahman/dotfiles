require('nvim-treesitter').define_modules({
  fold = {
    attach = function()
      vim.opt.foldmethod = 'expr'
      vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
    end,
    detach = function() end,
  },
})

require('treesitter-context').setup({
  enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
  throttle = true, -- Throttles plugin updates (may improve performance)
  max_lines = 4, -- How many lines the window should span. Values <= 0 mean no limit.
})

require('nvim-treesitter.configs').setup({
  ensure_installed = {}, -- one of "all", or a list of languages
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
    additional_vim_regex_highlighting = false,
  },

  incremental_selection = {
    enable = false,
    keymaps = {
      init_selection = 'gnn',
      node_incremental = 'grn',
      scope_incremental = 'grc',
      node_decremental = 'grm',
    },
  },

  fold = {
    enable = true,
    disable = { 'rst', 'make' },
  },

  indent = {
    enable = true,
    is_supported = function(lang)
      return lang == 'lua'
    end,
  },

  rainbow = {
    enable = false,
  },

  context_commentstring = {
    enable = true,
    enable_autocmd = false,
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

  autopairs = {
    enable = true,
  },

  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
  },

  textobjects = {
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

  textsubjects = {
    enable = true,
    keymaps = {
      ['<cr>'] = 'textsubjects-smart', -- works in visual mode
    },
  },
})

local function get_node_at_line(root, lnum)
  for node in root:iter_children() do
    local srow, _, erow = node:range()
    if srow == lnum then
      return node
    end

    if node:child_count() > 0 and srow < lnum and lnum <= erow then
      return get_node_at_line(node, lnum)
    end
  end

  local wrapper = root:descendant_for_range(lnum, 0, lnum, -1)
  local child = wrapper:child(0)
  return child or wrapper
end

local function ts_get_tree(lnum)
  lnum = lnum or vim.api.nvim_win_get_cursor(0)[1]

  local parsers = require('nvim-treesitter.parsers')
  local parser = parsers.get_parser()

  if not parser or not lnum then
    return -1
  end

  local node = get_node_at_line(parser:parse()[1]:root(), lnum - 1)
  while node do
    print(vim.inspect(tostring(node)))
    node = node:parent()
  end
end

vim.api.nvim_set_keymap(
  'n',
  '<leader>Z',
  '',
  { silent = true, callback = ts_get_tree }
)
