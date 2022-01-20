vim.cmd(
  [[command! PackerInstall packadd packer.nvim | lua require('plugins').install()]]
)
vim.cmd(
  [[command! PackerUpdate packadd packer.nvim | lua require('plugins').update()]]
)
vim.cmd(
  [[command! PackerSync packadd packer.nvim | lua require('plugins').sync()]]
)
vim.cmd(
  [[command! PackerClean packadd packer.nvim | lua require('plugins').clean()]]
)
vim.cmd(
  [[command! PackerCompile packadd packer.nvim | lua require('plugins').compile()]]
)
vim.cmd(
  [[command! PackerStatus packadd packer.nvim | lua require('plugins').status()]]
)
vim.cmd([[command! PC PackerCompile]])
vim.cmd([[command! PU PackerSync]])
