local execute = vim.api.nvim_command
local packer = nil
-- check if packer is installed (~/.local/share/nvim/site/pack)
local install_path = vim.fn.stdpath('data')
  .. '/site/pack/packer/start/packer.nvim'
local compile_path = install_path .. '/plugin/packer_compiled.lua'
local is_installed = vim.fn.empty(vim.fn.glob(install_path)) == 0

local function init()
  if not is_installed then
    if vim.fn.input('Install packer.nvim? (y for yes) ') == 'y' then
      execute(
        '!git clone https://github.com/wbthomason/packer.nvim ' .. install_path
      )
      execute('packadd packer.nvim')
      print('Installed packer.nvim.')
      is_installed = 1
    end
  end

  if not is_installed then
    return
  end
  if packer == nil then
    packer = require('packer')
    packer.init({
      -- we don't want the compilation file in '~/.config/nvim'
      disable_commands = true,
      compile_path = compile_path,
    })
  end

  local use = packer.use
  packer.reset()

  -- Packer can manage itself
  use('wbthomason/packer.nvim')

  -- Needed to load first
  use({ 'lewis6991/impatient.nvim' })
  use({ 'nathom/filetype.nvim' })
  use({ 'nvim-lua/plenary.nvim' })
  use({ 'kyazdani42/nvim-web-devicons' })
  --   use {'glepnir/dashboard-nvim', config = "require('plugins.dashboard')"}
  use({
    'mhinz/vim-startify',
    event = 'BufEnter',
    config = "require('plugins.startify')",
  })

  -- Themes
  use({ 'bluz71/vim-nightfly-guicolors' })
  use({ 'folke/tokyonight.nvim' })
  use({ 'AhmedAbdulrahman/aylin.vim', branch = '0.5-nvim' })

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

  -- Telescope
  use({ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' })
  use({ 'cljoly/telescope-repo.nvim' })
  use({
    'nvim-lua/telescope.nvim',
    requires = {
      'nvim-telescope/telescope-ui-select.nvim',
      'nvim-telescope/telescope-fzf-native.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-lua/popup.nvim',
    },
    config = "require('plugins.telescope')",
  })

  -- LSP Base
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

  use({
    'jose-elias-alvarez/null-ls.nvim',
    config = "require('lsp.null-ls')",
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

  -- LSP Addons
  use({
    'williamboman/nvim-lsp-installer',
    event = 'BufEnter',
    after = 'cmp-nvim-lsp',
    config = "require('lsp.installer')",
  })
  use({
    'stevearc/dressing.nvim',
    requires = 'MunifTanjim/nui.nvim',
    config = "require('plugins.dressing')",
  })
  use({ 'onsails/lspkind-nvim' })
  use({ 'folke/lsp-trouble.nvim', config = "require('plugins.trouble')" })
  use({ 'nvim-lua/popup.nvim' })
  use({
    'SmiteshP/nvim-gps',
    config = "require('plugins.gps')",
    after = 'nvim-treesitter',
  })
  use({ 'jose-elias-alvarez/nvim-lsp-ts-utils', after = { 'nvim-treesitter' } })

  -- Formatter
  use({ 'mhartington/formatter.nvim', config = "require('plugins.formatter')" })
  -- General
  use({
    'iamcco/markdown-preview.nvim',
    run = 'cd app && npm install',
    setup = function()
      vim.g.mkdp_filetypes = { 'markdown' }
    end,
    ft = { 'markdown' },
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
  use({
    'akinsho/nvim-toggleterm.lua',
    config = "require('plugins.toggleterm')",
  })
  use({ 'tpope/vim-repeat' })
  use({ 'tpope/vim-speeddating' })
  use({ 'tpope/vim-surround' })
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
    'norcalli/nvim-colorizer.lua',
    config = "require('plugins.colorizer')",
  })
  use({
    'L3MON4D3/LuaSnip',
    requires = { 'rafamadriz/friendly-snippets' },
    after = 'cmp_luasnip',
  })

  -- Nvim Tree / Rooter
  use({ 'kyazdani42/nvim-tree.lua', config = "require('plugins.tree')" })
  use({
    'airblade/vim-rooter',
    setup = function()
      vim.g.rooter_patterns = NvimConfig.plugins.rooter.patterns
    end,
  })

  -- Debug
  -- TODO: Configure dap
  -- use {'rcarriga/nvim-dap-ui', requires = {"mfussenegger/nvim-dap"}}
  -- use {'mfussenegger/nvim-dap', config = "require('plugins.dap')"}

  -- Git
  use({
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = "require('plugins.gitsigns')",
    event = 'BufRead',
  })
  use({ 'sindrets/diffview.nvim' })
end

local plugins = setmetatable({}, {
  __index = function(_, key)
    init()
    return packer[key]
  end,
})

return plugins
