local icons = require('icons')

NvimConfig = {
  colorscheme = 'aylin',
  ui = {
    float = {
      border = 'rounded',
      highlight = 'NightflyRed', -- check available by :Telescope highlights
    },
  },
  plugins = {
    dashboard = {
      fuzzy_plugin = 'telescope', -- telescope/clap/fzf
    },
    package_info = {
      enabled = false,
    },
    zen = {
      enabled = false,
      kitty_enabled = false,
    },
  },
  icons = icons,
}
