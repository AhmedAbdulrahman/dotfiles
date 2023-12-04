-- Rerun tests only if their modification time changed.
cache = true
codes = true
std = 'luajit'

ignore = {
  "122", -- Setting a read-only field of a global variable.
  "431", -- Shadowing an upvalue.
  "432", -- Shadowing an upvalue argument.
  "631",  -- max_line_length
  "212/_.*",  -- unused argument, for vars with "_" prefix
}


read_globals = {
  'vim',
  'log'
}

globals = { "vim", "_", "use", "s", "i", "fmt", "rep", "conds", "f", "c", "t","root", "awesome", "client", "vim.g", "NvimConfig", "hs" }
