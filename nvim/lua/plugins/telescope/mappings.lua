local keymap = vim.keymap
local silent = { silent = true }

-- TELESCOPE keymaps 🔭 --
-- command palette
keymap.set(
  'n',
  '<leader>cp',
  [[<Cmd>lua require('telescope').extensions.command_palette.command_palette()<CR>]],
  silent
)
-- open available commands & run it
keymap.set(
  'n',
  ',c',
  [[<Cmd>lua require'telescope.builtin'.commands({results_title='Commands Results'})<CR>]],
  silent
)
-- telescope notify history
keymap.set(
  'n',
  '<leader>nh',
  [[<Cmd>lua require('telescope').extensions.notify.notify({results_title='Notification History', prompt_title='Search Messages'})<CR>]],
  silent
)
-- show Workspace Diagnostics
keymap.set(
  'n',
  ',d',
  [[<Cmd>lua require'telescope.builtin'.diagnostics()<CR>]],
  silent
)
-- Telescope oldfiles
keymap.set(
  'n',
  '<leader>?',
  [[<Cmd>lua require'telescope.builtin'.oldfiles({results_title='[?] Find recently opened files'})<CR>]],
  silent
)
-- Telescope resume (last picker)
keymap.set(
  'n',
  '<leader>tr',
  [[<Cmd>lua require'telescope.builtin'.resume()<CR>]],
  silent
)

-- LSP!
-- show LSP implementations
keymap.set(
  'n',
  '<leader>ti',
  [[<Cmd>lua require'telescope.builtin'.lsp_implementations()<CR>]],
  silent
)
-- show LSP definitions
keymap.set(
  'n',
  '<leader>td',
  [[<Cmd>lua require'telescope.builtin'.lsp_definitions({layout_config = { preview_width = 0.50, width = 0.92 }, path_display = { "shorten" }, results_title='Definitions'})<CR>]],
  silent
)
-- show DOCUMENT Symbols
keymap.set(
  'n',
  ',ws',
  [[<Cmd>lua require'telescope.builtin'.lsp_document_symbols()<CR>]],
  silent
)

-- Github
-- issues
keymap.set(
  'n',
  '<leader>is',
  [[<Cmd>lua require'plugins.telescope'.gh_issues()<CR>]],
  silent
)
-- Pull Requests - PRs
keymap.set(
  'n',
  '<leader>pl',
  [[<Cmd>lua require'plugins.telescope'.gh_prs()<CR>]],
  silent
)
-- telescope-repo
keymap.set(
  'n',
  '<leader>rl',
  [[<Cmd>lua require('plugins.telescope').repo_list()<CR>]],
  silent
)
-- git telescope goodness
-- git_branches
keymap.set(
  'n',
  '<leader>gb',
  [[<Cmd>lua require'telescope.builtin'.git_branches({prompt_title = ' ', results_title='Git Branches'})<CR>]],
  {
    noremap = true,
    silent = true,
  }
)
-- git_bcommits - file scoped commits with diff preview. <C-V> for vsp diff to parent
keymap.set(
  'n',
  '<leader>gfc',
  [[<Cmd>lua require'telescope.builtin'.git_bcommits({prompt_title = '  ', results_title='Git File Commits'})<CR>]],
  silent
)
-- git_commits (log) git log
keymap.set(
  'n',
  '<leader>gc',
  [[<Cmd>lua require'telescope.builtin'.git_commits()<CR>]],
  silent
)
-- git_status - <tab> to toggle staging
keymap.set(
  'n',
  '<leader>gs',
  [[<Cmd>lua require'telescope.builtin'.git_status()<CR>]],
  silent
)

-- Find registers
keymap.set(
  'n',
  '<leader>r',
  [[<Cmd>lua require'telescope.builtin'.registers()<CR>]],
  silent
)
-- Find current buffer
keymap.set(
  'n',
  ',bf',
  [[<Cmd>lua require'telescope.builtin'.current_buffer_fuzzy_find()<CR>]],
  silent
)
-- Find keymaps
keymap.set(
  'n',
  ',k',
  [[<Cmd>lua require'telescope.builtin'.keymaps({results_title='Key Maps Results'})<CR>]],
  silent
)
-- Find buffers
keymap.set(
  'n',
  ',b',
  [[<Cmd>lua require'telescope.builtin'.buffers({results_title='[ ] Find existing buffers', winblend = 3, layout_strategy = 'vertical', layout_config = { width = 0.60, height = 0.55 }})<CR>]],
  silent
)
-- Find help tags
keymap.set(
  'n',
  '<leader>h',
  [[<Cmd>lua require'telescope.builtin'.help_tags({results_title='[!] Help Tags'})<CR>]],
  silent
)
-- Find marks
keymap.set(
  'n',
  '<leader>m',
  [[<Cmd>lua require'telescope.builtin'.marks({results_title='[⏹] Marks'})<CR>]],
  silent
)

-- Find files with gitfiles & fallback on find_files
keymap.set(
  'n',
  '<leader><TAB>',
  [[<Cmd>lua require'plugins.telescope'.project_files()<CR>]],
  silent
)
-- Find files including gitignored
keymap.set(
  'n',
  ',<leader>',
  [[<Cmd>lua require'telescope.builtin'.find_files({find_command={'fd','--no-ignore-vcs'}})<CR>]],
  silent
)

-- Explore files starting at $HOME
keymap.set(
  'n',
  '<leader>e',
  [[<Cmd>lua require'plugins.telescope'.file_explorer()<CR>]],
  silent
)
-- Browse files from cwd - File Browser
keymap.set(
  'n',
  '<leader>fb',
  [[<Cmd>lua require'telescope'.extensions.file_browser.file_browser()<CR>]],
  silent
)
-- Grep word under cursor
-- keymap.set(
--   'n',
--   '<leader>g',
--   [[<Cmd>lua require'telescope.builtin'.grep_string()<CR>]],
--   silent
-- )
-- Grep word under cursor - case-sensitive (exact word) - made for use with Replace All - see <leader>ra
keymap.set(
  'n',
  '<leader>gw',
  [[<Cmd>lua require'telescope.builtin'.grep_string({word_match='-w'})<CR>]],
  silent
)
-- Grep for a string
keymap.set(
  'n',
  '<leader>gp',
  [[<Cmd>lua require'plugins.telescope'.grep_prompt()<CR>]],
  silent
)

-- Multi grep
keymap.set(
  'n',
  '<leader>/',
  "<CMD>lua require('plugins.telescope.pickers.multi-rg')()<CR>",
  silent
)

-- Grep open files
keymap.set(
  'n',
  '<leader>lg',
  [[<Cmd>lua require('telescope.builtin').live_grep({grep_open_files=true, preview=true})<CR>]],
  silent
)

-- Find files in config dirs
keymap.set(
  'n',
  '<leader>fc',
  [[<Cmd>lua require'plugins.telescope'.find_configs()<CR>]],
  silent
)
-- find or create neovim configs
keymap.set(
  'n',
  '<leader>nc',
  [[<Cmd>lua require'plugins.telescope'.nvim_config()<CR>]],
  silent
)

-- neoclip
keymap.set(
  'n',
  '<leader>ce',
  [[<Cmd>lua require('telescope').extensions.neoclip.default()<CR>]],
  silent
)
