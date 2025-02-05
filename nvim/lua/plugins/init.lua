return {
  -- Add subdirectories here
  {
    { import = "plugins.ai" },
    { import = "plugins.languages" },
  },

  -- ╭─────────────────────────────────────────────────────────╮
  -- │ General plugins                                         │
  -- ╰─────────────────────────────────────────────────────────╯
  { "AndrewRadev/switch.vim",     lazy = false },
  { "tpope/vim-repeat",           lazy = false },
  { "tpope/vim-speeddating",      lazy = false },

    -- Detect tabstop and shiftwidth automatically
  { 'tpope/vim-sleuth',            lazy = false },
  { 'RRethy/vim-illuminate' },
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
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = true,
  },
  {
    -- Discord Rich Presence for Neovim
    'andweeb/presence.nvim',
    config = function()
      require('presence').setup({
        buttons = false,
      })
    end,
  },
   -- Enhanced f/t motions for Leap (better "f" and "t")
   {
    'ggandor/flit.nvim',
    config = true,
    dependencies = {
      'tpope/vim-repeat',
    },
  },
  -- Display javascript import costs inside of neovim
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
  -- Clipboard manager neovim plugin with telescope integration
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
