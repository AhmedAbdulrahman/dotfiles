local map = require('utils.map')
local opts = { noremap = true, silent = true }
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
map.nnoremap('<leader>ns', ":lua require('package-info').show()<CR>", opts)

-- Hide package versions
map.nnoremap('<leader>nc', ":lua require('package-info').hide()<CR>", opts)

-- Update package on line
map.nnoremap('<leader>nu', ":lua require('package-info').update()<CR>", opts)

-- Delete package on line
map.nnoremap('<leader>nd', ":lua require('package-info').delete()<CR>", opts)

-- Install a new package
map.nnoremap('<leader>ni', ":lua require('package-info').install()<CR>", opts)

-- Reinstall dependencies
map.nnoremap('<leader>nr', ":lua require('package-info').reinstall()<CR>", opts)

-- Install a different package version
map.nnoremap(
  '<leader>np',
  ":lua require('package-info').change_version()<CR>",
  opts
)
