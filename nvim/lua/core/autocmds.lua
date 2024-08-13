-- --	┏━┓╻ ╻╺┳╸┏━┓┏━╸┏┳┓╺┳┓
-- --	┣━┫┃ ┃ ┃ ┃ ┃┃  ┃┃┃ ┃┃
-- --	╹ ╹┗━┛ ╹ ┗━┛┗━╸╹ ╹╺┻┛

-- -- luacheck: max line length 150

vim.api.nvim_create_augroup('Highlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 100 })
  end,
})

vim.api.nvim_create_augroup('LspNodeModules', { clear = true })
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = '*/node_modules/*',
  command = 'lua vim.diagnostic.disable(0)',
  group = 'LspNodeModules',
})

vim.api.nvim_create_autocmd({ 'BufEnter', 'WinEnter' }, {
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
  { 'BufEnter', 'WinEnter', 'BufLeave' },
  { pattern = '*.min.*', command = 'LspStop', group = 'LspNodeModules' }
)

vim.api.nvim_create_augroup('Spell', { clear = true })

-- Enable spell checking for certain file types
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = { '*.txt', '*.md', '*.tex' },
  command = 'setlocal spell',
  group = 'Spell',
})
-- Show `` in specific files
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = { '*.txt', '*.md', '*.json' },
  command = 'setlocal conceallevel=0',
  group = 'Spell',
})

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

vim.api.nvim_create_augroup('ClearLuasnipSession', { clear = true })
vim.api.nvim_create_autocmd('CursorHold', {
  pattern = '*',
  -- Can't use InsertLeave here because that fires when we go to select mode
  command = 'silent! LuaSnipUnlinkCurrent',
  group = 'ClearLuasnipSession',
})

vim.api.nvim_create_augroup('Files', { clear = true })

