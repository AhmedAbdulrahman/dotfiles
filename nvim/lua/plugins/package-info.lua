local keymap = vim.keymap
local silent = { silent = true }
local icons = NvimConfig.icons

require('package-info').setup({
  colors = {
    up_to_date = '#3C4048', -- Text color for up to date package virtual text
    outdated = '#fc514e', -- Text color for outdated package virtual text
  },
  icons = {
    enable = true, -- Whether to display icons
    style = {
      up_to_date = icons.checkSquare, -- Icon for up to date packages
      outdated = icons.gitRemove, -- Icon for outdated packages
    },
  },
  autostart = true, -- Whether to autostart when `package.json` is opened
  hide_up_to_date = true, -- It hides up to date versions when displaying virtual text
  hide_unstable_versions = false, -- It hides unstable versions from version list e.g next-11.1.3-canary3

  -- Can be `npm` or `yarn`. Used for `delete`, `install` etc...
  -- The plugin will try to auto-detect the package manager based on
  -- `yarn.lock` or `package-lock.json`. If none are found it will use the
  -- provided one,                              if nothing is provided it will use `yarn`
  package_manager = 'yarn',
})

-- Show package versions
keymap.set('n', '<leader>ns', ":lua require('package-info').show()<CR>", silent)

-- Hide package versions
keymap.set('n', '<leader>nc', ":lua require('package-info').hide()<CR>", silent)

-- Update package on line
keymap.set('n', '<leader>nu', ":lua require('package-info').update()<CR>", silent)

-- Delete package on line
keymap.set('n', '<leader>nd', ":lua require('package-info').delete()<CR>", silent)

-- Install a new package
keymap.set('n', '<leader>ni', ":lua require('package-info').install()<CR>", silent)

-- Reinstall dependencies
keymap.set('n', '<leader>nr', ":lua require('package-info').reinstall()<CR>", silent)

-- Install a different package version
keymap.set(
  'n',
  '<leader>np',
  ":lua require('package-info').change_version()<CR>",
  opts
)
