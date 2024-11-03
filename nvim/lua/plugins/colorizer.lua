return {
  {
    'NvChad/nvim-colorizer.lua',
    event = "VeryLazy",
    config = function()
      require('colorizer').setup({
        filetypes = {
          'html',
          'css',
          'javascript',
          'typescript',
          'typescriptreact',
          'javascriptreact',
          'lua',
        },
        user_default_options = {
          mode = 'background',
          tailwind = false, -- Enable tailwind colors
          names = false,
          rgb_fn = true,
          hsl_fn = true,
          RGB = true,
          RRGGBB = true,
        },
        buftypes = {
          "*",
          "!prompt",
          "!popup",
        },
      })
    end,
  },
}
