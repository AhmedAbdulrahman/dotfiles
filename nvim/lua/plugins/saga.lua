local saga = require('lspsaga')
local map = require('utils.map')
local opts = { noremap = true, silent = true }

saga.init_lsp_saga({
  code_action_icon = '💡',
  code_action_prompt = {
    enable = true,
    sign = true,
    sign_priority = 15,
    virtual_text = false,
  },
  code_action_keys = { quit = { 'q', '<ESC>' }, exec = '<CR>' },
  border_style = 'round',
})

-- LSP Keymappings
map.nnoremap('gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
map.nnoremap('gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
map.nnoremap(
  'gD',
  "<cmd>lua require'lspsaga.provider'.preview_definition()<CR>",
  opts
)
map.nnoremap('gr', "<cmd>lua require'lspsaga.provider'.lsp_finder()<CR>", opts)
map.nnoremap(
  '<C-Space>',
  "<cmd>lua require('lspsaga.codeaction').code_action()<CR>",
  { silent = true }
)
map.nnoremap(
  '<leader>ca',
  "<cmd>lua require('lspsaga.codeaction').code_action()<CR>",
  opts
)
map.vnoremap(
  '<leader>ca',
  "<cmd>'<,'>lua require('lspsaga.codeaction').range_code_action()<CR>",
  opts
)
map.nnoremap(
  '<leader>cr',
  "<cmd>lua require('lspsaga.rename').rename()<CR>",
  opts
)
map.nnoremap('<leader>cf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
map.vnoremap(
  '<leader>cf',
  "<cmd>'<.'>lua vim.lsp.buf.range_formatting()<CR>",
  opts
)
map.nnoremap(
  'K',
  "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>",
  opts
)
-- map.nnoremap("K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
map.nnoremap(
  '<C-k>',
  "<cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>",
  opts
)
map.nnoremap('[g', '<cmd>Lspsaga diagnostic_jump_prev<CR>', opts)
map.nnoremap(']g', '<cmd>Lspsaga diagnostic_jump_next<CR>', opts)
-- map.nnoremap("[g", "<cmd>lua vim.diagnostic.goto_next({ float = { border = 'rounded' }})<CR>", opts)
-- map.nnoremap("]g", "<cmd>lua vim.diagnostic.goto_prev({ float = { border = 'rounded' }})<CR>", opts)
map.nnoremap(
  '<C-f>',
  "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>",
  opts
)
map.nnoremap(
  '<C-b>',
  "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>",
  opts
)
map.nnoremap(
  '<leader>cl',
  "<cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>",
  opts
)
