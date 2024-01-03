local present, wk = pcall(require, 'which-key')
if not present then
  return
end

wk.setup {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 9, -- how many suggestions should be shown in the list?
    },
    presets = {
      operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = true, -- adds help for motions text_objects = false, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  operators = { gc = 'Comments' },
  key_labels = {
    ['<space>'] = '󱁐',
    ['telescope'] = ' ',
    ['Telescope'] = ' ',
    ['operator'] = '',
  },
  motions = {
    count = true,
  },
  icons = {
    breadcrumb = '»', -- symbol used in the command line area that shows your active key combo
    separator = '➜', -- symbol used between a key and it's label
    group = '+', -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = '<c-d>',
    scroll_up = '<c-u>',
  },
  window = {
    border = NvimConfig.ui.float.border or 'rounded', -- none, single, double, shadow, rounded
    position = 'bottom', -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 1, 2, 1, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },
  layout = {
    height = { min = 5, max = 40 }, -- min and max height of the columns
    width = { min = 20, max = 80 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = 'center', -- align columns left, center or right
  },
  ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
  hidden = {
    '<silent>',
    '<cmd>',
    '<Cmd>',
    '<CR>',
    'call',
    'lua',
    '^:',
    '^ ',
    'require',
    'escope',
    'erator',
    '"',
  }, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  show_keys = true,
  -- triggers = "auto", -- automatically setup triggers
  triggers = { '<leader>', '<LocalLeader>' }, -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { 'j', 'k' },
    v = { 'j', 'k' },
  },
}

local opts = {
  mode = 'n', -- NORMAL mode
  prefix = '<leader>',
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = false, -- use `nowait` when creating keymaps
}

local visual_opts = {
  mode = 'v', -- VISUAL mode
  prefix = '<leader>',
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = false, -- use `nowait` when creating keymaps
}

