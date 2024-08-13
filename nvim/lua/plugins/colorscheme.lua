return {
  {
    'AhmedAbdulrahman/aylin.vim',
    lazy = false,
    branch = '0.5-nvim',
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      vim.opt.background = 'dark'
      vim.cmd('colorscheme ' .. NvimConfig.colorscheme)
    end,
  },
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
  { 'arzg/vim-substrata' },
}
