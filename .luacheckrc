cache = true
codes = true
std = 'luajit'

ignore = {
  "122", -- Setting a read-only field of a global variable.
}

exclude_files = {
    "hammerspoon/**/*.lua",
}

read_globals = {
  'vim',
}
