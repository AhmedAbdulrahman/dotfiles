return {
  -- Add subdirectories here
  -- {
  --   { import = "plugins.ai" },
  --   { import = "plugins.languages" },
  -- },

  -- ╭─────────────────────────────────────────────────────────╮
  -- │ General plugins                                         │
  -- ╰─────────────────────────────────────────────────────────╯
  { 'nvim-lua/plenary.nvim' },
  { "AndrewRadev/switch.vim",     lazy = false },
  { "tpope/vim-repeat",           lazy = false },
  { "tpope/vim-speeddating",      lazy = false },
  { "dhruvasagar/vim-table-mode", lazy = false },
  { 'RRethy/vim-illuminate' },
  { 'nvim-lua/popup.nvim' },
  {
    "airblade/vim-rooter",
    event = "VeryLazy",
    config = function()
      vim.g.rooter_patterns = NvimConfig.plugins.rooter.patterns
      vim.g.rooter_silent_chdir = 1
      vim.g.rooter_resolve_links = 1
    end,
  },
  {
    'LudoPinelli/comment-box.nvim',
    keys = {
      { "<leader>ac", "<cmd>lua require('comment-box').llbox()<CR>", desc = "comment box" },
      { "<leader>ac", "<cmd>lua require('comment-box').llbox()<CR>", mode = "v", desc = "comment box" },
    }
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = true,
  },
  {
    'echasnovski/mini.align',
    version = '*',
    config = function()
      require('mini.align').setup()
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
    'andweeb/presence.nvim',
    config = function()
      require('presence').setup({
        buttons = false,
      })
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
  {
    'nanotee/sqls.nvim',
    ft = { 'sql', 'pgsql' },
    module = true,
  },
  {
    "mistricky/codesnap.nvim",
    build = "make",
    cmd = "CodeSnapPreviewOn",
    opts = {
      watermark = nil
    }
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
  {
    'AckslD/nvim-neoclip.lua',
    dependencies = {
      {'kkharji/sqlite.lua', module = 'sqlite'},
      -- you'll need at least one of these
      { 'nvim-telescope/telescope.nvim' },
      -- {'ibhagwan/fzf-lua'},
    },
    config = function()
      require('neoclip').setup()
    end,
  },
}
