return {
  {
    'ruifm/gitlinker.nvim',
    config = function()
      local gitlinker = require('gitlinker')
      local keymap = vim.keymap
      local silent = { silent = true }

      gitlinker.setup()

      keymap.set('n', '<leader>gl', function()
        gitlinker.get_buf_range_url(
          'n',
          { action_callback = gitlinker.actions.open_in_browser }
        )
      end, silent)

      keymap.set('v', '<leader>gl', function()
        gitlinker.get_buf_range_url(
          'v',
          { action_callback = gitlinker.actions.open_in_browser }
        )
      end, silent)

      keymap.set('n', 'gY', gitlinker.get_repo_url, silent)
      keymap.set('v', '<leader>gL', function()
        gitlinker.get_repo_url({
          action_callback = gitlinker.actions.open_in_browser,
        })
      end, silent)
    end,
  },
}
