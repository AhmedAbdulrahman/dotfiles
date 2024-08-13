return {
  {
    'nvim-treesitter/nvim-treesitter',
    event = 'BufReadPre',
    dependencies = {
      'mrjones2014/nvim-ts-rainbow',
      "hiphish/rainbow-delimiters.nvim",
      'JoosepAlviste/nvim-ts-context-commentstring',
      'nvim-treesitter/nvim-treesitter-textobjects',
      'RRethy/nvim-treesitter-textsubjects',
    },
    config = function()
      require 'nvim-treesitter.configs'.setup {
        ensure_installed = {
          'tsx',
          'typescript',
          'javascript',
          'html',
          'css',
          'vue',
          'astro',
          'svelte',
          'gitcommit',
          'graphql',
          'json',
          'json5',
          'markdown',
          'prisma',
          'lua',
          'vim',
        },                              -- one of "all", or a list of languages
        sync_install = false,           -- install languages synchronously (only applied to `ensure_installed`)
        ignore_install = { "haskell" }, -- list of parsers to ignore installing
        highlight = {
          enable = true,
          -- disable = { "c", "rust" },  -- list of language that will be disabled
          -- additional_vim_regex_highlighting = false,
        },
        -- enable autotagging (w/ nvim-ts-autotag plugin)
        autotag = {
          enable = true,
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

        textobjects = {
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              [']m'] = '@function.outer',
              [']]'] = '@class.outer',
            },
            goto_next_end = {
              [']M'] = '@function.outer',
              [']['] = '@class.outer',
            },
            goto_previous_start = {
              ['[m'] = '@function.outer',
              ['[['] = '@class.outer',
            },
            goto_previous_end = {
              ['[M'] = '@function.outer',
              ['[]'] = '@class.outer',
            },
          },
          select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ['aa'] = '@parameter.outer',
              ['ia'] = '@parameter.inner',
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              ['ic'] = '@class.inner',
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ['<leader>a'] = '@parameter.inner',
            },
            swap_previous = {
              ['<leader>A'] = '@parameter.inner',
            },
          },
        },

        textsubjects = {
          enable = true,
          keymaps = {
            ['<CR>'] = 'textsubjects-smart', -- works in visual mode
          },
        },

      }
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    event = "BufReadPre",
    config = function()
      require('nvim-ts-autotag').setup({
        opts = {
          enable_close = true,          -- Auto close tags
          enable_rename = true,          -- Auto rename pairs of tags
          enable_close_on_slash = true   -- Auto close on trailing </
        },
        -- Also override individual filetype configs, these take priority.
        -- Empty by default, useful if one of the "opts" global settings
        -- doesn't work well in a specific filetype
        --[[ per_filetype = {
            ["html"] = {
              enable_close = false
            }
          } ]]
      })
    end

  }
}
