return {
  {
    'smoka7/multicursors.nvim',
    event = 'VeryLazy',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'smoka7/hydra.nvim',
    },
    opts = {
      hint_config = {
        border = NvimConfig.ui.float.border or "rounded",
        position = 'bottom',
        show_name = false,
      }
    },
    keys = {
      {
        '<leader>j',
        '<cmd>MCstart<cr>',
        desc = 'Create a selection for word under the cursor',
      },
      {
        '<leader>k',
        '<CMD>MCvisual<CR>',
        mode = 'v',
        desc = 'Create a selection for word under the cursor',
      },
      {
        '<C-Down>',
        '<CMD>MCunderCursor<CR>',
        desc = 'multicursor down',
      },
    },
  },
}
