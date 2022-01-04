local map = require('utils.map')
local opts = { noremap = true, silent = true }

-- DAP UI
require('dapui').setup({
  icons = { expanded = '▾', collapsed = '▸' },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { '<CR>', '<2-LeftMouse>' },
    open = 'o',
    remove = 'd',
    edit = 'e',
    repl = 'r',
  },
  sidebar = {
    -- You can change the order of elements in the sidebar
    elements = {
      -- Provide as ID strings or tables with "id" and "size" keys
      {
        id = 'scopes',
        size = 0.25, -- Can be float or integer > 1
      },
      { id = 'breakpoints', size = 0.25 },
      { id = 'stacks', size = 0.25 },
      { id = 'watches', size = 00.25 },
    },
    size = 40,
    position = 'left', -- Can be "left" or "right"
  },
  tray = {
    elements = { 'repl' },
    size = 10,
    position = 'bottom', -- Can be "bottom" or "top"
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    mappings = {
      close = { 'q', '<Esc>' },
    },
  },
  windows = { indent = 1 },
})

-- DAP
local dap = require('dap')
local dapui = require('dapui')

dap.set_log_level('TRACE')

-- Automatically open UI
dap.listeners.after.event_initialized['dapui_config'] = function()
  dapui.open()
end
dap.listeners.before.event_terminated['dapui_config'] = function()
  dapui.close()
end
dap.listeners.before.event_exited['dapui_config'] = function()
  dapui.close()
end

-- Enable virtual text
vim.g.dap_virtual_text = true

-- Icons
vim.fn.sign_define(
  'DapBreakpoint',
  { text = '🟥', texthl = '', linehl = '', numhl = '' }
)
vim.fn.sign_define(
  'DapStopped',
  { text = '⭐️', texthl = '', linehl = '', numhl = '' }
)

-- Keybindings
map.nnoremap(
  '<Leader>db',
  "<CMD>lua require('dap').toggle_breakpoint()<CR>",
  opts
)
map.nnoremap('<Leader>dc', "<CMD>lua require('dap').continue()<CR>", opts)
map.nnoremap('<Leader>dd', "<CMD>lua require('dap').continue()<CR>", opts)
map.nnoremap(
  '<Leader>dh',
  "<CMD>lua require('dap.ui.variables').hover()<CR>",
  opts
)
map.nnoremap('<Leader>di', "<CMD>lua require('dap').step_into()<CR>", opts)
map.nnoremap('<Leader>do', "<CMD>lua require('dap').step_out()<CR>", opts)
map.nnoremap('<Leader>dO', "<CMD>lua require('dap').step_over()<CR>", opts)
map.nnoremap(
  '<Leader>ds',
  "<CMD>lua require('dap.ui.variables').scopes()<CR>",
  opts
)

-- NODE / TYPESCRIPT
dap.adapters.node2 = {
  type = 'executable',
  command = os.getenv('HOME') .. '/.nvm/versions/node/v16.8.0/bin/node',
  args = {
    os.getenv('HOME')
      .. '/debuggers/vscode-js-debug/out/src/debugServerMain.js',
  },
}

-- Chrome
dap.adapters.chrome = {
  type = 'executable',
  command = 'node',
  args = {
    os.getenv('HOME')
      .. '/debuggers/vscode-chrome-debug/out/src/chromeDebug.js',
  },
}

-- Configurations
dap.configurations.javascript = {
  {
    type = 'node2',
    request = 'launch',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
  },
}

dap.configurations.javascript = {
  {
    type = 'chrome',
    request = 'attach',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    port = 9222,
    webRoot = '${workspaceFolder}',
  },
}

dap.configurations.javascriptreact = {
  {
    type = 'chrome',
    request = 'attach',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    port = 9222,
    webRoot = '${workspaceFolder}',
  },
}

dap.configurations.typescriptreact = {
  {
    type = 'chrome',
    request = 'attach',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    port = 9222,
    webRoot = '${workspaceFolder}',
  },
}
