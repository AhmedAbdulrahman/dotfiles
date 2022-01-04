cache = true
codes = true
std = 'luajit'

ignore = {
  "122", -- Setting a read-only field of a global variable.
  "431", -- Shadowing an upvalue.
}

exclude_files = {
    "hammerspoon/**/*.lua",
    "nvim/**/*.lua",
}


read_globals = {
  'vim',
}