local normal_mode_mappings = {
  -- ignore
  ['1'] = 'which_key_ignore',
  ['2'] = 'which_key_ignore',
  ['3'] = 'which_key_ignore',
  ['4'] = 'which_key_ignore',
  ['5'] = 'which_key_ignore',
  ['6'] = 'which_key_ignore',
  ['7'] = 'which_key_ignore',
  ['8'] = 'which_key_ignore',
  ['9'] = 'which_key_ignore',

  ['/'] = { '<Plug>(comment_toggle_linewise_current)', 'Comment' },

  ['?'] = {
    name = 'Lazyman',
    ['/'] = { '<cmd>Startify<CR>', 'open dashboard' },
    m = { '<cmd>Mason<CR>', 'Manage packages' },
    p = { '<cmd>Lazy<CR>', 'Manage plugins' },
    u = { '<cmd>Lazy update<CR>', 'Update plugins' },
    s = {
      name = 'Session',
    },
  },

  a = {
    name = 'Actions',
    h = { '<cmd>nohlsearch<CR>', 'No Highlight' },
    n = { '<cmd>set nonumber!<CR>', 'Line numbers' },
    r = { '<cmd>set norelativenumber!<CR>', 'Relative number' },
    q = { require('utils').toggle_quicklist, 'Toggle quicklist' },
  },

  c = {
    name = 'ChatGPT',
    c = { '<cmd>ChatGPT<CR>', 'ChatGPT' },
    e = { '<cmd>ChatGPTEditWithInstruction<CR>', 'Edit with instruction', mode = { 'n', 'v' } },
    g = { '<cmd>ChatGPTRun grammar_correction<CR>', 'Grammar Correction', mode = { 'n', 'v' } },
    t = { '<cmd>ChatGPTRun translate<CR>', 'Translate', mode = { 'n', 'v' } },
    k = { '<cmd>ChatGPTRun keywords<CR>', 'Keywords', mode = { 'n', 'v' } },
    d = { '<cmd>ChatGPTRun docstring<CR>', 'Docstring', mode = { 'n', 'v' } },
    j = { '<cmd>ChatGPTRun add_tests<CR>', 'Add Tests', mode = { 'n', 'v' } },
    o = { '<cmd>ChatGPTRun optimize_code<CR>', 'Optimize Code', mode = { 'n', 'v' } },
    s = { '<cmd>ChatGPTRun summarize<CR>', 'Summarize', mode = { 'n', 'v' } },
    f = { '<cmd>ChatGPTRun fix_bugs<CR>', 'Fix Bugs', mode = { 'n', 'v' } },
    x = { '<cmd>ChatGPTRun explain_code<CR>', 'Explain Code', mode = { 'n', 'v' } },
    r = { '<cmd>ChatGPTRun roxygen_edit<CR>', 'Roxygen Edit', mode = { 'n', 'v' } },
    l = { '<cmd>ChatGPTRun code_readability_analysis<CR>', 'Code Readability Analysis', mode = { 'n', 'v' } },
    a = { '<cmd>ChatGPTActAs<CR>', 'Code Readability Analysis', mode = { 'n', 'v' } },
  },

  b = {
    name = '+Buffers',
    b = { '<cmd>Telescope buffers previewer=false<cr>', 'Find' },
    c = { '<cmd>lua require("utils").closeOtherBuffers()<CR>', 'Close but current' },
    d = { '<cmd>BufferLineSortByDirectory<cr>', 'Sort by directory' },
    e = { '<cmd>BufferLinePickClose<cr>', 'Pick which buffer to close' },
    f = { '<cmd>bfirst<CR>', 'First buffer' },
    l = { '<Cmd>Telescope current_buffer_fuzzy_find<CR>', 'Buffer lines' },
    L = { '<cmd>BufferLineSortByExtension<cr>', 'Sort by language' },
  },

  j = {
    name = 'JavaScript',
    g = { '<cmd>lua require("package-info").toggle()<cr>', 'Toggle package info' },
    u = { '<cmd>lua require("package-info").update()<cr>', 'Update package' },
    x = { '<cmd>lua require("package-info").delete()<cr>', 'Delete package' },
    v = { '<cmd>lua require("package-info").change_version()<cr>', 'Change Version' },
  },

  l = {
    name = '+LSP',
    a = { vim.lsp.buf.code_action, 'Code Action' },
    d = { '<cmd>TroubleToggle<CR>', 'Trouble local diagnostics' },
    q = { "<cmd>TroubleToggle quickfix<CR>", 'Trouble quickfix list' },
    D = { '<cmd>Telescope diagnostics wrap_results=true<CR>', 'workspace diagnostics' },
    t = { '<cmd>LspToggleAutoFormat<CR>', 'toggle format on save' },
    cl = { vim.lsp.codelens.run, 'CodeLens Action' },
    s = { '<cmd>Telescope lsp_document_symbols<cr>', 'Document Symbols' },
    i = { '<cmd>LspInfo<cr>', 'Info' },
    h = { "<cmd>lua require('lsp.functions').toggle_inlay_hints()<cr>", 'Hints' },
    l = { 'line diagnostics' },
    R = { 'structural replace' },
  },

  d = {
    name = 'Debug',
    a = { 'attach' },
    b = { 'breakpoint' },
    c = { 'continue' },
    C = { 'close UI' },
    d = { 'continue' },
    h = { 'visual hover' },
    i = { 'step into' },
    o = { 'step over' },
    O = { 'step out' },
    r = { 'repl' },
    s = { 'scopes' },
    t = { 'terminate' },
    U = { 'open UI' },
    v = { 'log variable' },
    V = { 'log variable above' },
    w = { 'watches' },
  },

  g = {
    name = '+Git',
    a = { '<cmd>!git add %:p<CR>', 'Add current' },
    A = { '<cmd>!git add .<CR>', 'Add all' },
    b = { '<cmd>lua require("internal.blame").open()<CR>', 'Blame' },
    c = {
      name = 'Conflict',
    },
    h = {
      name = 'Hunk',
    },
    i = { '<cmd>Octo issue list<CR>', 'Issues List' },
    l = {
      name = 'Lists',
      s = { '<cmd>Telescope git_status<CR>', 'Open changed file' },
      b = { '<cmd>Telescope git_branches<CR>', 'Checkout branch' },
      c = { '<cmd>lua require("plugins.telescope").my_git_commits()<CR>', 'Checkout commit' },
      C = { '<cmd>LazyGitFilterCurrentFile<CR>', 'Buffer commits' },
      l = { '<cmd>LazyGitFilter<CR>', 'Commits (Lazy)' },
      t = {
        '<cmd>lua require("plugins.telescope").my_git_bcommits()<CR>',
        'Checkout commit(for current file)',
      },
    },
    p = { '<cmd>Octo pr list<CR>', 'Pull Requests List' },
    w = {
      name = 'Worktree',
      w = 'worktrees',
      c = 'create worktree',
    },
    v = { '<Cmd>!gh repo view --web<CR>', 'View on GitHub' },
  },

  p = {
    name = 'Project',
    f = { 'file' },
    w = { 'word' },
    l = {
      "<cmd>lua require'telescope'.extensions.repo.cached_list{file_ignore_patterns={'/%.cache/', '/%.cargo/', '/%.local/', '/%timeshift/', '/usr/', '/srv/', '/%.oh%-my%-zsh', '/Library/', '/%.cocoapods/'}}<CR>",
      'list',
    },
    r = { 'refactor' },
    s = { '<cmd>SessionManager save_current_session<CR>', 'save session' },
    t = { '<cmd>TodoTrouble<CR>', 'todo' },
    h = {
      name = 'Harpoon',
      h = { '<cmd>Telescope harpoon marks<cr>', 'Harpoon Marks' },
      a = { require('harpoon.mark').add_file, 'Add file to harpoon' },
      n = { require('harpoon.ui').nav_next, 'Next harpoon file' },
      p = { require('harpoon.ui').nav_prev, 'Previous harpoon file' },
    },
  },

  r = {
    name = '+Repl',
    f = { '<cmd>IronFocus <CR>', 'Focus on Iron.Nvim split' },
    h = { '<cmd>IronHide <CR>', 'Hide Iron.Nvim split' },
    r = { '<cmd>IronRestart <CR>', 'Restart Iron.Nvim REPL' },
    R = { '<cmd>IronRepl <CR>', 'New Iron.Nvim REPL' },
  },

  s = {
    name = '+Search',
    d = { '<cmd>lua require("plugins.telescope").edit_neovim()<CR>', 'Dotfiles' },
    c = { '<cmd>Telescope colorscheme<CR>', 'Color Schemes' },
    b = { '<Cmd>Telescope file_browser<CR>', 'File Browser' },
    f = { '<Cmd>Telescope find_files_workspace<CR>', 'Files in workspace' },
    F = { '<Cmd>Telescope find_files<CR>', 'Files in cwd' },
    g = { '<Cmd>Telescope live_grep_workspace<CR>', 'Grep in workspace' },
    G = { '<Cmd>Telescope live_grep<CR>', 'Grep in cwd' },
    h = { '<Cmd>Telescope oldfiles hidden=true<CR>', 'File History' },
    o = { '<cmd>lua require("plugins.telescope").command_history()<CR>', 'Command History' },
    s = { '<cmd>Telescope search_history theme=dropdown<CR>', 'Search History' },
    t = { '<Cmd>Telescope builtin<CR>', 'Telescope lists' },
    w = { '<Cmd>Telescope grep_string_workspace<CR>', 'Grep word in workspace' },
    W = { '<Cmd>Telescope grep_string<CR>', 'Grep word in cwd' },
    v = {
      name = '+Vim',
      a = { '<Cmd>Telescope autocommands<CR>', 'Autocommands' },
      c = { '<Cmd>Telescope commands<CR>', 'Commands' },
      C = { '<Cmd>Telescope command_history<CR>', 'Command history' },
      h = { '<Cmd>Telescope highlights<CR>', 'Highlights' },
      q = { '<Cmd>Telescope quickfix<CR>', 'Quickfix list' },
      l = { '<Cmd>Telescope loclist<CR>', 'Location list' },
      m = { '<Cmd>Telescope keymaps<CR>', 'Keymaps' },
      s = { '<Cmd>Telescope spell_suggest<CR>', 'Spell suggest' },
      o = { '<Cmd>Telescope vim_options<CR>', 'Options' },
      r = { '<Cmd>Telescope registers<CR>', 'Registers' },
      t = { '<Cmd>Telescope filetypes<CR>', 'Filetypes' },
    },
    ['?'] = { '<Cmd>Telescope help_tags<CR>', 'Vim help' },
  },

  w = {
    name = '+Windows',
    -- Split creation
    s = { '<Cmd>split<CR>', 'Split below' },
    v = { '<Cmd>vsplit<CR>', 'Split right' },
    q = { '<Cmd>q<CR>', 'Close' },
    o = { '<Cmd>only<CR>', 'Close all other' },
    -- Navigation
    k = { '<Cmd>wincmd k<CR>', 'Go up' },
    j = { '<Cmd>wincmd j<CR>', 'Go down' },
    h = { '<Cmd>wincmd h<CR>', 'Go left' },
    l = { '<Cmd>wincmd l<CR>', 'Go right' },
    w = { '<Cmd>wincmd w<CR>', 'Go down/right' },
    W = { '<Cmd>wincmd W<CR>', 'Go up/left' },
    t = { '<Cmd>wincmd t<CR>', 'Go top-left' },
    b = { '<Cmd>wincmd b<CR>', 'Go bottom-right' },
    p = { '<Cmd>wincmd p<CR>', 'Go to previous' },
    -- Movement
    K = { '<Cmd>wincmd k<CR>', 'Move to top' },
    J = { '<Cmd>wincmd J<CR>', 'Move to bottom' },
    H = { '<Cmd>wincmd H<CR>', 'Move to left' },
    L = { '<Cmd>wincmd L<CR>', 'Move to right' },
    T = { '<Cmd>wincmd T<CR>', 'Move to new tab' },
    r = { '<Cmd>wincmd r<CR>', 'Rotate clockwise' },
    R = { '<Cmd>wincmd R<CR>', 'Rotate counter-clockwise' },
    z = { '<Cmd>packadd zoomwintab.vim | ZoomWinTabToggle<CR>', 'Toggle zoom' },
    -- Resize
    ['='] = { '<Cmd>wincmd =<CR>', 'All equal size' },
    ['-'] = { '<Cmd>resize -5<CR>', 'Decrease height' },
    ['+'] = { '<Cmd>resize +5<CR>', 'Increase height' },
    ['<'] = { '<Cmd>vertical resize -5<<CR>', 'Decrease width +5' },
    ['>'] = { '<Cmd>vertical resize +5<CR>', 'Increase width -5' },
    ['|'] = { '<Cmd>vertical resize 106<CR>', 'Full line-lenght' },
  },
}

