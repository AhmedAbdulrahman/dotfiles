local function createCenteredFloatingWindow()
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)

  local buf = vim.api.nvim_create_buf(true, true)

  vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    style = 'minimal',
    border = 'single',
    row = ((vim.o.lines - height) / 2) - 1,
    col = (vim.o.columns - width) / 2,
    width = width,
    height = height,
  })

  return buf
end

vim.api.nvim_create_user_command('FloatingMan', function(opts)
  local id = opts.args
  local buf = createCenteredFloatingWindow()
  vim.bo[buf].filetype = 'man'

  vim.cmd('Man ' .. id)

  vim.keymap.set('n', 'q', ':bwipeout!<cr>', { silent = true, buffer = buf })
  vim.keymap.set(
    'n',
    '<esc>',
    ':bwipeout!<cr>',
    { silent = true, buffer = buf }
  )
  vim.api.nvim_create_autocmd('BufLeave', { buffer = 0, command = 'bwipeout!' })
end, { nargs = '*', force = true })

vim.opt.keywordprg = ':FloatingMan'
