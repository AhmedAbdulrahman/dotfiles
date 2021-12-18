--	┏━┓╻ ╻╺┳╸┏━┓┏━╸┏┳┓╺┳┓
--	┣━┫┃ ┃ ┃ ┃ ┃┃  ┃┃┃ ┃┃
--	╹ ╹┗━┛ ╹ ┗━┛┗━╸╹ ╹╺┻┛

local au = require('_.utils.au')

au.augroup('__myautocmds__', function()
  -- Briefly highlight yanked region.
  au.autocmd(
    'TextYankPost',
    '*',
    [[silent! lua vim.highlight.on_yank {higroup = "Visual", timeout = 100, on_visual = false}]]
  )

  -- Save the current buffer after any changes.
  au.autocmd(
    'InsertLeave,TextChanged',
    '*',
    [[nnoremap <buffer><leader>p :call ahmed#autocmds#savebuffer#()]]
  )
  --  Set current working directory.
  au.autocmd(
    'VimEnter',
    '*',
    [[nnoremap <buffer><leader>p :call ahmed#autocmds#setroot#()]]
  )
  -- Automatically make splits equal in size
  au.autocmd('VimResized', '*', 'wincmd =')

  -- Disable paste mode on leaving insert mode.
  au.autocmd('InsertLeave', '*', 'set nopaste')

  -- taken from https://github.com/jeffkreeftmeijer/vim-numbertoggle/blob/cfaecb9e22b45373bb4940010ce63a89073f6d8b/plugin/number_toggle.vim
  au.autocmd(
    'BufEnter,FocusGained,InsertLeave,WinEnter',
    '*',
    [[if &nu | set rnu   | endif]]
  )
  au.autocmd(
    'BufLeave,FocusLost,InsertEnter,WinLeave',
    '*',
    [[if &nu | set nornu | endif]]
  )

  -- See https://github.com/neovim/neovim/issues/7994
  au.autocmd('InsertLeave', '*', 'set nopaste')

  au.autocmd(
    'BufEnter,BufWinEnter,BufRead,BufNewFile',
    'bookmarks.{md,txt}',
    'hi! link mkdLink Normal | set concealcursor-=n'
  )

  if vim.fn.executable 'direnv' then
    au.autocmd('BufWritePost', '.envrc ', 'silent !direnv allow %')
  end

  au.autocmd(
    'BufReadPre',
    '*',
    [[lua require'_.autocmds'.disable_heavy_plugins()]]
  )
  au.autocmd(
    'BufWritePost,BufLeave,WinLeave',
    '?*',
    [[lua require'_.autocmds'.mkview()]]
  )
  au.autocmd('BufWinEnter', '?*', [[lua require'_.autocmds'.loadview()]])

  -- Close preview buffer with q
  au.autocmd('FileType', '*', [[lua require'_.autocmds'.quit_on_q()]])

  -- Project specific override
  au.autocmd(
    'BufRead,BufNewFile',
    '*',
    [[lua require'_.autocmds'.source_project_config()]]
  )

  au.autocmd(
    'DirChanged',
    '*',
    [[lua require'_.autocmds'.source_project_config()]]
  )

  au.autocmd('BufEnter,WinEnter', '*/node_modules/*', ':LspStop')
  au.autocmd('BufLeave', '*/node_modules/*', ':LspStart')
  au.autocmd('BufEnter,WinEnter', '*.min.*', ':LspStop')
  au.autocmd('BufLeave', '*.min.*', ':LspStart')

  au.autocmd('BufWritePost', '*/spell/*.add', 'silent! :mkspell! %')
--   au.autocmd('BufWritePost', '*', 'FormatWrite')
  au.autocmd('BufWritePost', 'packer.lua', 'PackerCompile')
end)
