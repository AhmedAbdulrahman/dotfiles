--	┏━┓╻ ╻╺┳╸┏━┓┏━╸┏┳┓╺┳┓
--	┣━┫┃ ┃ ┃ ┃ ┃┃  ┃┃┃ ┃┃
--	╹ ╹┗━┛ ╹ ┗━┛┗━╸╹ ╹╺┻┛

-- luacheck: max line length 150

local au = require('utils.au')

au.group('__myautocmds__', {
  {
    'TextYankPost',
    '*',
    'silent! lua vim.highlight.on_yank() {higroup="IncSearch", timeout=400}',
  },
  { 'BufWritePost', 'plugins.lua', [[source <afile> | PackerCompile]] },
  { 'BufWritePost', 'plugins.lua', [[source <afile> | PackerSync]] },
  { 'BufRead', '*/node_modules/*', [[lua vim.diagnostic.disable(0)]] },
  { 'BufNewFile', '*/node_modules/*', [[lua vim.diagnostic.disable(0)]] },
  -- { 'BufWritePost', '*', 'silent! FormatWrite' },
  { 'BufWritePost', '*/spell/*.add', 'silent! :mkspell! %' },
  { 'BufWinEnter', 'NvimTree', 'let &l:statusline = " Explorer"' },
  { 'User', 'Startified', 'setlocal cursorline' },
  { 'BufWinEnter', 'NvimTree', 'let &l:statusline = " Explorer"' },
  { 'User', 'Startified', 'setlocal cursorline' },
  -- Save the current buffer after any changes.
  {
    'InsertLeave,TextChanged',
    '*',
    'nnoremap <buffer><leader>p :call autocmds#savebuffer#()',
  },
  --  Set current working directory.
  { 'VimEnter', '*', 'nnoremap <buffer><leader>p :call autocmds#setroot#()' },
  -- Automatically make splits equal in size
  { 'VimResized', '*', 'wincmd =' },
  -- Disable paste mode on leaving insert mode.
  { 'InsertLeave', '*', 'set nopaste' },
  -- taken from https://github.com/jeffkreeftmeijer/vim-numbertoggle/blob/cfaecb9e22b45373bb4940010ce63a89073f6d8b/plugin/number_toggle.vim
  {
    'BufLeave,FocusLost,InsertEnter,WinLeave',
    '*',
    'if &nu | set nornu | endif',
  },
  {
    'BufEnter,FocusGained,InsertLeave,WinEnter',
    '*',
    'if &nu | set rnu   | endif',
  },
  { 'BufEnter,WinEnter', '*/node_modules/*', ':LspStop' },
  { 'BufLeave', '*/node_modules/*', ':LspStart' },
  { 'BufEnter,WinEnter', '*.min.*', ':LspStop' },
  { 'BufLeave', '*.min.*', ':LspStart' },
  {
    'BufReadPre',
    '*',
    'lua require("functions").disable_heavy_plugins()',
  },
  { 'FileType', '*', 'lua require("functions").quit_on_q()' },
  {
    'BufWritePost,BufLeave,WinLeave',
    '?*',
    'lua require("functions").mkview()',
  },
  { 'BufWinEnter', '?*', 'lua require("functions").loadview()' },
  {
    'BufEnter,BufWinEnter,BufRead,BufNewFile',
    'bookmarks.{md,txt}',
    'hi! link mkdLink Normal | set concealcursor-=n',
  },
  -- Project specific override
  {
    'BufRead,BufNewFile',
    '*',
    'lua require("functions").source_project_config()',
  },
  {
    'DirChanged',
    '*',
    'lua require("functions").source_project_config()',
  },
})
