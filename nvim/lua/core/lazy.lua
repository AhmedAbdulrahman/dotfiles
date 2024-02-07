local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
local lazyIsInstalled = vim.loop.fs_stat(lazypath) ~= nil
if not lazyIsInstalled then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    '--single-branch',
    'https://github.com/folke/lazy.nvim.git',
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

require('lazy').setup('core.plugins', {
  defaults = { lazy = true },
  install = { colorscheme = { 'aylin' } },
  checker = {
    enabled = true, -- automatically check for plugin updates
		notify = false, -- done on my own to use minimum condition for less noise
		frequency = 60 * 60 * 24, -- = 1 day
  },
  diff = { cmd = "browser" }, -- view diffs with "d" in the browser
  change_detection = { notify = false },
  readme = { enabled = true },
  concurrency = 5,
  performance = {
    rtp = {
      -- Disable unused builtin plugins from neovim
      -- INFO do not disable `rplugin`, as it breaks plugins like magma.nvim
      disabled_plugins = {
        "matchparen",
				"matchit",
				"netrwPlugin",
				"man",
				"tutor",
				"health",
				"gzip",
				"zipPlugin",
				"tarPlugin",
      },
    },
  },
  debug = false,
  ui = {
    wrap = true,
    pills = false,
    size = { width = 1, height = 0.93 }, -- not full height, so search is visible
    border = NvimConfig.ui.float.border,
    icons = {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

vim.keymap.set('n', '<leader>/l', '<cmd>:Lazy<cr>')
