local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local compile_path = install_path .. '/plugin/packer_compiled.lua'
local packer_bootstrap = nil

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  })
end

return require('packer').startup({
  function(use)
    -- Packer can manage itself
    use('wbthomason/packer.nvim')

    -- Needed to load first
    use({ 'lewis6991/impatient.nvim' })
    use({
      'nathom/filetype.nvim',
      config = "require('plugins.filetype')",
    })
    use({ 'nvim-lua/plenary.nvim' })
    use({ 'kyazdani42/nvim-web-devicons' })
    use({
      'mhinz/vim-startify',
      event = 'BufEnter',
      config = "require('plugins.startify')",
    })

    -- Themes
    use({ 'AhmedAbdulrahman/aylin.vim', branch = '0.5-nvim' })
    use({ 'arzg/vim-substrata' })

    -- Treesitter
    use({
      'nvim-treesitter/nvim-treesitter',
      requires = {
        'romgrk/nvim-treesitter-context',
        'JoosepAlviste/nvim-ts-context-commentstring',
        'nvim-treesitter/playground',
      },
      run = ':TSUpdate',
      config = "require('plugins.treesitter')",
    })
    use({
      'nvim-treesitter/nvim-treesitter-textobjects',
      after = { 'nvim-treesitter' },
    })
    use({ 'RRethy/nvim-treesitter-textsubjects', after = { 'nvim-treesitter' } })
    use({
      'm-demare/hlargs.nvim',
      config = function()
        require('hlargs').setup({ color = '#F7768E' })
      end,
    })

    -- 🔭 Navigating (Telescope/Tree/Refactor)
    use({ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' })
    use({
      'nvim-telescope/telescope.nvim',
      config = "require('plugins.telescope')",
      requires = {
        { 'nvim-lua/popup.nvim' },
        { 'nvim-lua/plenary.nvim' },
        { 'nvim-telescope/telescope-fzf-native.nvim' },
      },
    })
    -- Telescope Extensions
    use({ 'cljoly/telescope-repo.nvim' })
    use({ 'kevinhwang91/nvim-bqf', ft = 'qf' })
    use({ 'nvim-telescope/telescope-file-browser.nvim' })
    use({ 'nvim-telescope/telescope-ui-select.nvim' })
    use({ 'dhruvmanila/telescope-bookmarks.nvim' })
    use({ 'nvim-telescope/telescope-github.nvim' })
    -- Trying command palette
    use({ 'LinArcX/telescope-command-palette.nvim' })
    use({
      'AckslD/nvim-neoclip.lua',
      config = function()
        require('neoclip').setup()
      end,
    })
    use('jvgrootveld/telescope-zoxide')
    use({ 'nvim-pack/nvim-spectre' })
    use({ 'kyazdani42/nvim-tree.lua', config = "require('plugins.tree')" })
    use({
      'gbprod/stay-in-place.nvim',
      config = function()
        require('stay-in-place').setup({})
      end,
    })
    -- LSP Base
    use({ 'williamboman/nvim-lsp-installer' })
    use({
      'neovim/nvim-lspconfig',
      requires = {
        { 'stevearc/aerial.nvim' },
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
        {
          'folke/todo-comments.nvim',
          config = function()
            require('todo-comments').setup({})
          end,
        },
        { 'folke/lua-dev.nvim' },
      },
    })

    -- LSP Cmp
    use({
      'hrsh7th/nvim-cmp',
      event = 'InsertEnter',
      config = "require('plugins.cmp')",
    })
    use({ 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' })
    use({ 'hrsh7th/cmp-nvim-lsp', after = 'cmp-nvim-lua' })
    use({ 'hrsh7th/cmp-buffer', after = 'cmp-nvim-lsp' })
    use({ 'hrsh7th/cmp-path', after = 'cmp-buffer' })
    use({ 'hrsh7th/cmp-calc', after = 'cmp-path' })
    use({
      'tzachar/cmp-tabnine',
      run = './install.sh',
      requires = 'hrsh7th/nvim-cmp',
      after = 'cmp-calc',
    })
    use({
      'David-Kunz/cmp-npm',
      after = 'cmp-tabnine',
      requires = 'nvim-lua/plenary.nvim',
      config = "require('plugins.cmp-npm')",
    })
    use({ 'saadparwaiz1/cmp_luasnip', after = 'cmp-npm' })
    use({ 'hrsh7th/cmp-nvim-lsp-signature-help', after = 'cmp_luasnip' })

    use({
      'stevearc/dressing.nvim',
      requires = 'MunifTanjim/nui.nvim',
      config = "require('plugins.dressing')",
    })
    use({ 'onsails/lspkind-nvim' })
    use({ 'folke/lsp-trouble.nvim', config = "require('plugins.trouble')" })
    use({ 'nvim-lua/popup.nvim' })
    use({
      'ChristianChiarulli/nvim-gps',
      branch = 'text_hl',
      config = "require('plugins.gps')",
      after = 'nvim-treesitter',
    })
    use({ 'jose-elias-alvarez/typescript.nvim' })
    -- Formatter
    use({
      'mhartington/formatter.nvim',
      config = "require('plugins.formatter')",
    })
    -- General
    use({
      'iamcco/markdown-preview.nvim',
      run = function()
        vim.fn['mkdp#util#install']()
      end,
    })
    use({
      'airblade/vim-rooter',
      setup = function()
        vim.g.rooter_patterns = NvimConfig.plugins.rooter.patterns
      end,
    })
    use({ 'AndrewRadev/switch.vim' })
    use({ 'AndrewRadev/splitjoin.vim' })
    use({
      'numToStr/Comment.nvim',
      requires = {
        'JoosepAlviste/nvim-ts-context-commentstring',
      },
      keys = { 'gc', 'gx' },
      config = "require('plugins.comment')",
      after = 'nvim-treesitter',
    })
    use({ 'LudoPinelli/comment-box.nvim' })
    use({
      'akinsho/nvim-toggleterm.lua',
      branch = 'main',
      config = "require('plugins.toggleterm')",
    })
    use({ 'tpope/vim-repeat' })
    use({ 'tpope/vim-speeddating' })
    use({
      'kylechui/nvim-surround',
      config = function()
        require('nvim-surround').setup({})
      end,
    })
    use({
      'sunjon/shade.nvim',
      config = function()
        require('shade').setup()
        require('shade').toggle()
      end,
    })
    use({ 'dhruvasagar/vim-table-mode' })
    use({ 'mg979/vim-visual-multi' })
    use({ 'junegunn/vim-easy-align' })
    use({ 'nacro90/numb.nvim', config = "require('plugins.numb')" })
    use({ 'folke/todo-comments.nvim' })
    use({
      'folke/zen-mode.nvim',
      config = "require('plugins.zen')",
      disable = not NvimConfig.plugins.zen.enabled,
    })
    use({
      'folke/twilight.nvim',
      config = function()
        require('twilight').setup({})
      end,
      disable = not NvimConfig.plugins.zen.enabled,
    })
    use({
      'ggandor/lightspeed.nvim',
      config = "require('plugins.lightspeed')",
    })
    use({
      'folke/which-key.nvim',
      config = "require('plugins.which-key')",
      event = 'BufWinEnter',
    })
    use({
      'nvim-lualine/lualine.nvim',
      config = "require('plugins.lualine')",
      event = 'VimEnter',
      after = 'nvim-web-devicons',
    })
    use({ 'romgrk/barbar.nvim', config = "require('plugins.barbar')" })
    use({ 'antoinemadec/FixCursorHold.nvim' }) -- Needed while issue https://github.com/neovim/neovim/issues/12587 is still open
    use({ 'rcarriga/nvim-notify' })
    use({
      'vuki656/package-info.nvim',
      disable = not NvimConfig.plugins.package_info.enabled,
    })
    use({ 'RRethy/vim-illuminate' })

    -- Snippets & Language & Syntax
    use({
      'windwp/nvim-autopairs',
      after = { 'nvim-treesitter', 'nvim-cmp' },
      config = "require('plugins.autopairs')",
    })
    --   use {'p00f/nvim-ts-rainbow', after = {'nvim-treesitter'}}
    use({ 'mattn/emmet-vim' })
    use({ 'potatoesmaster/i3-vim-syntax' })
    use({
      'lukas-reineke/indent-blankline.nvim',
      config = "require('plugins.indent')",
    })
    use({
      'NvChad/nvim-colorizer.lua',
      config = "require('plugins.colorizer')",
    })
    use({
      'L3MON4D3/LuaSnip',
      requires = { 'rafamadriz/friendly-snippets' },
      after = 'cmp_luasnip',
    })
    -- Debug
    use({ 'theHamsta/nvim-dap-virtual-text' })
    use({ 'rcarriga/nvim-dap-ui', requires = { 'mfussenegger/nvim-dap' } })
    use({ 'mfussenegger/nvim-dap', config = "require('plugins.dap')" })

    -- Git
    use({
      'lewis6991/gitsigns.nvim',
      requires = { 'nvim-lua/plenary.nvim' },
      config = "require('plugins.gitsigns')",
      event = 'BufRead',
    })
    use({ 'sindrets/diffview.nvim' })
    use({
      'akinsho/git-conflict.nvim',
      config = function()
        require('git-conflict').setup()
      end,
    })

    use({
      'Pocco81/TrueZen.nvim',
      cmd = {
        'TZAtaraxis',
        'TZMinimalist',
        'TZFocus',
      },
      config = "require('plugins.truezen')",
    })

    if packer_bootstrap then
      require('packer').sync()
    end
  end,
  config = {
    compile_path = compile_path,
    disable_commands = true,
    max_jobs = 50,
    display = {
      open_fn = function()
        return require('packer.util').float({ border = 'rounded' })
      end,
    },
  },
})
