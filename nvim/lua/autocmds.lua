--	┏━┓╻ ╻╺┳╸┏━┓┏━╸┏┳┓╺┳┓
--	┣━┫┃ ┃ ┃ ┃ ┃┃  ┃┃┃ ┃┃
--	╹ ╹┗━┛ ╹ ┗━┛┗━╸╹ ╹╺┻┛

-- luacheck: max line length 150

vim.api.nvim_create_augroup('AutoUpdatePlugins', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = 'plugins.lua',
  command = 'source <afile> | PackerSync',
  group = 'AutoUpdatePlugins',
})
vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = 'plugins.lua',
  command = 'source <afile> | PackerCompile',
  group = 'AutoUpdatePlugins',
})

vim.api.nvim_create_augroup('Highlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  command = "silent! lua vim.highlight.on_yank() {higroup='IncSearch', timeout=400}",
  group = 'Highlight',
})

vim.api.nvim_create_augroup('LspNodeModules', { clear = true })
vim.api.nvim_create_autocmd('BufRead', {
  pattern = '*/node_modules/*',
  command = 'lua vim.diagnostic.disable(0)',
  group = 'LspNodeModules',
})
vim.api.nvim_create_autocmd('BufNewFile', {
  pattern = '*/node_modules/*',
  command = 'lua vim.diagnostic.disable(0)',
  group = 'LspNodeModules',
})
vim.api.nvim_create_autocmd('BufEnter,WinEnter', {
  pattern = '*/node_modules/*',
  command = 'LspStop',
  group = 'LspNodeModules',
})
vim.api.nvim_create_autocmd('BufLeave', {
  pattern = '*/node_modules/*',
  command = 'LspStart',
  group = 'LspNodeModules',
})
vim.api.nvim_create_autocmd(
  'BufEnter,WinEnte',
  { pattern = '*.min.*', command = 'LspStop', group = 'LspNodeModules' }
)
vim.api.nvim_create_autocmd(
  'BufLeave',
  { pattern = '*.min.*', command = 'LspStop', group = 'LspNodeModules' }
)

vim.api.nvim_create_augroup('Spell', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = '*/spell/*.add',
  command = 'silent! :mkspell! %',
  group = 'Spell',
})

vim.api.nvim_create_augroup('NvimTree', { clear = true })
vim.api.nvim_create_autocmd('BufWinEnter', {
  pattern = '*/spell/*.add',
  command = 'let &l:statusline = " Explorer"',
  group = 'NvimTree',
})

vim.api.nvim_create_augroup('Startified', { clear = true })
vim.api.nvim_create_autocmd('User', {
  pattern = 'Startified',
  command = 'setlocal cursorline',
  group = 'Startified',
})

vim.api.nvim_create_augroup('__myautocmds__', { clear = true })
-- Save the current buffer after any changes.
vim.api.nvim_create_autocmd('InsertLeave,TextChanged', {
  pattern = '*',
  command = 'nnoremap <buffer><leader>p :call autocmds#savebuffer#()',
  group = '__myautocmds__',
})
--  Set current working directory.
vim.api.nvim_create_autocmd('VimEnter', {
  pattern = '*',
  command = 'nnoremap <buffer><leader>p :call autocmds#setroot#()',
  group = '__myautocmds__',
})
-- Automatically make splits equal in size
vim.api.nvim_create_autocmd(
  'VimResized',
  { pattern = '*', command = 'wincmd =', group = '__myautocmds__' }
)
-- Disable paste mode on leaving insert mode.
vim.api.nvim_create_autocmd(
  'InsertLeave',
  { pattern = '*', command = 'set nopaste', group = '__myautocmds__' }
)
-- taken from https://github.com/jeffkreeftmeijer/vim-numbertoggle/blob/cfaecb9e22b45373bb4940010ce63a89073f6d8b/plugin/number_toggle.vim
vim.api.nvim_create_autocmd('BufLeave,FocusLost,InsertEnter,WinLeave', {
  pattern = '*',
  command = 'if &nu | set nornu | endif',
  group = '__myautocmds__',
})
vim.api.nvim_create_autocmd('BufEnter,FocusGained,InsertLeave,WinEnter', {
  pattern = '*',
  command = 'if &nu | set rnu | endif',
  group = '__myautocmds__',
})
-- Automatically make splits equal in size
vim.api.nvim_create_autocmd('BufReadPre', {
  pattern = '*',
  command = 'lua require("functions").disable_heavy_plugins()',
  group = '__myautocmds__',
})
vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  command = 'lua require("functions").quit_on_q()',
  group = '__myautocmds__',
})
vim.api.nvim_create_autocmd('BufWritePost,BufLeave,WinLeave', {
  pattern = '?*',
  command = 'lua require("functions").mkview()',
  group = '__myautocmds__',
})
vim.api.nvim_create_autocmd('BufWinEnter', {
  pattern = '?*',
  command = 'lua require("functions").loadview()',
  group = '__myautocmds__',
})
vim.api.nvim_create_autocmd('BufEnter,BufWinEnter,BufRead,BufNewFile', {
  pattern = 'bookmarks.{md,txt}',
  command = 'hi! link mkdLink Normal | set concealcursor-=n',
  group = '__myautocmds__',
})
-- Project specific override
vim.api.nvim_create_autocmd('BufRead,BufNewFile', {
  pattern = '*',
  command = 'lua require("functions").source_project_config()',
  group = '__myautocmds__',
})
vim.api.nvim_create_autocmd('DirChanged', {
  pattern = '*',
  command = 'lua require("functions").source_project_config()',
  group = '__myautocmds__',
})

-- Attach specific keybindings in which-key for specific filetypes
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.md",
  callback = function() require('plugins.which-key').attach_markdown(0) end,
  group = '__myautocmds__',
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.ts", "*.tsx" },
  callback = function() require('plugins.which-key').attach_typescript(0) end,
  group = '__myautocmds__',
})

-- Winbar
vim.api.nvim_create_autocmd({ "CursorMoved", "BufWinEnter", "BufFilePost" }, {
  callback = function()
    local winbar_filetype_exclude = {
      "help",
      "startify",
      "dashboard",
      "packer",
      "neogitstatus",
      "NvimTree",
      "Trouble",
      "alpha",
      "lir",
      "Outline",
      "spectre_panel",
      "toggleterm",
    }

    if vim.tbl_contains(winbar_filetype_exclude, vim.bo.filetype) then
      vim.opt_local.winbar = nil
      return
    end

    local value = require("winbar").gps()

    if value == nil then
      value = require("winbar").filename()
    end

    vim.opt_local.winbar = value
  end,
  group = '__myautocmds__',
})
