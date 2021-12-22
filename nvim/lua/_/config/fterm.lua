-- luacheck: max line length 140
return function()
  local map = require('_.utils.map')
  local au = require('_.utils.au')

  local opts = { noremap = true, silent = true }
  map.nnoremap('<F7>', "<CMD>lua require('FTerm').toggle()<CR>", opts)
  map.tnoremap(
    '<F7>',
    "<C-\\><C-n><CMD>lua require('FTerm').toggle()<CR>",
    opts
  )
  map.tnoremap(
    '<Esc>',
    "<C-\\><C-n><CMD>lua require('FTerm').toggle()<CR>",
    opts
  )
  map.tnoremap('<F8>', "<C-\\><C-n><CMD>lua require('FTerm').exit()<CR>", opts)
  -- map.tnoremap('<esc>', [[&filetype == 'fzf' ? "\<esc>" : <C-\\><C-n><CMD>lua require('FTerm').toggle()<CR>]], {silent = true})
  map.nnoremap(
    '<A-g>',
    "<CMD>lua require('FTerm'):new({ cmd = 'gitui' }):open()<CR>",
    {
      silent = true,
      expr = true,
      noremap = true,
    }
  )

  au.augroup('__MyTerm__', function()
    au.autocmd(
      'TermOpen',
      '*',
      'if &filetype ==# "FTerm" | tnoremap <buffer> <C-\\><c-[> <cmd>lua require("FTerm").toggle()<cr> | endif'
    )
    au.autocmd('TermOpen', '*', 'setl nonumber norelativenumber')
    au.autocmd('TermOpen', 'term://*', 'set filetype=term')
    au.autocmd('TermOpen', 'term://*', 'startinsert')
    au.autocmd('TermClose', 'term://*', 'stopinsert')
  end)

  require('FTerm').setup({
    border = 'rounded',
    auto_close = true,
    -- Highlight group for the terminal. See `:h winhl`
    hl = 'Normal',
    dimensions = {
      height = 0.4,
      width = 1,
      x = 0,
      y = 1,
    },
    -- Transparency of the floating window. See `:h winblend`
    blend = 20,
  })
end