-- When editing a file, always jump to the last cursor position
vim.api.nvim_create_autocmd({ 'BufReadPost' }, {
  pattern = '*',
  callback = function(opts)
    local last_position = vim.api.nvim_buf_get_mark(opts.buf, '"')
    local line, _ = unpack(last_position)
    local total_lines = vim.api.nvim_buf_line_count(opts.buf)
    if line ~= 0 and line <= total_lines
        and vim.bo.filetype ~= 'fugitive'
        and vim.bo.filetype ~= 'gitcommit'
        and vim.bo.filetype ~= 'gitrebase'
    then
      -- print(vim.bo.filetype)
      vim.api.nvim_feedkeys([[g`"]], 'nx', false)
    end
  end,
  group = 'Files',
})

vim.api.nvim_create_augroup('FileTypeOverrides', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    "netrw",
    "Jaq",
    "qf",
    "git",
    "help",
    "man",
    "lspinfo",
    "oil",
    "spectre_panel",
    "lir",
    "DressingSelect",
    "tsplayground",
    "",
  },
  callback = function()
    vim.cmd [[
      nnoremap <silent> <buffer> q :close<CR>
      set nobuflisted
    ]]
  end,
  group = 'FileTypeOverrides',
})

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, { command = "checktime" })

-- vim.api.nvim_create_augroup('__myautocmds__', { clear = true })
-- -- Save the current buffer after any changes.
-- vim.api.nvim_create_autocmd('InsertLeave,TextChanged', {
--   pattern = '*',
--   command = 'nnoremap <buffer><leader>sb :call autocmds#savebuffer#()',
--   group = '__myautocmds__',
-- })
-- --  Set current working directory.
-- vim.api.nvim_create_autocmd('VimEnter', {
--   pattern = '*',
--   command = 'nnoremap <buffer><leader>sr :call autocmds#setroot#()',
--   group = '__myautocmds__',
-- })
-- -- Automatically make splits equal in size
-- vim.api.nvim_create_autocmd(
--   'VimResized',
--   { pattern = '*', command = 'wincmd =', group = '__myautocmds__' }
-- )
-- -- Disable paste mode on leaving insert mode.
-- vim.api.nvim_create_autocmd(
--   'InsertLeave',
--   { pattern = '*', command = 'set nopaste', group = '__myautocmds__' }
-- )
-- -- taken from https://github.com/jeffkreeftmeijer/vim-numbertoggle/blob/cfaecb9e22b45373bb4940010ce63a89073f6d8b/plugin/number_toggle.vim
-- vim.api.nvim_create_autocmd('BufLeave,FocusLost,InsertEnter,WinLeave', {
--   pattern = '*',
--   command = 'if &nu | set nornu | endif',
--   group = '__myautocmds__',
-- })
-- vim.api.nvim_create_autocmd('BufEnter,FocusGained,InsertLeave,WinEnter', {
--   pattern = '*',
--   command = 'if &nu | set rnu | endif',
--   group = '__myautocmds__',
-- })
-- -- Automatically make splits equal in size
-- vim.api.nvim_create_autocmd('BufReadPre', {
--   pattern = '*',
--   command = 'lua require("utils.functions").disable_heavy_plugins()',
--   group = '__myautocmds__',
-- })
-- -- vim.api.nvim_create_autocmd('FileType', {
-- --   pattern = '*',
-- --   command = 'lua require("utils.functions").quit_on_q()',
-- --   group = '__myautocmds__',
-- -- })
-- -- vim.api.nvim_create_autocmd('BufWritePost,BufLeave,WinLeave', {
-- --   pattern = '?*',
-- --   command = 'lua require("utils.functions").mkview()',
-- --   group = '__myautocmds__',
-- -- })
-- -- vim.api.nvim_create_autocmd('BufWinEnter', {
-- --   pattern = '?*',
-- --   command = 'lua require("utils.functions").loadview()',
-- --   group = '__myautocmds__',
-- -- })
-- vim.api.nvim_create_autocmd('BufEnter,BufWinEnter,BufRead,BufNewFile', {
--   pattern = 'bookmarks.{md,txt}',
--   command = 'hi! link mkdLink Normal | set concealcursor-=n',
--   group = '__myautocmds__',
-- })
-- -- Project specific override
-- vim.api.nvim_create_autocmd('BufRead,BufNewFile', {
--   pattern = '*',
--   command = 'lua require("utils.functions").source_project_config()',
--   group = '__myautocmds__',
-- })
-- vim.api.nvim_create_autocmd('DirChanged', {
--   pattern = '*',
--   command = 'lua require("utils.functions").source_project_config()',
--   group = '__myautocmds__',
-- })

-- Attach specific keybindings in which-key for specific filetypes
local present, _ = pcall(require, 'which-key')
if not present then
  return
end
local _, pwk = pcall(require, 'plugins.which-key')

vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '*.md',
  callback = function()
    pwk.attach_markdown(0)
  end,
})

vim.api.nvim_create_autocmd('BufEnter', {
  pattern = { '*.ts', '*.tsx' },
  callback = function()
    pwk.attach_typescript(0)
  end,
})

-- vim.api.nvim_create_autocmd('FileType', {
--   pattern = '*',
--   callback = function()
--     if NvimConfig.plugins.zen.enabled and vim.bo.filetype ~= 'alpha' then
--       pwk.attach_zen(0)
--     end
--   end,
-- })

vim.api.nvim_create_autocmd('BufEnter', {
  pattern = { '*test.js', '*test.ts', '*test.tsx', '*.spec.ts', '*.spec.js' },
  callback = function()
    pwk.attach_jest(0)
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'spectre_panel',
  callback = function()
    pwk.attach_spectre(0)
  end,
})

-- Winbar (for nvim 0.8+)
if vim.fn.has('nvim-0.8') == 1 then
  vim.api.nvim_create_autocmd({ 'CursorMoved', 'BufWinEnter', 'BufFilePost' }, {
    callback = function()
      local winbar_filetype_exclude = {
        'help',
        'startify',
        'dashboard',
        'packer',
        'neogitstatus',
        'NvimTree',
        'Trouble',
        'alpha',
        'lir',
        'Outline',
        'spectre_panel',
        'TelescopePrompt',
        'DressingInput',
        'DressingSelect',
        'neotest-summary',
      }

      if vim.api.nvim_win_get_config(0).relative ~= '' then
        return
      end

      if vim.bo.filetype == 'toggleterm' then
        return
      end

      if vim.tbl_contains(winbar_filetype_exclude, vim.bo.filetype) then
        vim.opt_local.winbar = nil
        return
      end

      local winbar_present, winbar = pcall(require, 'internal.winbar')
      if not winbar_present or type(winbar) == 'boolean' then
        vim.opt_local.winbar = nil
        return
      end

      local value = winbar.gps()

      if value == nil then
        value = winbar.filename()
      end

      vim.opt_local.winbar = value
    end,
  })
end
