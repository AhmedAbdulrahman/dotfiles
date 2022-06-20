-- luacheck: globals packer_plugins

local M = {}

local handle_job_data = function(data)
  if not data then
    return nil
  end
  if data[#data] == '' then
    table.remove(data, #data)
  end
  if #data < 1 then
    return nil
  end
  return data
end

function M.get_color(synID, what, mode)
  return vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID(synID)), what, mode)
end

function M.t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function M.urlencode(str)
  str = string.gsub(
    str,
    "([^0-9a-zA-Z !'()*._~-])", -- locale independent
    function(c)
    return string.format('%%%02X', string.byte(c))
  end
  )

  str = string.gsub(str, ' ', '%%20')
  return str
end

function M.plugin_installed(name)
  local has_packer = pcall(require, 'packer')

  if not has_packer then
    return
  end

  return has_packer and packer_plugins ~= nil and packer_plugins[name]
end

function M.plugin_loaded(name)
  return M.plugin_installed(name) and packer_plugins[name].loaded
end

function M.notify(msg, level)
  vim.notify(msg, level or vim.log.levels.INFO, { title = ':: Local ::' })
end

function M.file_exists(path)
  local f = io.open(path, 'r')
  if f ~= nil then
    io.close(f)
    return true
  else
    return false
  end
end

function M.warnlog(message, title)
  require('notify')(message, 'warn', { title = title or 'Warning' })
end

function M.errorlog(message, title)
  require('notify')(message, 'error', { title = title or 'Error' })
end

function M.toggle_quicklist(path)
  if vim.fn.empty(vim.fn.filter(vim.fn.getwininfo(), 'v:val.quickfix')) == 1
  then
    vim.cmd('copen')
  else
    vim.cmd('cclose')
  end
end

function M.get_relative_fname()
  local fname = vim.fn.expand('%:p')
  return fname:gsub(vim.fn.getcwd() .. '/', '')
end

function M.get_relative_gitpath()
  local fpath = vim.fn.expand('%:h')
  local fname = vim.fn.expand('%:t')
  local gitpath = vim.fn.systemlist('git rev-parse --show-toplevel')[1]
  local ellipsis = '...'
  local relative_gitpath = fpath:gsub(gitpath, '') .. '/' .. fname

  if vim.fn.winwidth(0) < 200 and #relative_gitpath > 30 then
    return ellipsis .. relative_gitpath:sub(20, #relative_gitpath)
  end

  return relative_gitpath
end

function M.starts_with(str, start)
  return str:sub(1, #start) == start
end

function M.end_with(str, ending)
  return ending == "" or str:sub(- #ending) == ending
end

function M.split(s, delimiter)
  local result = {}
  for match in (s .. delimiter):gmatch('(.-)' .. delimiter) do
    table.insert(result, match)
  end
  return result
end

function M.sleep(n)
  os.execute('sleep ' .. tonumber(n))
end

function M.input(keys, mode)
  vim.api.nvim_feedkeys(M.t(keys), mode or "m", true)
end

function M.gfind(str, substr, cb, init)
  init = init or 1
  local start_pos, end_pos = str:find(substr, init)
  if start_pos then
    cb(start_pos, end_pos)
    return M.gfind(str, substr, cb, end_pos + 1)
  end
end

M.jobstart = function(cmd, on_finish)
  local has_error = false
  local lines = {}

  local function on_event(_, data, event)
    if event == "stdout" then
      data = M.handle_job_data(data)
      if not data then
        return
      end

      for i = 1, #data do
        table.insert(lines, data[i])
      end
    elseif event == "stderr" then
      data = M.handle_job_data(data)
      if not data then
        return
      end

      has_error = true
      local error_message = ""
      for _, line in ipairs(data) do
        error_message = error_message .. line
      end
      M.log("Error during running a job: " .. error_message)
    elseif event == "exit" then
      if not has_error then
        on_finish(lines)
      end
    end
  end

  vim.fn.jobstart(cmd, {
    on_stderr = on_event,
    on_stdout = on_event,
    on_exit = on_event,
    stdout_buffered = true,
    stderr_buffered = true,
  })
end

M.remove_whitespaces = function(string)
  return string:gsub("%s+", "")
end

M.add_whitespaces = function(number)
  return string.rep(" ", number)
end

return M
