local icons = require('utils.icons')

NvimConfig = {
  colorscheme = 'aylin',
  ui = {
    float = {
      border = 'rounded',
      highlight = 'NightflyRed', -- check available by :Telescope highlights
    },
  },
  plugins = {
    completion = {
      select_first_on_enter = false,
    },
    dashboard = {
      fuzzy_plugin = 'telescope', -- telescope/clap/fzf
    },
    package_info = {
      enabled = false,
    },
    copilot = {
      enabled = true,
    },
    rooter = {
      -- Removing package.json from list in Monorepo Frontend Project can be helpful
      -- By that your live_grep will work related to whole project, not specific package
      patterns = {
        '.git',
        'package.json',
        '_darcs',
        '.bzr',
        '.svn',
        'Makefile',
      }, -- Default
    },
    zen = {
      kitty_enabled = false,
      enabled = true, -- sync after change
    },
  },
  icons = icons,
  lsp = {
    virtual_text = false, -- show virtual text (errors, warnings, info) inline messages
  },
}
