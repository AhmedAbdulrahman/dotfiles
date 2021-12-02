local map = require '_.utils.map'

vim.cmd [[setlocal conceallevel=2]]
vim.cmd [[setlocal isfname+=@-@ ]]
vim.cmd [[setlocal suffixesadd=.js,.jsx ]]

local package_lock = vim.fn.findfile(
  'package-lock.json',
  vim.fn.expand '%:p' .. ';'
)

if vim.fn.filereadable(package_lock) == 1 then
  vim.cmd [[setlocal makeprg=npm]]
else
  vim.cmd [[setlocal makeprg=yarn]]
end
