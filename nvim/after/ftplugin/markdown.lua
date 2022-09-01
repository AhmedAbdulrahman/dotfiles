local utils = require('utils')

utils.plaintext()

if vim.fn.executable 'gh' == 1 then
  vim.cmd [[nnoremap <buffer><leader>p :call ahmed#utils#openMarkdownPreview()<CR>]]
end

if vim.fn.executable 'glow' == 1 then
  vim.cmd [[nnoremap <buffer><leader>g :Glow<CR>]]
end
