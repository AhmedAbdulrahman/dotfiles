local map = require '_.utils.map'

-- Jump to the beginning and end of line
map.cnoremap('<C-a>', '<Home>')
map.cnoremap('<C-e>', '<End>')

-- Jump previous and next commands from history
map.cnoremap('<C-h>', '<Left>')
map.cnoremap('<C-l>', '<Right>')
map.cnoremap('<C-j>', '<Down>')
map.cnoremap('<C-k>', '<Up>')

-- Construct substitute command with 'very magic' mode
map.cnoremap(';s', 'substitute/\v//gc<Left><Left><Left><Left>')

-- Construct global command with 'very magic' mode
map.cnoremap(';g', 'global/\v/<Left>')

-- Construct search and replace with populated quickfix list.
map.cnoremap(';r', 'cdo substitute/<C-r>=@/<CR>//gce<Left><Left><Left><Left>')

-- When opening a readonly file, ie. /etc/hosts `w!!` 🚑
map.cmap('w!!', '%!sudo tee > /dev/null %')

-- go into command mode and print the working dir
-- TODO: figure out a way to print the `cwd` or `pwd` quickly from `NORMAL` mode
-- NOTE: `:pwd` is hacky,
-- UPDATE: ...obviously set a normal mode mapping for below commands
map.cmap('cwd', 'lcd %:p:h')
map.cmap('cd.', 'lcd %:p:h')
