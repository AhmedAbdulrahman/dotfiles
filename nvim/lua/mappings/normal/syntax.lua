local function bufnr_calc_width(buf, lines)
  return vim.api.nvim_buf_call(buf, function()
    local width = 0

    for _, l in ipairs(lines) do
      local len = vim.fn.strdisplaywidth(l)
      if len > width then
        width = len
      end
    end

    return width + 1
  end)
end

local function get_current_syntax_group()
  local line_number = vim.fn.line('.')
  local column_position = vim.fn.col('.')

  local syntax_id = vim.fn.synID(line_number, column_position, true)
  local highlight = vim.fn.synIDattr(syntax_id, 'name')

  local syntax_id_2 = vim.fn.synID(line_number, column_position, false)
  local trans = vim.fn.synIDattr(syntax_id_2, 'name')

  local syntax_id_3 = vim.fn.synIDtrans(syntax_id)
  local lo = vim.fn.synIDattr(syntax_id_3, 'name')

  return {
    ('hi    → %s'):format(highlight or nil),
    ('trans → %s'):format(trans or nil),
    ('lo    → %s'):format(lo or nil),
  }
end

local function reveal_syntax_group()
  local buffer = vim.api.nvim_create_buf(false, true)
  local lines = get_current_syntax_group()
  vim.api.nvim_buf_set_lines(buffer, 0, -1, true, lines)

  local window = vim.api.nvim_open_win(buffer, false, {
    relative = 'cursor',
    border = 'rounded',
    focusable = true,
    width = bufnr_calc_width(buffer, lines),
    height = 3,
    col = 0,
    row = 1,
    anchor = 'NW',
    style = 'minimal',
  })

  vim.cmd(('augroup reveal_syntax_group_%s'):format(window))
  vim.cmd(
    'autocmd CursorMoved,CursorMovedI * '
      .. ("lua require('mappings/normal/syntax').close_window(%d)"):format(
        window
      )
  )
  vim.cmd('augroup end')
end

local function close_window(win_id)
  if vim.api.nvim_get_current_win() ~= win_id then
    vim.cmd(('silent! augroup! reveal_syntax_group_%s'):format(win_id))

    pcall(vim.api.nvim_win_close, win_id, true)
  end
end

return {
  reveal_syntax_group = reveal_syntax_group,
  close_window = close_window,
}
