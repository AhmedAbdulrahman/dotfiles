--	┏━┓╻ ╻╺┳╸┏━┓┏━╸┏┳┓╺┳┓
--	┣━┫┃ ┃ ┃ ┃ ┃┃  ┃┃┃ ┃┃
--	╹ ╹┗━┛ ╹ ┗━┛┗━╸╹ ╹╺┻┛

-- luacheck: max line length 150

local function nvim_create_augroups(definitions)
  for group_name, definition in pairs(definitions) do
    vim.api.nvim_command('augroup ' .. group_name)
    vim.api.nvim_command('autocmd!')
    for _, def in ipairs(definition) do
      local command = table.concat(vim.tbl_flatten({ 'autocmd', def }), ' ')
      vim.api.nvim_command(command)
    end
    vim.api.nvim_command('augroup END')
  end
end

local autocmds = {
  lua_highlight = {
    {
      'TextYankPost',
      '*',
      [[silent! lua vim.highlight.on_yank() {higroup="IncSearch", timeout=400}]],
    },
    { 'BufWritePost', 'plugins.lua', [[source <afile> | PackerSync]] },
    { 'BufWritePost', '*/spell/*.add', 'silent! :mkspell! %' },
    { 'BufWinEnter', 'NvimTree', 'let &l:statusline = " Explorer"' },
    { 'User', 'Startified', 'setlocal cursorline' },
  },
  -- Save the current buffer after any changes.
  lua_save_buffer = {
    {
      'InsertLeave,TextChanged',
      '*',
      [[nnoremap <buffer><leader>p :call autocmds#savebuffer#()]],
    },
  },
  --    Set current working directory.
  lua_current_directory = {
    {
      'VimEnter',
      '*',
      [[nnoremap <buffer><leader>p :call autocmds#setroot#()]],
    },
  },
  -- Automatically make splits equal in size
  lua_vim_resized = {
    { 'VimResized', '*', 'wincmd =' },
  },
  -- Disable paste mode on leaving insert mode.
  lua_nopaste = {
    { 'InsertLeave', '*', 'set nopaste' },
  },
  -- taken from https://github.com/jeffkreeftmeijer/vim-numbertoggle/blob/cfaecb9e22b45373bb4940010ce63a89073f6d8b/plugin/number_toggle.vim
  lua_toggle_number = {
    {
      'BufLeave,FocusLost,InsertEnter,WinLeave',
      '*',
      [[if &nu | set nornu | endif]],
    },
    {
      'BufEnter,FocusGained,InsertLeave,WinEnter',
      '*',
      [[if &nu | set rnu   | endif]],
    },
  },
  lua_lsp = {
    { 'BufEnter,WinEnter', '*/node_modules/*', ':LspStop' },
    { 'BufLeave', '*/node_modules/*', ':LspStart' },
    { 'BufEnter,WinEnter', '*.min.*', ':LspStop' },
    { 'BufLeave', '*.min.*', ':LspStart' },
  },
  lua_custom_cmds = {
    {
      'BufReadPre',
      '*',
      [[lua require('functions').disable_heavy_plugins()]],
    },
    { 'FileType', '*', [[lua require('functions').quit_on_q()]] },
    {
      'BufWritePost,BufLeave,WinLeave',
      '?*',
      [[lua require('functions').mkview()]],
    },
    { 'BufWinEnter', '?*', [[lua require('functions').loadview()]] },
  },
  lua_bookmarks = {
    {
      'BufEnter,BufWinEnter,BufRead,BufNewFile',
      'bookmarks.{md,txt}',
      'hi! link mkdLink Normal | set concealcursor-=n',
    },
  },
  -- Project specific override
  lua_override = {
    {
      'BufRead,BufNewFile',
      '*',
      [[lua require('functions').source_project_config()]],
    },
    {
      'DirChanged',
      '*',
      [[lua require('functions').source_project_config()]],
    },
  },
}

nvim_create_augroups(autocmds)
