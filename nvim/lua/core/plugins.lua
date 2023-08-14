return {
  { 'nvim-lua/plenary.nvim' },
  {
    'nvim-tree/nvim-web-devicons',
    config = function()
      require('nvim-web-devicons').setup({ default = true })
    end,
  },
  {
    'mhinz/vim-startify',
    config = function()
      require('plugins.startify')
    end,
    lazy = false,
  },
  -- Themes
  {
    'AhmedAbdulrahman/aylin.vim',
    branch = '0.5-nvim',
    lazy = false,
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      vim.opt.background = 'dark'
      vim.cmd('colorscheme ' .. NvimConfig.colorscheme)
    end,
  },
  { 'arzg/vim-substrata' },
  {
    'olivercederborg/poimandres.nvim',
    config = function()
      require('poimandres').setup({
        -- leave this setup function empty for default config
        -- or refer to the configuration section
        -- for configuration options
      })
    end,
  },
  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    event = 'BufReadPre',
    config = function()
      require('plugins.treesitter')
    end,
    dependencies = {
      'mrjones2014/nvim-ts-rainbow',
      'JoosepAlviste/nvim-ts-context-commentstring',
      'nvim-treesitter/nvim-treesitter-textobjects',
      'RRethy/nvim-treesitter-textsubjects',
      -- 'romgrk/nvim-treesitter-context',
      -- 'nvim-treesitter/playground',
    },
  },

  -- 🔭 Navigating (Telescope/Tree/Refactor)
  {
    'nvim-telescope/telescope.nvim',
    lazy = false,
    config = function()
      require('plugins.telescope')
    end,
    dependencies = {
      -- Telescope Extensions
      { 'nvim-lua/popup.nvim' },
      { 'nvim-lua/plenary.nvim' },
      { 'kevinhwang91/nvim-bqf', ft = 'qf' },
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
      },
      { 'cljoly/telescope-repo.nvim' },
      { 'nvim-telescope/telescope-file-browser.nvim' },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'LinArcX/telescope-command-palette.nvim' },
      { 'nvim-telescope/telescope-github.nvim' },
      { 'dhruvmanila/browser-bookmarks.nvim' },
      { 'jvgrootveld/telescope-zoxide' },
    },
  },

  {
    'AckslD/nvim-neoclip.lua',
    dependencies = {
      -- you'll need at least one of these
      { 'nvim-telescope/telescope.nvim' },
      -- {'ibhagwan/fzf-lua'},
    },
    config = function()
      require('neoclip').setup()
    end,
  },
  {
    -- Refactor with spectre
    'nvim-pack/nvim-spectre',
    lazy = true,
    keys = {
      {
        '<Leader>pr',
        "<cmd>lua require('spectre').open_visual({select_word=true})<CR>",
        desc = 'refactor',
      },
      {
        '<Leader>pr',
        "<cmd>lua require('spectre').open_visual()<CR>",
        mode = 'v',
        desc = 'refactor',
      },
    },
  },
  {
    'nvim-tree/nvim-tree.lua',
    lazy = false,
    cmd = {
      'NvimTreeOpen',
      'NvimTreeClose',
      'NvimTreeToggle',
      'NvimTreeFindFile',
      'NvimTreeFindFileToggle',
    },
    config = function()
      require('plugins.tree')
    end,
  },
  {
    'sidebar-nvim/sidebar.nvim',
    config = function()
      require('plugins.sidebar')
    end,
  },
  {
    'karb94/neoscroll.nvim',
    config = function()
      require('plugins.neoscroll')
    end,
  },
  {
    'gbprod/stay-in-place.nvim',
    config = function()
      require('stay-in-place').setup({})
    end,
  },
  -- LSP Base
  {
    'neovim/nvim-lspconfig',
    lazy = false,
    dependencies = {
      'mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'hrsh7th/cmp-nvim-lsp',
      {
        'j-hui/fidget.nvim',
        branch = 'legacy',
        config = function()
          require('fidget').setup({
            window = {
              relative = 'editor', -- where to anchor the window, either `"win"` or `"editor"`
              blend = 0, -- `&winblend` for the window
            },
            text = {
              spinner = 'dots',
            },
          })
        end,
      },
      { 'folke/lua-dev.nvim' },
    },
  },
  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    keys = { { '<leader>cm', '<cmd>Mason<cr>', desc = 'Mason' } },
  },

  -- Formatters

  {
    'stevearc/aerial.nvim',
    config = function()
      require('plugins.aerial')
    end,
  },
  {
    'kevinhwang91/nvim-ufo',
    dependencies = 'kevinhwang91/promise-async',
    config = function()
      vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
      vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
      vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds)
    end,
  },
  -- better "f" and "t"
  {
    'ggandor/flit.nvim',
    config = true,
    dependencies = {
      'tpope/vim-repeat',
    },
  },
  -- LSP Cmp
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    lazy = false,
    dependencies = {
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-calc',
      'saadparwaiz1/cmp_luasnip',
      {
        'L3MON4D3/LuaSnip',
        dependencies = 'rafamadriz/friendly-snippets',
        config = function()
          require('luasnip.loaders.from_vscode').lazy_load({
            -- I maintain my own snippets for these languages
            exclude = {
              'rust',
            },
          })
        end,
      },
      'hrsh7th/cmp-nvim-lsp-signature-help',
      {
        'tzachar/cmp-tabnine',
        cond = NvimConfig.plugins.ai.tabnine.enabled,
        build = './install.sh',
      },
      {
        'David-Kunz/cmp-npm',
        config = function()
          require('plugins.cmp-npm')
        end,
      },
      {
        'zbirenbaum/copilot-cmp',
        cond = NvimConfig.plugins.ai.copilot.enabled,
        config = function()
          require('copilot_cmp').setup()
        end,
      },
    },
    config = function()
      require('plugins.cmp')
    end,
  },
  { 'onsails/lspkind-nvim' },
  {
    'NvChad/nvim-colorizer.lua',
    config = function()
      require('plugins.colorizer')
    end,
  },
  {
    'js-everts/cmp-tailwind-colors',
    config = true,
  },
  {
    'razak17/tailwind-fold.nvim',
    opts = {
      min_chars = 50,
    },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    ft = { 'html', 'svelte', 'astro', 'vue', 'typescriptreact' },
  },
  {
    'uga-rosa/ccc.nvim',
    lazy = true,
    cmd = { 'CccPick' },
    config = function()
      local ccc = require('ccc')
      ccc.setup({
        highlight_mode = 'bg',
        highlighter = {
          auto_enable = true,
        },
      })
    end,
  },
  { 'RRethy/vim-illuminate' },
  {
    'stevearc/dressing.nvim',
    event = 'VeryLazy',
    dependencies = 'MunifTanjim/nui.nvim',
    config = function()
      require('plugins.dressing')
    end,
  },
  --
  {
    'folke/trouble.nvim',
    cmd = { 'TroubleToggle', 'Trouble' },
    config = function()
      require('plugins.trouble')
    end,
  },
  { 'nvim-lua/popup.nvim' },
  {
    'SmiteshP/nvim-navic',
    config = function()
      require('plugins.navic')
    end,
    dependencies = 'neovim/nvim-lspconfig',
  },
  {
    'pmizio/typescript-tools.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    ft = { 'typescript', 'typescriptreact' },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'neovim/nvim-lspconfig',
    },
    config = function()
      require('plugins.typescript-tools')
    end,
  },
  { 'jose-elias-alvarez/typescript.nvim' },
  {
    'axelvc/template-string.nvim',
    event = 'InsertEnter',
    ft = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' },
    config = true, -- run require("template-string").setup()
  },

  {
    'dnlhc/glance.nvim',
    config = function()
      require('plugins.glance')
    end,
    cmd = { 'Glance' },
    keys = {
      { 'gd', '<cmd>Glance definitions<CR>', desc = 'LSP Definition' },
      { 'gr', '<cmd>Glance references<CR>', desc = 'LSP References' },
      { 'gm', '<cmd>Glance implementations<CR>', desc = 'LSP Implementations' },
      {
        'gy',
        '<cmd>Glance type_definitions<CR>',
        desc = 'LSP Type Definitions',
      },
    },
  },

  {
    'antosha417/nvim-lsp-file-operations',
    event = 'LspAttach',
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'kyazdani42/nvim-tree.lua' },
    },
    config = function()
      require('lsp-file-operations').setup()
    end,
  },

  -- Formatter
  {
    'mhartington/formatter.nvim',
    config = "require('plugins.formatter')",
  },

  -- General
  {
    'iamcco/markdown-preview.nvim',
    build = 'cd app && npm install',
    setup = function()
      vim.g.mkdp_filetypes = { 'markdown' }
    end,
    ft = { 'markdown' },
  },

  {
    'airblade/vim-rooter',
    setup = function()
      vim.g.rooter_patterns = NvimConfig.plugins.rooter.patterns
    end,
  },
  {
    'barrett-ruth/import-cost.nvim',
    build = 'sh install.sh yarn',
    ft = {
      'javascript',
      'typescript',
      'javascriptreact',
      'typescriptreact',
    },
    config = true,
  },
  { 'AndrewRadev/switch.vim', lazy = false },
  {
    'Wansmer/treesj',
    lazy = true,
    cmd = { 'TSJToggle', 'TSJSplit', 'TSJJoin' },
    keys = {
      { 'gJ', '<cmd>TSJToggle<CR>', desc = 'Toggle Split/Join' },
    },
    config = function()
      require('treesj').setup({
        use_default_keymaps = false,
      })
    end,
  },
  {
    'numToStr/Comment.nvim',
    branch = 'jsx',
    config = function()
      require('plugins.comment')
    end,
  },
  {
    'LudoPinelli/comment-box.nvim',
    lazy = false,
    keys = {
      {
        '<leader>ac',
        "<cmd>lua require('comment-box').lbox()<CR>",
        desc = 'comment box',
      },
      {
        '<leader>ac',
        "<cmd>lua require('comment-box').lbox()<CR>",
        mode = 'v',
        desc = 'comment box',
      },
    },
  },
  {
    'akinsho/nvim-toggleterm.lua',
    branch = 'main',
    config = function()
      require('plugins.toggleterm')
    end,
    lazy = false,
    keys = {
      {
        '<leader>at',
        '<cmd>ToggleTerm direction=float<CR>',
        desc = 'terminal float',
      },
    },
  },
  { 'tpope/vim-repeat' },
  { 'tpope/vim-speeddating' },
  {
    'Shatur/neovim-session-manager',
    lazy = false,
    config = function()
      require('plugins.session-manager')
    end,
    keys = {
      {
        '<leader>/sc',
        '<cmd>SessionManager load_session<CR>',
        desc = 'choose session',
      },
      {
        '<leader>/sr',
        '<cmd>SessionManager delete_session<CR>',
        desc = 'remove session',
      },
      {
        '<leader>/sd',
        '<cmd>SessionManager load_current_dir_session<CR>',
        desc = 'load current dir session',
      },
      {
        '<leader>/sl',
        '<cmd>SessionManager load_last_session<CR>',
        desc = 'load last session',
      },
      {
        '<leader>/ss',
        '<cmd>SessionManager save_current_session<CR>',
        desc = 'save session',
      },
    },
  },
  {
    'kylechui/nvim-surround',
    config = function()
      require('nvim-surround').setup({})
    end,
  },
  {
    'sunjon/shade.nvim',
    config = function()
      require('shade').setup()
      require('shade').toggle()
    end,
  },

  { 'dhruvasagar/vim-table-mode' },
  {
    'smoka7/multicursors.nvim',
    event = 'VeryLazy',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'smoka7/hydra.nvim',
    },
    config = true,
    keys = {
      {
        '<leader>j',
        '<cmd>MCstart<cr>',
        desc = 'Create a selection for word under the cursor',
      },
      {
        '<leader>k',
        '<CMD>MCvisual<CR>',
        mode = 'v',
        desc = 'Create a selection for word under the cursor',
      },
      {
        '<C-Down>',
        '<CMD>MCunderCursor<CR>',
        desc = 'multicursor down',
      },
    },
  },
  {
    'echasnovski/mini.align',
    lazy = false,
    version = '*',
    config = function()
      require('mini.align').setup()
    end,
  },
  {
    'nacro90/numb.nvim',
    lazy = false,
    config = function()
      require('plugins.numb')
    end,
  },
  {
    'folke/todo-comments.nvim',
    config = function()
      require('plugins.todo-comments')
    end,
  },
  {
    'folke/zen-mode.nvim',
    cmd = { 'ZenMode' },
    config = function()
      require('plugins.zen')
    end,
    disable = not NvimConfig.plugins.zen.enabled,
  },
  {
    'folke/twilight.nvim',
    config = function()
      require('twilight').setup({})
    end,
    disable = not NvimConfig.plugins.zen.enabled,
  },
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts = {},
    keys = {
      {
        's',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').jump()
        end,
      },
    },
  },
  {
    'folke/which-key.nvim',
    config = function()
      require('plugins.which-key')
    end,
    lazy = false,
  },
  {
    'nvim-lualine/lualine.nvim',
    event = 'VimEnter',
    config = function()
      require('plugins.lualine')
    end,
  },
  {
    'echasnovski/mini.bufremove',
    version = '*',
    config = function()
      require('mini.bufremove').setup({
        silent = true,
      })
    end,
  },
  {
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'echasnovski/mini.bufremove',
    },
    version = '*',
    config = function()
      require('plugins.bufferline')
    end,
    keys = {
      { '<Space>1', '<cmd>BufferLineGoToBuffer 1<CR>' },
      { '<Space>2', '<cmd>BufferLineGoToBuffer 2<CR>' },
      { '<Space>3', '<cmd>BufferLineGoToBuffer 3<CR>' },
      { '<Space>4', '<cmd>BufferLineGoToBuffer 4<CR>' },
      { '<Space>5', '<cmd>BufferLineGoToBuffer 5<CR>' },
      { '<Space>6', '<cmd>BufferLineGoToBuffer 6<CR>' },
      { '<Space>7', '<cmd>BufferLineGoToBuffer 7<CR>' },
      { '<Space>8', '<cmd>BufferLineGoToBuffer 8<CR>' },
      { '<Space>9', '<cmd>BufferLineGoToBuffer 9<CR>' },
      { '<A-1>', '<cmd>BufferLineGoToBuffer 1<CR>' },
      { '<A-2>', '<cmd>BufferLineGoToBuffer 2<CR>' },
      { '<A-3>', '<cmd>BufferLineGoToBuffer 3<CR>' },
      { '<A-4>', '<cmd>BufferLineGoToBuffer 4<CR>' },
      { '<A-5>', '<cmd>BufferLineGoToBuffer 5<CR>' },
      { '<A-6>', '<cmd>BufferLineGoToBuffer 6<CR>' },
      { '<A-7>', '<cmd>BufferLineGoToBuffer 7<CR>' },
      { '<A-8>', '<cmd>BufferLineGoToBuffer 8<CR>' },
      { '<A-9>', '<cmd>BufferLineGoToBuffer 9<CR>' },
      {
        '<leader>bb',
        '<cmd>BufferLineMovePrev<CR>',
        desc = 'Move back',
      },
      {
        '<leader>bl',
        '<cmd>BufferLineCloseLeft<CR>',
        desc = 'Close Left',
      },
      {
        '<leader>br',
        '<cmd>BufferLineCloseRight<CR>',
        desc = 'Close Right',
      },
      {
        '<leader>bn',
        '<cmd>BufferLineMoveNext<CR>',
        desc = 'Move next',
      },
      {
        '<leader>bp',
        '<cmd>BufferLinePick<CR>',
        desc = 'Pick Buffer',
      },
      {
        '<leader>bP',
        '<cmd>BufferLineTogglePin<CR>',
        desc = 'Pin/Unpin Buffer',
      },
      {
        '<leader>bsd',
        '<cmd>BufferLineSortByDirectory<CR>',
        desc = 'Sort by directory',
      },
      {
        '<leader>bse',
        '<cmd>BufferLineSortByExtension<CR>',
        desc = 'Sort by extension',
      },
      {
        '<leader>bsr',
        '<cmd>BufferLineSortByRelativeDirectory<CR>',
        desc = 'Sort by relative dir',
      },
    },
  },
  { 'antoinemadec/FixCursorHold.nvim' }, -- Needed while issue https://github.com/neovim/neovim/issues/12587 is still open
  {
    'rcarriga/nvim-notify',
    config = function()
      require('notify').setup({
        background_colour = '#000000',
      })
    end,
    init = function()
      local banned_messages = {
        'No information available',
        'LSP[tsserver] Inlay Hints request failed. Requires TypeScript 4.4+.',
        'LSP[tsserver] Inlay Hints request failed. File not opened in the editor.',
      }

      vim.notify = function(msg, ...)
        for _, banned in ipairs(banned_messages) do
          if msg == banned then
            return
          end
        end
        require('notify')(msg, ...)
      end
    end,
  },
  {
    'vuki656/package-info.nvim',
    event = 'BufEnter package.json',
    config = function()
      require('plugins.package-info')
    end,
  },
  --
  {
    'andweeb/presence.nvim',
    config = function()
      require('presence'):setup({
        buttons = false,
      })
    end,
  },

  --     -- Snippets & Language & Syntax
  -- 	{ 'Saecki/crates.nvim', dependencies = { 'nvim-lua/plenary.nvim' }, config = function()
  -- 		require('plugins.crates') end
  -- 	},
  {
    'windwp/nvim-autopairs',
    config = function()
      require('plugins.autopairs')
    end,
  },
  { 'mattn/emmet-vim' },
  { 'potatoesmaster/i3-vim-syntax' },
  {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('plugins.indent')
    end,
  },
  {
    'folke/noice.nvim',
    cond = NvimConfig.plugins.experimental_noice.enabled,
    lazy = false,
    config = function()
      require('plugins.noice')
    end,
  },
  {
    'rareitems/printer.nvim',
    lazy = false,
    config = function()
      require('plugins.printer')
    end,
  },
  {
    'danymat/neogen',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('plugins.neogen')
    end,
  },
  -- AI
  {
    'jcdickinson/codeium.nvim',
    cond = NvimConfig.plugins.ai.codeium.enabled,
    event = 'InsertEnter',
    cmd = 'Codeium',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'hrsh7th/nvim-cmp',
    },
    config = true,
  },
  {
    'zbirenbaum/copilot.lua',
    cond = NvimConfig.plugins.ai.copilot.enabled,
    event = 'InsertEnter',
    config = function()
      require('plugins.copilot')
    end,
  },
  {
    'madox2/vim-ai',
    cond = NvimConfig.plugins.ai.vim_ai.enabled,
    lazy = false,
  },
  {
    'jackMort/ChatGPT.nvim',
    cond = NvimConfig.plugins.ai.chatgpt.enabled,
    dependencies = {
      'MunifTanjim/nui.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
    keys = {
      { '<leader>t', '<cmd>ChatGPT<cr>', desc = 'ChatGPT' },
      {
        '<leader><C-t>',
        '<cmd>ChatGPTActAs<cr>',
        desc = 'ChatGPT with awesome prompt',
      },
      {
        '<leader>T',
        '<cmd>ChatGPTEditWithInstructions<cr>',
        mode = { 'x', 'n' },
        desc = 'ChatGPT with code',
      },
    },
    opts = {
      keymaps = {
        scroll_up = '<C-b>',
        scroll_down = '<C-f>',
      },
    },
    config = function()
      require('chatgpt').setup({
        keymaps = {
          close = { '<C-c>', '<Esc>' },
        },
      })
    end,
    cmd = { 'ChatGPT', 'ChatGPTEditWithInstructions' },
  },

  --     -- {
  --     --     "ThePrimeagen/refactoring.nvim",
  --     --     config = "require('plugins.refactoring')";
  --     --     dependencies = {
  --     --         { "nvim-lua/plenary.nvim" },
  --     --         { "nvim-treesitter/nvim-treesitter" },
  --     --     },
  --     -- },

  {
    'rcarriga/neotest',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'antoinemadec/FixCursorHold.nvim',
      'haydenmeade/neotest-jest',
    },
    config = function()
      require('plugins.neotest')
    end,
  },
  {
    'andythigpen/nvim-coverage',
    dependencies = 'nvim-lua/plenary.nvim',
    cmd = {
      'Coverage',
      'CoverageSummary',
      'CoverageLoad',
      'CoverageShow',
      'CoverageHide',
      'CoverageToggle',
      'CoverageClear',
    },
    config = function()
      require('coverage').setup()
    end,
  },
  -- Debug - DAP
  {
    'mfussenegger/nvim-dap',
    config = function()
      require('plugins.dap')
    end,
    keys = {
      '<Leader>da',
      '<Leader>db',
      '<Leader>dc',
      '<Leader>dd',
      '<Leader>dh',
      '<Leader>di',
      '<Leader>do',
      '<Leader>dO',
      '<Leader>dt',
    },
    dependencies = {
      'theHamsta/nvim-dap-virtual-text',
      'rcarriga/nvim-dap-ui',
      'mxsdev/nvim-dap-vscode-js',
    },
  },
  {
    'LiadOz/nvim-dap-repl-highlights',
    config = true,
    dependencies = {
      'mfussenegger/nvim-dap',
    },
    build = function()
      if not require('nvim-treesitter.parsers').has_parser('dap_repl') then
        vim.cmd(':TSInstall dap_repl')
      end
    end,
  },
  --     -- Git
  {
    'lewis6991/gitsigns.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('plugins.gitsigns')
    end,
    event = 'BufRead',
    keys = {
      { '<leader>ghd', desc = 'diff hunk' },
      { '<leader>ghp', desc = 'preview' },
      { '<leader>ghR', desc = 'reset buffer' },
      { '<leader>ghr', desc = 'reset hunk' },
      { '<leader>ghs', desc = 'stage hunk' },
      { '<leader>ghS', desc = 'stage buffer' },
      { '<leader>ght', desc = 'toggle deleted' },
      { '<leader>ghu', desc = 'undo stage' },
    },
  },
  {
    'sindrets/diffview.nvim',
    enabled = true,
    lazy = true,
    event = 'BufRead',
    config = function()
      require('plugins.diffview')
    end,
    keys = {
      {
        '<leader>gd',
        "<cmd>lua require('plugins.diffview').toggle_file_history()<CR>",
        desc = 'diff file',
      },
      {
        '<leader>gs',
        "<cmd>lua require('plugins.diffview').toggle_status()<CR>",
        desc = 'status',
      },
    },
  },
  {
    'akinsho/git-conflict.nvim',
    lazy = false,
    config = function()
      require('plugins.conflict')
    end,
    keys = {
      {
        '<leader>gcb',
        '<cmd>GitConflictChooseBoth<CR>',
        desc = 'choose both',
      },
      {
        '<leader>gcn',
        '<cmd>GitConflictNextConflict<CR>',
        desc = 'move to next conflict',
      },
      {
        '<leader>gco',
        '<cmd>GitConflictChooseOurs<CR>',
        desc = 'choose ours',
      },
      {
        '<leader>gcp',
        '<cmd>GitConflictPrevConflict<CR>',
        desc = 'move to prev conflict',
      },
      {
        '<leader>gct',
        '<cmd>GitConflictChooseTheirs<CR>',
        desc = 'choose theirs',
      },
    },
  },
  {
    'ThePrimeagen/git-worktree.nvim',
    config = function()
      require('plugins.worktree')
    end,
  },
  {
    'kdheepak/lazygit.nvim',
    cmd = {
      'LazyGit',
      'LazyGitCurrentFile',
      'LazyGitFilterCurrentFile',
      'LazyGitFilter',
    },
    keys = {
      { '<leader>gg', '<cmd>LazyGit<CR>', desc = 'lazygit' },
    },
    config = function()
      vim.g.lazygit_floating_window_scaling_factor = 1
    end,
  },
  {
    'ruifm/gitlinker.nvim',
    config = function()
      require('plugins.gitlinker')
    end,
  },
  {
    'Pocco81/TrueZen.nvim',
    cmd = { 'TZAtaraxis', 'TZMinimalist', 'TZFocus' },
    config = function()
      require('plugins.truezen')
    end,
  },
}
