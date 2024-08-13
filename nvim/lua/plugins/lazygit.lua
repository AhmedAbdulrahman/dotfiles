return {
  {
    'kdheepak/lazygit.nvim',
    cmd = {
      'LazyGit',
      'LazyGitCurrentFile',
      'LazyGitFilterCurrentFile',
      'LazyGitFilter',
    },
    keys = {
      { '<leader>gg', '<cmd>LazyGit<CR>', desc = 'lazygit' },
    },
    config = function()
      vim.g.lazygit_floating_window_scaling_factor = 0.9
    end,
  },
}
