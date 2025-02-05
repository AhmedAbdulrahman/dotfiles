-- luacheck: max line length 160

local utils = require('utils')
-- local async_present, async = pcall(require, 'plenary.async')


-- local Job = require('plenary.job')
local keymap = vim.keymap

-- Exported functions
local M = {}

M.mkview_filetype_blocklist = {
  diff = true,
  gitcommit = true,
  hgcommit = true,
}

M.quit_on_q_allowlist = {
  preview = true,
  qf = true,
  fzf = true,
  netrw = true,
  help = true,
  taskedit = true,
  diff = true,
  man = true,
  grepper = true,
}

M.colorcolumn_blocklist = {
  qf = true,
  fzf = true,
  netrw = true,
  help = true,
  markdown = true,
  startify = true,
  text = true,
  gitconfig = true,
  gitrebase = true,
  conf = true,
  tags = true,
  vimfiler = true,
  dos = true,
  json = true,
  diff = true,
  minpacprgs = true,
  gitcommit = true,
  GrepperSide = true,
}

M.heavy_plugins_blocklist = {
  preview = true,
  qf = true,
  fzf = true,
  netrw = true,
  help = true,
  taskedit = true,
  diff = true,
  man = true,
  startify = true,
  gitcommit = true,
  hgcommit = true,
  vimfiler = true,
  dos = true,
  minpacprgs = true,
}

-- Local functions
--  Loosely based on: http://vim.wikia.com/wiki/Make_views_automatic
--  from https://github.com/wincent/wincent/blob/c87f3e1e127784bb011b0352c9e239f9fde9854f/roles/dotfiles/files/.vim/autoload/autocmds.vim#L20-L37
local function should_mkview()
  return vim.bo.buftype == ''
    and vim.fn.getcmdwintype() == ''
    and M.mkview_filetype_blocklist[vim.bo.filetype] == nil
    and vim.fn.exists('$SUDO_USER') == 0 -- Don't create root-owned files.
end

local function should_quit_on_q()
  return vim.wo.diff == true or M.quit_on_q_allowlist[vim.bo.filetype] == true
end

local function should_turn_off_colorcolumn()
  return vim.bo.textwidth == 0
    or vim.wo.diff == true
    or M.colorcolumn_blocklist[vim.bo.filetype] == true
    or vim.bo.buftype == 'terminal'
    or vim.bo.readonly == true
end

local function cleanup_marker(marker)
  if vim.fn.exists(marker) == 1 then
    vim.api.nvim_command('silent! call matchdelete(' .. marker .. ')')
    vim.api.nvim_command('silent! unlet ' .. marker)
  end
end

-- Exported functions
M.mkview = function()
  if should_mkview() then
    local success, err = pcall(function()
      if vim.fn.exists('*haslocaldir') and vim.fn.haslocaldir() then
        -- We never want to save an :lcd command, so hack around it...
        vim.api.nvim_command('cd -')
        vim.api.nvim_command('mkview')
        vim.api.nvim_command('lcd -')
      else
        vim.api.nvim_command('mkview')
      end
    end)
    if not success then
      if
        err:find('%f[%w]E186%f[%W]') == nil -- No previous directory: probably a `git` operation.
        and err:find('%f[%w]E190%f[%W]') == nil -- Could be name or path length exceeding NAME_MAX or PATH_MAX.
        and err:find('%f[%w]E5108%f[%W]') == nil
      then
        error(err)
      end
    end
  end
end

M.loadview = function()
  if should_mkview() then
    vim.api.nvim_command('silent! loadview')
    vim.api.nvim_command('silent! ' .. vim.fn.line('.') .. 'foldopen!')
  end
end

M.quit_on_q = function()
  if should_quit_on_q() then
    keymap.set(
      'n',
      'q',
      (
        (vim.wo.diff == true or vim.bo.filetype == 'man') and ':qa!'
        or (vim.bo.filetype == 'qf') and ':cclose'
        or ':q'
      ) .. '<cr>',
      { buffer = true, silent = true }
    )
  end
end

M.disable_heavy_plugins = function()
  if
    M.heavy_plugins_blocklist[vim.bo.filetype] ~= nil
    or vim.regex('\\.min\\..*$'):match_str(vim.fn.expand('%:t')) ~= nil
    or vim.fn.getfsize(vim.fn.expand('%')) > 200000
  then
    if vim.fn.exists(':ALEDisableBuffer') == 2 then
      vim.api.nvim_command(':ALEDisableBuffer')
    end
  end
end

