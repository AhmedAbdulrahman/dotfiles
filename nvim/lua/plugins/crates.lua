local present, crates = pcall(require, 'crates')

if not present then
  return
end

crates.setup({
  popup = {
    border = NvimConfig.ui.float.border,
    show_version_date = true,
  },
  null_ls = {
    enabled = true,
  },
})
