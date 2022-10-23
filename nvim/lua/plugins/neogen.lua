local keymap = vim.keymap
local present, neogen = pcall(require, 'neogen')

if not present then
  return
end

neogen.setup({
  enabled = true,
})

keymap.set(
  'n',
  '<leader>tc',
  neogen.generate,
  { desc = 'Add documentation for the method/class/function ' }
)
