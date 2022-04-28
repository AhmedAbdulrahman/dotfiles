local command_palette = {
	{
	  'File',
	  {
		'Yank Current File Name',
		-- ":lua require('functions').yank_current_file_name()",
	  },
	  { 'Write Current Buffer', ':w' },
	  { 'Write All Buffers', ':wa' },
	  { 'Quit', ':qa' },
	  {
		'File Browser',
		":lua require'telescope'.extensions.file_browser.file_browser()",
		1,
	  },
	  {
		'Search for Word',
		":lua require('telescope.builtin').live_grep()",
		1,
	  },
	  { 'Project Files', ":lua require'telescope'.project_files()", 1 },
	},
	{
	  'Git(Hub)',
	  { ' Issues', "lua require'plugins.telescope'.gh_issues()", 1 },
	  { ' Pulls', "lua require'plugins.telescope'.gh_prs()", 1 },
	  { ' Status', "lua require'telescope.builtin'.git_status()", 1 },
	  { ' Diff Split Vertical', ':Gvdiffsplit!', 1 },
	  { ' Log', "lua require'telescope.builtin'.git_commits()", 1 },
	  {
		' File History',
		":lua require'telescope.builtin'.git_bcommits({prompt_title = '  ', results_title='Git File Commits'})",
		1,
	  },
	},
	{
	  'Terminal',
	  { 'Vertical Right', ':vsp | terminal', 1 },
	},
	{
	  'Notes',
	  { 'Browse Notes', "lua require'telescope'.browse_notes()", 1 },
	  { 'Find Notes', "lua require'telescope'.find_notes()", 1 },
	  { 'Search/Grep Notes', "lua require'telescope'.grep_notes()", 1 },
	},
	{
	  'Toggle',
	  { 'cursor line', ':set cursorline!' },
	  { 'cursor column', ':set cursorcolumn!' },
	  { 'spell checker', ':set spell!' },
	  { 'relative number', ':set relativenumber!' },
	  { 'search highlighting', ':set hlsearch!' },
	  { 'Colorizer', ':ColorToggle' },
	  -- { "Fold Column", ":lua require'joel.settings'.toggle_fold_col()" },
	},
	{
	  'Neovim',
	  { 'checkhealth', ':checkhealth' },
	  { 'commands', ":lua require('telescope.builtin').commands()" },
	  {
		'command history',
		":lua require('telescope.builtin').command_history()",
	  },
	  { 'registers', ":lua require('telescope.builtin').registers()" },
	  { 'options', ":lua require('telescope.builtin').vim_options()" },
	  { 'keymaps', ":lua require('telescope.builtin').keymaps()" },
	  { 'buffers', ':Telescope buffers' },
	  {
		'search history',
		":lua require('telescope.builtin').search_history()",
	  },
	  { 'Search TODOS', ":lua require'telescope'.search_todos()" },
	},
}

return command_palette
