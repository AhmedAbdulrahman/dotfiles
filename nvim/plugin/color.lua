local utils = require '_.utils'
local au = require '_.utils.au'

au.augroup('__MyCustomColors__', function()
	au.autocmd(
		'BufWinEnter,BufEnter',
		'*',
		[[lua require'_.autocmds'.highlight_git_markers()]]
	)

end)

-- Order is important, so any autocmds above works properly
vim.opt.background = 'dark'
vim.cmd [[silent! colorscheme aylin]]
