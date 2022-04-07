local key_map = vim.api.nvim_set_keymap
-- TELESCOPE keymaps 🔭 --
-- command palette
key_map(
  'n',
  '<leader>cp',
  [[<Cmd>lua require('telescope').extensions.command_palette.command_palette()<CR>]],
  { noremap = true, silent = true }
)
-- open available commands & run it
key_map(
  'n',
  ',c',
  [[<Cmd>lua require'telescope.builtin'.commands({results_title='Commands Results'})<CR>]],
  { noremap = true, silent = true }
)
-- telescope notify history
key_map(
  'n',
  '<leader>nh',
  [[<Cmd>lua require('telescope').extensions.notify.notify({results_title='Notification History', prompt_title='Search Messages'})<CR>]],
  { noremap = true, silent = true }
)
-- show Workspace Diagnostics
key_map(
  'n',
  ',d',
  [[<Cmd>lua require'telescope.builtin'.diagnostics()<CR>]],
  { noremap = true, silent = true }
)
-- Telescope oldfiles
key_map(
  'n',
  ',o',
  [[<Cmd>lua require'telescope.builtin'.oldfiles({results_title='Recent-ish Files'})<CR>]],
  { noremap = true, silent = true }
)
-- Telescope resume (last picker)
key_map(
  'n',
  '<leader>tr',
  [[<Cmd>lua require'telescope.builtin'.resume()<CR>]],
  { noremap = true, silent = true }
)

-- LSP!
-- show LSP implementations
key_map(
  'n',
  '<leader>ti',
  [[<Cmd>lua require'telescope.builtin'.lsp_implementations()<CR>]],
  { noremap = true, silent = true }
)
-- show LSP definitions
key_map(
  'n',
  '<leader>td',
  [[<Cmd>lua require'telescope.builtin'.lsp_definitions({layout_config = { preview_width = 0.50, width = 0.92 }, path_display = { "shorten" }, results_title='Definitions'})<CR>]],
  { noremap = true, silent = true }
)
-- show DOCUMENT Symbols
key_map(
  'n',
  ',ws',
  [[<Cmd>lua require'telescope.builtin'.lsp_document_symbols()<CR>]],
  { noremap = true, silent = true }
)

-- Github
-- issues
key_map(
  'n',
  '<leader>is',
  [[<Cmd>lua require'plugins.telescope'.gh_issues()<CR>]],
  { noremap = true, silent = true }
)
-- Pull Requests - PRs
key_map(
  'n',
  '<leader>pr',
  [[<Cmd>lua require'plugins.telescope'.gh_prs()<CR>]],
  { noremap = true, silent = true }
)
-- telescope-repo
key_map(
  'n',
  '<leader>rl',
  [[<Cmd>lua require('plugins.telescope').repo_list()<CR>]],
  { noremap = true, silent = true }
)
-- git telescope goodness
-- git_branches
key_map(
  'n',
  '<leader>gb',
  [[<Cmd>lua require'telescope.builtin'.git_branches({prompt_title = ' ', results_title='Git Branches'})<CR>]],
  {
    noremap = true,
    silent = true,
  }
)
-- git_bcommits - file scoped commits with diff preview. <C-V> for vsp diff to parent
key_map(
  'n',
  '<leader>gc',
  [[<Cmd>lua require'telescope.builtin'.git_bcommits({prompt_title = '  ', results_title='Git File Commits'})<CR>]],
  { noremap = true, silent = true }
)
-- git_commits (log) git log
key_map(
  'n',
  '<leader>gl',
  [[<Cmd>lua require'telescope.builtin'.git_commits()<CR>]],
  { noremap = true, silent = true }
)
-- git_status - <tab> to toggle staging
key_map(
  'n',
  '<leader>gs',
  [[<Cmd>lua require'telescope.builtin'.git_status()<CR>]],
  { noremap = true, silent = true }
)

-- Find registers
key_map(
  'n',
  '<leader>r',
  [[<Cmd>lua require'telescope.builtin'.registers()<CR>]],
  { noremap = true, silent = true }
)
-- Find current buffer
key_map(
  'n',
  ',bf',
  [[<Cmd>lua require'telescope.builtin'.current_buffer_fuzzy_find()<CR>]],
  { noremap = true, silent = true }
)
-- Find keymaps
key_map(
  'n',
  ',k',
  [[<Cmd>lua require'telescope.builtin'.keymaps({results_title='Key Maps Results'})<CR>]],
  { noremap = true, silent = true }
)
-- Find buffers
key_map(
  'n',
  ',b',
  [[<Cmd>lua require'telescope.builtin'.buffers({prompt_title = '', results_title='﬘', winblend = 3, layout_strategy = 'vertical', layout_config = { width = 0.60, height = 0.55 }})<CR>]],
  { noremap = true, silent = true }
)
-- Find help tags
key_map(
  'n',
  '<leader>h',
  [[<Cmd>lua require'telescope.builtin'.help_tags({results_title='Help Results'})<CR>]],
  { noremap = true, silent = true }
)
-- Find marks
key_map(
  'n',
  '<leader>m',
  [[<Cmd>lua require'telescope.builtin'.marks({results_title='Marks Results'})<CR>]],
  { noremap = true, silent = true }
)

-- Find files with gitfiles & fallback on find_files
key_map(
  'n',
  '<leader><TAB>',
  [[<Cmd>lua require'plugins.telescope'.project_files()<CR>]],
  { noremap = true, silent = true }
)
-- Find files including gitignored
key_map(
  'n',
  ',<leader>',
  [[<Cmd>lua require'telescope.builtin'.find_files({find_command={'fd','--no-ignore-vcs'}})<CR>]],
  { noremap = true, silent = true }
)

-- Explore files starting at $HOME
key_map(
  'n',
  '<leader>e',
  [[<Cmd>lua require'plugins.telescope'.file_explorer()<CR>]],
  { noremap = true, silent = true }
)
-- Browse files from cwd - File Browser
key_map(
  'n',
  '<leader>fb',
  [[<Cmd>lua require'telescope'.extensions.file_browser.file_browser()<CR>]],
  { noremap = true, silent = true }
)
-- Grep word under cursor
key_map(
  'n',
  '<leader>g',
  [[<Cmd>lua require'telescope.builtin'.grep_string()<CR>]],
  { noremap = true, silent = true }
)
-- Grep word under cursor - case-sensitive (exact word) - made for use with Replace All - see <leader>ra
key_map(
  'n',
  '<leader>gw',
  [[<Cmd>lua require'telescope.builtin'.grep_string({word_match='-w'})<CR>]],
  { noremap = true, silent = true }
)
-- Grep for a string
key_map(
  'n',
  '<leader>gp',
  [[<Cmd>lua require'plugins.telescope'.grep_prompt()<CR>]],
  { noremap = true, silent = true }
)

-- Grep open files
key_map(
  'n',
  '<leader>lg',
  [[<Cmd>lua require('telescope.builtin').live_grep({grep_open_files=true, preview=true})<CR>]],
  { noremap = true, silent = true }
)

-- Find files in config dirs
key_map(
  'n',
  '<leader>fc',
  [[<Cmd>lua require'plugins.telescope'.find_configs()<CR>]],
  { noremap = true, silent = true }
)
-- find or create neovim configs
key_map(
  'n',
  '<leader>nc',
  [[<Cmd>lua require'plugins.telescope'.nvim_config()<CR>]],
  { noremap = true, silent = true }
)

-- neoclip
key_map(
  'n',
  '<leader>ce',
  [[<Cmd>lua require('telescope').extensions.neoclip.default()<CR>]],
  { noremap = true, silent = true }
)
