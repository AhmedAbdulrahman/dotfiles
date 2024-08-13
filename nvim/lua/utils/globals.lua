-- luacheck: globals P RELOAD R GIT_CWD

local uv = vim.loop
local path_sep = uv.os_uname().version:match "Windows" and "\\" or "/"

local init_path = debug.getinfo(1, "S").source:sub(2)
local base_dir = init_path:match("(.*[/\\])"):sub(1, -2)

P = function(v)
  print(vim.print(v))
  return v
end

RELOAD = function(...)
  return require('plenary.reload').reload_module(...)
end

R = function(name)
  _G.RELOAD(name)
  return require(name)
end

GIT_CWD = function()
  return vim.fn.systemlist("git rev-parse --show-toplevel")[1] .. "/"
end

---Join path segments that were passed as input
---@return string
_G.join_paths = function(...)
  local result = table.concat({ ... }, path_sep)
  return result
end
