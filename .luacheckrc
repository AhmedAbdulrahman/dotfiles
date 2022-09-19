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

exclude_files = {
    "hammerspoon/**/*.lua",
}


read_globals = {
  'vim',
}

globals = {
  "vim.g",
 'NvimConfig',
}