M.highlight_overlength = function()
  cleanup_marker('w:last_overlength')

  if should_turn_off_colorcolumn() then
    vim.api.nvim_command('match NONE')
  else
    -- Use tw + 1 so invisble characters are not marked
    -- I have to escape the escape backslash to be able to pass it to vim
    -- Ex: I want "\(" I have to do it in Lua as "\\("
    local overlength_pattern = '\\%>' .. (vim.bo.textwidth + 1) .. 'v.\\+'
    -- [TODO]: figure out how to convert this to Lua
    vim.api.nvim_command(
      "let w:last_overlength = matchadd('OverLength', '"
        .. overlength_pattern
        .. "')"
    )
  end
end

M.yank_current_file_name = function()
  -- local file_name = vim.api.nvim_buf_get_name(0)
  -- local input_pipe = vim.loop.new_pipe(false)

  -- local yanker = Job:new({
  --   writer = input_pipe,
  --   command = 'pbcopy',
  -- })

  -- -- @TODOUA: This works perfectly but double-check if it could be better(less)
  -- yanker:start()
  -- input_pipe:write(file_name)
  -- input_pipe:close()
  -- yanker:shutdown()

  -- require('notify')(
  --   'Yanked: ' .. file_name,
  --   'info',
  --   { title = 'File Name Yanker', timeout = 1000 }
  -- )
end

-- Project specific override
-- Better than what I had before https://github.com/mhinz/vim-startify/issues/292#issuecomment-335006879
M.source_project_config = function()
  local files = {
    '.vim/local.vim',
    '.vim/local.lua',
  }

  for _, file in pairs(files) do
    local current_file = vim.fn.findfile(file, vim.fn.expand('%:p') .. ';')

    if vim.fn.filereadable(current_file) == 1 then
      vim.api.nvim_command(string.format('silent source %s', current_file))
    end
  end
end