local visual_mode_mappings = {
  -- single
  ['s'] = { "<cmd>'<,'>sort<CR>", 'sort' },

  a = {
    name = 'Actions',
  },

  c = {
    name = 'LSP',
    a = { 'range code action' },
    f = { 'range format' },
  },

  g = {
    name = 'Git',
    h = {
      name = 'Hunk',
      r = 'reset hunk',
      s = 'stage hunk',
    },
  },

  p = {
    name = 'Project',
    r = { 'refactor' },
  },

  r = {
    name = 'Refactor',
  },

  t = {
    name = 'Table Mode',
    t = { 'tableize' },
  },
}

-- ╭──────────────────────────────────────────────────────────╮
-- │ Register                                                 │
-- ╰──────────────────────────────────────────────────────────╯

wk.register(normal_mode_mappings, opts)
wk.register(visual_mode_mappings, visual_opts)

local function attach_markdown(bufnr)
  wk.register({
    a = {
      name = 'Actions',
      m = { '<cmd>MarkdownPreviewToggle<CR>', 'markdown preview' },
    },
  }, {
    buffer = bufnr,
    mode = 'n', -- NORMAL mode
    prefix = '<leader>',
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
  })
end

local function attach_typescript(bufnr)
  wk.register({
    l = {
      name = '+LSP',
      e = { '<cmd>TSC<cr>', 'Workspace Errors (TSC)' },
      F = { '<cmd>TSToolsFixAll<CR>', '✔ Fix all' },
      i = { '<cmd>TSToolsAddMissingImports<CR>', 'Add Imports / Import all' },
      r = { '<cmd>TSToolsRenameFile<cr>', 'Rename file' },
      u = { '<cmd>TSToolsRemoveUnused<CR>', 'Remove unused' },
      o = { '<cmd>TSToolsOrganizeImports<CR>', 'Organize imports' },
      -- s = { "<cmd>TSToolsSortImports<CR>", "Sort imports" },
    },
  }, {
    buffer = bufnr,
    mode = 'n', -- NORMAL mode
    prefix = '<leader>',
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
  })
