_G.P = function(v)
  print(vim.pretty_print(v))
  return v
end

_G.RELOAD = function(...)
  return require('plenary.reload').reload_module(...)
end

_G.R = function(name)
  _G.RELOAD(name)
  return require(name)
end

_G.GIT_CWD = function()
  return vim.fn.systemlist("git rev-parse --show-toplevel")[1] .. "/"
end
