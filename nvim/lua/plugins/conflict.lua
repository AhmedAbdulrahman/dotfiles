return {
	{
    'akinsho/git-conflict.nvim',
    config = function()
      require('conflict').setup({
				default_mappings = true,                           -- disable buffer local mapping created by this plugin
				default_commands = true,                           -- disable commands created by this plugin
				disable_diagnostics = true,                        -- This will disable the diagnostics in a buffer whilst it is conflicted
				highlights = {                                     -- They must have background color, otherwise the default color will be used
					incoming = "DiffText",
					current = "DiffAdd",
				},
			})

			vim.api.nvim_create_autocmd("User", {
				pattern = "GitConflictDetected",
				callback = function()
					vim.notify("Conflict detected in " .. vim.fn.expand("<afile>"))
				end,
			})

    end,
    keys = {
      {
        '<leader>gcb',
        '<cmd>GitConflictChooseBoth<CR>',
        desc = 'choose both',
      },
      {
        '<leader>gcn',
        '<cmd>GitConflictNextConflict<CR>',
        desc = 'move to next conflict',
      },
      {
        '<leader>gcc',
        '<cmd>GitConflictChooseOurs<CR>',
        desc = 'choose current',
      },
      {
        '<leader>gcp',
        '<cmd>GitConflictPrevConflict<CR>',
        desc = 'move to prev conflict',
      },
      {
        '<leader>gci',
        '<cmd>GitConflictChooseTheirs<CR>',
        desc = 'choose incoming',
      },
    },
  },
}