end

local function attach_npm(bufnr)
  wk.register({
    n = {
      name = 'NPM',
      c = { '<cmd>lua require("package-info").change_version()<CR>', 'change version' },
      d = { '<cmd>lua require("package-info").delete()<CR>', 'delete package' },
      h = { "<cmd>lua require('package-info').hide()<CR>", 'hide' },
      i = { '<cmd>lua require("package-info").install()<CR>', 'install new package' },
      r = { '<cmd>lua require("package-info").reinstall()<CR>', 'reinstall dependencies' },
      s = { '<cmd>lua require("package-info").show()<CR>', 'show' },
      u = { '<cmd>lua require("package-info").update()<CR>', 'update package' },
    },
  }, {
    buffer = bufnr,
    mode = 'n', -- NORMAL mode
    prefix = '<leader>',
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
  })
end

local function attach_zen(bufnr)
  wk.register({
    ['z'] = { '<cmd>ZenMode<CR>', 'zen' },
  }, {
    buffer = bufnr,
    mode = 'n', -- NORMAL mode
    prefix = '<leader>',
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
  })
end

local function attach_jest(bufnr)
  wk.register({
    t = {
      name = '+Jest',
      j = { '<cmd>lua require("neotest").run.run()<CR>', 'Run Nearest' },
      f = { '<cmd>lua require("neotest").run.run(vim.fn.expand("%"))<CR>', 'Run Current File' },
      d = { '<cmd>lua require("neotest").run.run({ strategy = "dap"} )<cr>', 'Debug Nearest' },
      l = { '<cmd>lua require("neotest").run.run_last()<CR>', 'Run Last Test' },
      w = { '<cmd>lua require("neotest").run.run({ jestCommand = "jest --watch " })<CR>', 'Run Watch Mode' },
      i = { '<cmd>lua require("neotest").summary.toggle()<CR>', 'Toggle Info Panel' },
      o = { '<cmd>lua require("neotest").output.open({ enter = true })<CR>', 'Open Test Output' },
      s = { '<cmd>lua require("neotest").run.stop()<CR>', 'Stop Running' },
    },
  }, {
    buffer = bufnr,
    mode = 'n', -- NORMAL mode
    prefix = '<leader>',
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
  })
end

local function attach_spectre(bufnr)
  wk.register({
    ['R'] = { '[SPECTRE] Replace all' },
    ['o'] = { '[SPECTRE] Show options' },
    ['q'] = { '[SPECTRE] Send all to quicklist' },
    ['v'] = { '[SPECTRE] Change view mode' },
  }, {
    buffer = bufnr,
    mode = 'n', -- NORMAL mode
    prefix = '<leader>',
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
  })
end

local function attach_nvim_tree(bufnr)
  wk.register({
    ['='] = { '<cmd>NvimTreeResize +5<CR>', 'resize +5' },
    ['-'] = { '<cmd>NvimTreeResize -5<CR>', 'resize +5' },
  }, {
    buffer = bufnr,
    mode = 'n', -- NORMAL mode
    prefix = '<leader>',
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
  })
end

return {
  attach_markdown = attach_markdown,
  attach_typescript = attach_typescript,
  attach_npm = attach_npm,
  attach_zen = attach_zen,
  attach_jest = attach_jest,
  attach_spectre = attach_spectre,
  attach_nvim_tree = attach_nvim_tree,
}