-- padding: 40px; ->
-- padding: "40px",
M.css_to_jss = function(opts)
  local start_line, end_line
  if type(opts) == 'table' then
    -- called via command
    start_line, end_line = opts.line1 - 1, opts.line2
  else
    -- called as operator
    start_line = vim.api.nvim_buf_get_mark(0, '[')[1] - 1
    end_line = vim.api.nvim_buf_get_mark(0, ']')[1] + 1
  end

  local did_convert = false
  for i, line in
    ipairs(vim.api.nvim_buf_get_lines(0, start_line, end_line, false))
  do
    -- if the line ends in a comma, it's probably already js
    if line:sub(#line) == ',' then
      goto continue
    end
    -- ignore comments
    if line:find('%/%*') then
      goto continue
    end

    local indentation, name, val = line:match('(%s+)(.+):%s(.+)')
    -- skip non-matching lines
    if not (name and val) then
      goto continue
    end

    local parsed_name = ''
    for j, component in ipairs(vim.split(name, '-')) do
      parsed_name = parsed_name
        .. (
          j == 1 and component
          or (component:sub(1, 1):upper() .. component:sub(2))
        )
    end

    local parsed_val = val:gsub(';', '')
    -- keep numbers, wrap others in quotes
    parsed_val = tonumber(parsed_val) or string.format('"%s"', parsed_val)
    local parsed_line =
      table.concat({ indentation, parsed_name, ': ', parsed_val, ',' })

    did_convert = true
    local row = start_line + i
    vim.api.nvim_buf_set_lines(0, row - 1, row, false, { parsed_line })

    ::continue::
  end

  if not did_convert then
    utils.warnlog('Nothing to Convert', 'CSS-TO-JS')
  end
end

-- const myString = "hello ${}" ->
-- const myString = `hello ${}`
M.change_template_string_quotes = function()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  row = row - 1

  local quote_start, quote_end
  utils.gfind(vim.api.nvim_get_current_line(), '["\']', function(pos)
    if not quote_start then
      -- start at first quote
      quote_start = pos
    elseif pos < col then
      -- move start if quote is closer to col
      if (pos - col) > (quote_start - col) then
        quote_start = pos
      end
    elseif not quote_end then
      -- first quote after col is end
      quote_end = pos
    end
  end)

  -- if found, replace quotes with backticks
  if quote_start and quote_start <= col and quote_end then
    vim.api.nvim_buf_set_text(
      0,
      row,
      quote_start - 1,
      row,
      quote_start,
      { '`' }
    )
    vim.api.nvim_buf_set_text(0, row, quote_end - 1, row, quote_end, { '`' })
  end

  -- input and move cursor into pair
  utils.input('${}', 'n')
  utils.input('<Left>')
end

M.smart_paste = function()
  vim.opt.paste = true
  vim.cmd('normal "+p')
  vim.opt.paste = false
end

M.notify_current_datetime = function()
  local dt = vim.fn.strftime('%c')
  require('notify')(
    'Current Date Time: ' .. dt,
    'info',
    { title = 'Date & Time', timeout = 200 }
  )
end

M.first_nvim_run = function()
  local is_first_run = utils.file_exists('/tmp/first-nvim-run')

  if is_first_run then
    async.run(function()
      vim.notify("Welcome to vim config! Hope you'll have a nice experience!", "info",
        { title = "Nvim", timeout = 5000 })
      vim.notify("Please install treesitter servers manually by :TSInstall command.", "info",
        { title = "Installation", timeout = 10000 })
    end)
    local suc = os.remove('/tmp/first-nvim-run')
    if not suc then
      print("Error: Couldn't remove /tmp/first-nvim-run!")
    end
  -- end
end

-- M.first_nvim_run()

local present, win = pcall(require, 'lspconfig.ui.windows')
if not present then
  return
end

local _default_opts = win.default_opts
win.default_opts = function(options)
  local opts = _default_opts(options)
  opts.border = NvimConfig.ui.float.border
  return opts
end

-- https://github.com/lunarmodules/Penlight/blob/master/lua/pl/utils.lua
-- An iterator over all non-integer keys (inverse of `ipairs`).
-- This uses `pairs` under the hood, so any value that is iterable using `pairs`
-- will work with this function.
M.kpairs = function(t)
  local index
  return function()
    local value
    while true do
      index, value = next(t, index)
      if type(index) ~= "number" or math.floor(index) ~= index then
        break
      end
    end
    return index, value
  end
end

-- Executes a user-supplied "reducer" callback function on each element of the table indexed with a numeric key, in order, passing in the return value from the calculation on the preceding element
M.ireduce = function(tbl, func, acc)
  for i, v in ipairs(tbl) do
    acc = func(acc, v, i)
  end
  return acc
end

-- Executes a user-supplied "reducer" callback function on each key element of the table indexed with a string key, in order, passing in the return value from the calculation on the preceding element
M.kreduce = function(tbl, func, acc)
  for i, v in pairs(tbl) do
    if type(i) == "string" then
      acc = func(acc, v, i)
    end
  end
  return acc
end

-- Executes a user-supplied "reducer" callback function on each element of the table, in order, passing in the return value from the calculation on the preceding element
M.reduce = function(tbl, func, acc)
  for i, v in pairs(tbl) do
    acc = func(acc, v, i)
  end
  return acc
end

-- Returns the index of the first element in the array that satisfies the provided testing function
M.find_index = function(tbl, func)
  for index, item in ipairs(tbl) do
    if func(item, index) then
      return index
    end
  end

  return nil
end

M.isome = function(tbl, func)
  for index, item in ipairs(tbl) do
    if func(item, index) then
      return true
    end
  end

  return false
end

-- Returns the first element in the array that satisfies the provided testing function
M.ifind = function(tbl, func)
  for index, item in ipairs(tbl) do
    if func(item, index) then
      return item
    end
  end

  return nil
end

M.find_last_index = function(tbl, func)
  for index = #tbl, 1, -1 do
    if func(tbl[index], index) then
      return index
    end
  end
end

M.slice = function(tbl, startIndex, endIndex)
  local sliced = {}
  endIndex = endIndex or #tbl

  for index = startIndex, endIndex do
    table.insert(sliced, tbl[index])
  end

  return sliced
end

M.concat = function(...)
  local concatenated = {}

  for _, tbl in ipairs({ ... }) do
    for _, value in ipairs(tbl) do
      table.insert(concatenated, value)
    end
  end

  return concatenated
end

-- Creates a new table populated with the results of calling a provided functions on every numeric indexed element in the calling table
M.imap = function(tbl, func)
  return M.ireduce(
    tbl,
    function(new_tbl, value, index)
      table.insert(new_tbl, func(value, index))
      return new_tbl
    end,
    {}
  )
end

M.ieach = function(tbl, func)
  for index, element in ipairs(tbl) do
    func(element, index)
  end
end

-- Returns an array of a given table's string-keyed property names.
M.keys = function(tbl)
  local keys = {}
  for key, _ in M.kpairs(tbl) do
    table.insert(keys, key)
  end
  return keys
end

-- Returns an array of a given table's numbered-keyed property names.
M.indexes = function(tbl)
  local indexes = {}
  for key, _ in ipairs(tbl) do
    table.insert(indexes, key)
  end
  return indexes
end

-- Creates a new function that, when called, has its arguments preceded by any provided ones
M.bind = function(func, ...)
  local boundArgs = { ... }

  return function(...)
    return func(unpack(boundArgs), ...)
  end
end

M.ifilter = function(tbl, func)
  return vim.tbl_filter(func, tbl)
end

M.switch = function(param, t)
  local case = t[param]
  if case then
    return case()
  end
  local defaultFn = t["default"]
  return defaultFn and defaultFn() or nil
end

M.trim = function(str)
  return (str:gsub("^%s*(.-)%s*$", "%1"))
end

M.ignore = function()
end

M.always = function(value)
  return function()
    return value
  end
end

return M
