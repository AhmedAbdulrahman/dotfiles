-- luacheck: globals P RELOAD R GIT_CWD
P = function(v)
  print(vim.pretty_print(v))
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
