return {
  {
    'Saecki/crates.nvim',
    dependencqies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('crates').setup({
        popup = {
          border = NvimConfig.ui.float.border,
          show_version_date = true,
        },
        -- null_ls = {
        --   enabled = true,
        -- },
      })
    end
  },
  {
    'danymat/neogen',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      local neogen = require('neogen')
      require('neogen').setup({
        enabled = true,
      })

      vim.keymap.set(
        'n',
        '<leader>tc',
        neogen.generate,
        { desc = 'Add documentation for the method/class/function ' }
      )
    end,
  },
  {
    'neapel/vim-bnfc-syntax',
    config = function()
      -- Argh, why don't syntax plugins ever set commentstring!
      vim.cmd([[autocmd FileType bnfc setlocal commentstring=--%s]])
      -- This syntax works pretty well for regular BNF too
      vim.cmd([[autocmd BufNewFile,BufRead *.bnf setlocal filetype=bnfc]])
    end,
  },
  { 'mattn/emmet-vim' },
}
