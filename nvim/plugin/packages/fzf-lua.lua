local fzf_lua = require('fzf-lua')
local map = require('_.utils.map')

fzf_lua.setup({
  winopts = {
    default = {
      preview = 'bat_native',
    },
    height = 0.90,
    width = 0.65,
    row = 0.30,
    col = 0.50,
    hl = {
      border = 'FloatBorder',
    },
    preview = {
      vertical = 'down:60%',
      layout = 'vertical',
      scrollbar = 'float',
    },
  },
  fzf_opts = {
    ['--prompt'] = '» ',
    ['--pointer'] = '▶',
    ['--marker'] = '✓ ',
    ['--color'] = 'bg+:-1,marker:010',
    ['--info'] = 'inline',
  },
  keymap = {
    builtin = {
      ['?'] = 'toggle-preview',
      ['<F2>'] = 'toggle-fullscreen',
      ['<S-Down>'] = 'preview-page-down',
      ['<S-Up>'] = 'preview-page-up',
    },
    fzf = {
      ['ctrl-a'] = 'toggle-all',
      ['ctrl-f'] = 'half-page-down',
      ['ctrl-b'] = 'half-page-up',
    },
  },
  files = {
    prompt = 'Files> ',
    git_icons = false,
    file_icons = false,
    cmd = vim.env.FZF_DEFAULT_COMMAND,
    actions = {
      ['default'] = require('fzf-lua.actions').file_edit,
    },
  },
  git = {
    files = {
      prompt = '> ',
      git_icons = false,
    },
    status = {
      prompt = 'GitStatus> ',
    },
    commits = {
      prompt = 'Commits> ',
    },
    bcommits = {
      prompt = 'BufferCommits> ',
    },
    branches = {
      prompt = 'Branches> ',
    },
  },
  grep = {
    prompt = 'Grep> ',
    input_prompt = 'Grep> ',
    git_icons = false,
    rg_opts = table.concat({
      '--vimgrep',
      '--hidden',
      '--no-ignore',
      '--column',
      '--line-number',
      '--no-heading',
      '--color=always',
      '--smart-case',
      "--glob '!{.git,.next,node_modules}/*'",
    }, ' '),
  },
  args = {
    prompt = 'Args> ',
  },
  oldfiles = {
    prompt = 'OldFiles> ',
  },
  buffers = {
    prompt = 'Buffers> ',
    file_icons = false,
  },
  blines = {
    prompt = 'BufferLines> ',
    file_icons = false,
  },
  colorschemes = {
    prompt = 'Colorschemes> ',
    file_icons = false,
  },
  lsp = {
    prompt = '> ',
  },
  helptags = { previewer = { _ctor = false } },
  manpages = { previewer = { _ctor = false } },
})

local map_opts = { silent = true }

map.nnoremap(
  '<Leader><TAB>',
  -- '<Cmd>FzfLua files<CR>',
  [[<cmd>lua require 'fzf-lua'.files()<cr>]],
  map_opts
)
map.nmap('<M-x>', '<Cmd>FzfLua commands<CR>', map_opts)
-- map.nmap('<C-b>', '<Cmd>FzfLua buffers<CR>', map_opts)
map.nnoremap(
  '<leader>b',
  [[<cmd>lua require 'fzf-lua'.buffers()<cr>]],
  { silent = true }
)
-- map.nmap('<Leader>h', '<Cmd>FzfLua help_tags<CR>', map_opts)
map.nnoremap(
  '<leader>h',
  [[<cmd>lua require 'fzf-lua'.help_tags()<cr>]],
  { silent = true }
)
map.nmap('<leader>:', '<Cmd>FzfLua command_history<CR>', map_opts)
map.nmap('<leader>\\', '<Cmd>FzfLua search_history<CR>', map_opts)
map.nmap('<leader>`', '<Cmd>FzfLua marks<CR>', map_opts)
map.nmap('<leader>/', '<Cmd>FzfLua live_grep_native<CR>', map_opts)
map.nmap('<C-p>', '<Cmd>FzfLua git_files<CR>', map_opts)
map.nmap('<leader>gl', '<Cmd>FzfLua git_bcommits<CR>', map_opts)
map.nmap('<leader>gL', '<Cmd>FzfLua git_commits<CR>', map_opts)
map.nmap('<leader>gs', '<Cmd>FzfLua git_status<CR>', map_opts)
map.nmap('<leader>gb', '<Cmd>FzfLua git_branches<CR>', map_opts)
