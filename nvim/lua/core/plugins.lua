return {
  { 'nvim-lua/plenary.nvim' },
  { 'kyazdani42/nvim-web-devicons' },
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

  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    event = 'BufReadPre',
    config = function()
      require('plugins.treesitter')
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'RRethy/nvim-treesitter-textsubjects',
      -- 'romgrk/nvim-treesitter-context',
      -- 'JoosepAlviste/nvim-ts-context-commentstring',
      -- 'nvim-treesitter/playground',
      {
        'm-demare/hlargs.nvim',
        config = function()
          require('hlargs').setup({ color = '#F7768E' })
        end,
      },
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
      { 'dhruvmanila/telescope-bookmarks.nvim' },
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
  --  { 'nvim-pack/nvim-spectre' },
  {
    'kyazdani42/nvim-tree.lua',
    lazy = false,
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
    'williamboman/mason.nvim',
    cmd = 'Mason',
  },
  { 'williamboman/mason-lspconfig.nvim' },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      {
        'j-hui/fidget.nvim',
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
      'hrsh7th/cmp-nvim-lsp-signature-help',
      { 'tzachar/cmp-tabnine', build = './install.sh' },
      {
        'David-Kunz/cmp-npm',
        config = function()
          require('plugins.cmp-npm')
        end,
      },
      {
        'zbirenbaum/copilot-cmp',
        disable = not NvimConfig.plugins.copilot.enabled,
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
    'ChristianChiarulli/nvim-gps',
    branch = 'text_hl',
    config = function()
      require('plugins.gps')
    end,
  },
  { 'jose-elias-alvarez/typescript.nvim' },
  {
    'axelvc/template-string.nvim',
    config = function()
      require('template-string').setup()
    end,
  },
  {
    'lvimuser/lsp-inlayhints.nvim',
    branch = 'anticonceal',
    config = function()
      require('lsp-inlayhints').setup()
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
  { 'AndrewRadev/switch.vim', lazy = false },
  { 'AndrewRadev/splitjoin.vim' },
  {
    'numToStr/Comment.nvim',
    branch = 'jsx',
    config = function()
      require('plugins.comment')
    end,
  },
  { 'LudoPinelli/comment-box.nvim' },
  {
    'akinsho/nvim-toggleterm.lua',
    config = function()
      require('plugins.toggleterm')
    end,
    lazy = false,
  },
  { 'tpope/vim-repeat' },
  { 'tpope/vim-speeddating' },
  {
    'Shatur/neovim-session-manager',
    lazy = false,
    config = function()
      require('plugins.session-manager')
    end,
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
    'mg979/vim-visual-multi',
    config = function()
      vim.g.VM_leader = ';'
    end,
  },
  {
    'echasnovski/mini.nvim',
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
    'ggandor/lightspeed.nvim',
    config = function()
      require('plugins.lightspeed')
    end,
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
    'romgrk/barbar.nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      require('plugins.barbar')
    end,
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
  { 'p00f/nvim-ts-rainbow' },
  { 'mattn/emmet-vim' },
  { 'potatoesmaster/i3-vim-syntax' },
  {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('plugins.indent')
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
  {
    'L3MON4D3/LuaSnip',
    dependencies = {
      'rafamadriz/friendly-snippets',
      config = function()
        require('luasnip.loaders.from_vscode').lazy_load({
          -- I maintain my own snippets for these languages
          exclude = {
            'rust',
          },
        })
      end,
    },
    opts = {
      history = true,
      delete_check_events = 'TextChanged',
    },
    config = function()
      require('plugins.luasnip')
    end,
  },
  {
    'zbirenbaum/copilot.lua',
    disable = not NvimConfig.plugins.copilot.enabled,
    event = 'InsertEnter',
    config = function()
      require('plugins.copilot')
    end,
  },
  {
    'jackMort/ChatGPT.nvim',
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
      require('chatgpt').setup()
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

  --     -- Debug
  --     { 'theHamsta/nvim-dap-virtual-text' },
  --     { 'rcarriga/nvim-dap-ui' },
  --     { 'mfussenegger/nvim-dap', config = function() require('plugins.dap') end },

  --     -- Git
  {
    'lewis6991/gitsigns.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('plugins.gitsigns')
    end,
    event = 'BufRead',
  },
  {
    'sindrets/diffview.nvim',
    event = 'BufRead',
    config = function()
      require('plugins.diffview')
    end,
  },
  --    { 'akinsho/git-conflict.nvim', config = function() require('plugins.git.conflict') end },
  {
    'ThePrimeagen/git-worktree.nvim',
    config = function()
      require('plugins.worktree')
    end,
  },
  { 'kdheepak/lazygit.nvim', lazy = false },
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
