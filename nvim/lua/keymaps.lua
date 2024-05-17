local set_keymap = require("utils.set-keymap")
local set_terminal_keymap = require("utils.set-terminal-keymap")

table.unpack = table.unpack or unpack -- 5.1 compatibility

-- ╭──────────────────────────────────────────────────────────╮
-- │ NAVIGATION                                               │
-- ╰──────────────────────────────────────────────────────────╯

set_keymap({
  list = {
      {
          key = "<leader>ro",
          actions = "<C-^>",
          description = "Rotate between last 2 opened buffers",
      },
      {
          key = "<C-h>",
          actions = "<C-w>h",
          description = "Navigate to the left buffer",
      },
      {
          key = "<C-l>",
          actions = "<C-w>l",
          description = "Navigate to the right buffer",
      },
      {
          key = "<C-j>",
          actions = "<C-w>j",
          description = "Navigate to the buffer below",
      },
      {
          key = "<C-k>",
          actions = "<C-w>k",
          description = "Navigate to the buffer above",
      },
      {
        key = "{",
        actions = "{zz",
        description = "Center { & } movements",
      },
      {
        key = "}",
        actions = "}zz",
        description = "Center { & } movements",
     },
     {
      key = "<leader>z",
      actions = function()
        if vim.b.zoomed then
          vim.cmd(vim.b.zoom_winrestcmd)
          vim.b.zoomed = false
        else
            vim.b.zoom_winrestcmd = vim.fn.winrestcmd()
            vim.cmd('resize')
            vim.cmd('vertical resize')
            vim.b.zoomed = true
        end
      end,
      description = "Toggle zoom window",
    },
  },
})

-- ╭──────────────────────────────────────────────────────────╮
-- │ BUFFER                                                   │
-- ╰──────────────────────────────────────────────────────────╯

set_keymap({
  list = {
    {
        key = "<C-s>",
        actions = "<C-w><",
        description = "Shift buffer to the left",
    },
    {
        key = "<C-a>",
        actions = "<C-w>>",
        description = "Shift buffer to the right",
    },
    {
        key = "<BS>",
        actions = function()
            vim.cmd("nohlsearch")
        end,
        description = "Clear search highlight",
    },
    {
        key = "n",
        actions = "nzzzv",
        description = "Center the next search result jump inside buffer",
    },
    {
        key = "N",
        actions = "Nzzzv",
        description = "Center the next search result jump inside buffer",
    },
    {
      key = "<Tab>",
      actions = ":BufferLineCycleNext<CR>",
      description = "Go to Previous in buffer list"
    },
    {
      key = "<S-Tab>",
      actions = ":BufferLineCyclePrev<CR>",
      description = "Go to Previous in buffer list"
    },
  },
})

-- ╭──────────────────────────────────────────────────────────╮
-- │ LSP                                                      │
-- ╰──────────────────────────────────────────────────────────╯

set_keymap({
  list = {
      {
        key = "L",
        actions = function()
          -- local winid = require('ufo').peekFoldedLinesUnderCursor()
          -- if not winid then
            vim.lsp.buf.hover()
          -- end
        end,
        description = "Show variable documentation in floating buffer",
      },
      {
        key = "<leader>K",
        actions = vim.lsp.buf.signature_help,
        description = "Displays signature information about the symbol under the cursor",
      },
      {
        key = "<leader>rn",
        actions = vim.lsp.buf.rename,
        description = "Rename variable",
      },
      {
        key = "<leader>D",
        actions = vim.lsp.buf.type_definition,
        description = "LSP Type Definition",
    },
      {
        key = "<leader>vD",
        actions = "<cmd>vsplit <BAR> lua vim.lsp.buf.type_definition()<CR>",
        description = "Open type definition in vertical split",
      },
      {
        key = "<leader>hD",
        actions = "<cmd>split <BAR> lua vim.lsp.buf.type_definition()<CR>",
        description = "Open type definition in horizontal split",
      },
      {
        key = "<leader>cf",
        actions = function()
          require('lsp.functions').format()
        end,
        description = "Format with LSP",
      },
      {
        key = "H",
        actions = function()
            vim.diagnostic.open_float(0, { scope = "line"  })
        end,
        description = "Show diagnostic in a floating buffer",
      },
      {
        key = "ca",
        actions = vim.lsp.buf.code_action,
        description = "Display code action list menu in floating buffer",
      },
      {
        key = "<leader>th",
        actions = function()
          require'utils'.diagnostic_toggle_virtual_text({
            buffer = true
          })
        end,
        description = "Display diagnostics for the given namespace and buffer",
      },
      {
        key = "[d",
        actions = function()
          vim.diagnostic.goto_next({
            buffer = true,
            wrap = true,
            float = {
              border = 'rounded',
              max_width = 100
            }
          })
        end,
        description = "Go to next diagnostic in current buffer",
      },
      {
        key = "]d",
        actions = function()
          vim.diagnostic.goto_prev({
            buffer = true,
            wrap = true,
            float = {
              border = 'rounded',
              max_width = 100
            }
          })
        end,
        description = "Go to previous diagnostic in current buffer",
      },
      {
        key = "<leader>lre",
        actions = function()
            vim.cmd("LspRestart")
        end,
        description = "Restart LSP server",
      },
  },
})

-- ╭──────────────────────────────────────────────────────────╮
-- │ Line                                                     │
-- ╰──────────────────────────────────────────────────────────╯

set_keymap({
  list = {
      {
          modes = { "i" },
          key = "jj",
          actions = "<ESC>",
          description = "Go to normal mode",
      },
      {
          modes = { "i" },
          key = "jk",
          actions = "<ESC>",
          description = "Go to normal mode",
      },
      {
          modes = { "i" },
          key = "kj",
          actions = "<ESC>",
          description = "Go to normal mode",
      },
      {
          modes = { "i" },
          key = "kk",
          actions = "<ESC>",
          description = "Go to normal mode",
      },
      {
          key = "gj",
          actions = "o<ESC>'[k",
          description = "Insert empty line below",
      },
      {
          key = "gk",
          actions = "O<ESC>j",
          description = "Insert empty line above",
      },
      {
          key = "<leader>d",
          actions = "<S-s><ESC>",
          description = "Delete everything on the line",
      },
      {
          key = "V",
          actions = "v$",
          description = "Highlight until the end of the line",
      },
      {
          key = "vv",
          actions = "V",
          description = "Highlight the whole line",
      },
      {
          key = "J",
          actions = "jddk",
          description = "Remove the line below",
      },
      {
          key = "K",
          actions = "kdd",
          description = "Remove the line above",
      },
      {
          key = "M",
          actions = "mzJ`z",
          description = "Fold line by line and keep current position",
      },
      {
        modes = { "x" },
        key = "K",
        actions = function()
          require'utils'.mappingsVisualMoveUp()
        end,
        -- actions = ":call mappings#visual#movelines#moveup()<CR>",
        description = "Move highlighted lines vertically",
      },
      {
        modes = { "x" },
        key = "J",
        actions = function()
          require'utils'.mappingsVisualMoveDown()
        end,
        -- actions = ":call mappings#visual#movelines#movedown()<CR>",
        description = "Move highlighted lines horizontally",
      },
  },
})

-- ╭──────────────────────────────────────────────────────────╮
-- │ Terminal                                                 │
-- ╰──────────────────────────────────────────────────────────╯

set_terminal_keymap({
  key = "<leader>gim",
  actions = "<C-\\><C-n>",
  description = "Go to insert mode in terminal",
})

-- ╭──────────────────────────────────────────────────────────╮
-- │ MISC                                                     │
-- ╰──────────────────────────────────────────────────────────╯

set_keymap({
  list = {
    {
      key = "<LEADER>cw",
      actions = "g<C-g>",
      description = "Display word count in current buffer",
    },
    {
      key = "<C-u>",
      actions = "<ESC>viwU",
      description = "Convert word under cursor to UPPERCASSE",
    },
    {
      modes = { "i" },
      key = "<C-u>",
      actions = "viwU<ESC>",
      description = "Convert word under cursor to UPPERCASSE",
    },
    {
      key = "<LEADER>lc",
      actions = ":CccPick<CR>",
      description = "Color Picker",
    },
    {
      key = "<leader>Q",
      actions = ":quitall",
      description = "Quit all windows",
    },
    -- {
    --   key = "<leader>rs",
    --   actions = function()
    --       vim.cmd("luafile %")
    --   end,
    --   description = "Resource current lua buffer",
    -- },
    {
        key = "<LEADER>sw",
        actions = ":set wrap<CR>",
        description = "Enable wrapping in the buffer",
    },
    {
      key = "<F10>",
      actions = "<Cmd>lua require('mappings/normal/syntax').reveal_syntax_group()<CR>",
      description = "Reveal syntax group under cursor",
    },
    -- Always send contents of a `x` command to the black hole register.
    {
      modes = { "n", "x" },
      key = "x",
      actions = "_x",
      description = "Don't yank on delete char",
    },
    {
      modes = { "n", "x" },
      key = "X",
      actions = "_X",
      description = "Don't yank on delete char",
    },
    {
      modes = { "n", "x" },
      key = "<leader>p",
      actions = "_dP",
      description = "Delete highlighted word into the void register then paste it over",
    },
    {
      modes = { "v" },
      key = "p",
      actions = "_dP",
      description = "Don't yank on visual paste",
    },
    {
      modes = { "x" },
      key = ".",
      actions = ":norm.<CR>",
      description = "Make dot work in visual mode",
    },
    {
      modes = { "x" },
      key = "<leader>r",
      actions = ':<c-u>%s/\\%V',
      description = "Easy regex replace for current word",
    },
    {
      key = "<Leader>V",
      actions = function()
        require("utils.functions").smart_paste()
      end,
      description = "Smart paste"
    },
    {
      key = "<Leader>c",
      actions = '"+y',
      description = "Smart copy"
    },
    {
      key = "<leader>x",
      actions = "<cmd>!chmod +x %<CR>'",
      description = 'Make file executable.',
    },
    {
      modes = { "x" },
      key = "+",
      actions = "g<C-a>",
      description = 'More easier increment/decrement mappings',
    },
    {
      modes = { "x" },
      key = "-",
      actions = "g<C-x>",
      description = 'More easier increment/decrement mappings',
    },
    {
      key = "Q",
      actions = "@@",
      description = 'Override Ex mode with run @@ to record, Q to replay',
    },
    {
      key = "c*",
      actions = '/\\<<C-r>=expand("<cword>")<CR>\\>\\C<CR>``cgn',
      description = 'Refactor word under cursor',
    },
    {
      key = "c#",
      actions = '?\\<<C-r>=expand("<cword>")<CR>\\>\\C<CR>``cgN',
      description = 'Refactor word under cursor',
    },
    {
      key = "g/",
      actions = ':Grep<Space>',
      description = 'Construct grep search',
    },
    {
      key = "gS",
      actions = ':Grep!<Space>',
      description = 'Construct grep search',
    },
    {
      key = "[l",
      actions = ':labove<CR>',
      description = 'Go previous location list entry',
    },
    {
      key = "]l",
      actions = ':lbelow<CR>',
      description = 'Go next location list entry',
    },
    {
      key = "<Space>",
      actions = '<NOP>',
      description = 'Space to NOP to prevent Leader issues',
    },
    {
      key = "<leader>i",
      actions = 'mmgg=G`m<CR>',
      description = 'Indent the entire file 😯, do you believe in magic',
    },
    {
      key = "Y",
      actions = 'y$',
      description = 'Make Y behave like C and D (to the end of line)',
    },
    {
      modes = { "i" },
      key = "<up>",
      actions = '<NOP>',
      description = 'Disable up arrow key',
    },
    {
      modes = { "i" },
      key = "<down>",
      actions = '<NOP>',
      description = 'Disable down arrow key',
    },
    {
      modes = { "i" },
      key = "<left>",
      actions = '<NOP>',
      description = 'Disable left arrow key',
    },
    {
      modes = { "i" },
      key = "<right>",
      actions = '<NOP>',
      description = 'Disable right arrow key',
    },
    {
      modes = { "i" },
      key = "<C-s>",
      actions = '<ESC> :w<CR>',
      description = 'Save file using CTRL-S and back to normal mode',
    },
    {
      modes = { "i" },
      key = "<C-l>",
      actions = '<C-o>$',
      description = 'This keybinding allows you to jump to the end of the line and we are switched back to insert mode',
    },
    {
      modes = { "i" },
      key = "<C-a>",
      actions = '<C-o>0',
      description = 'This keybinding allows you to instead jump to beginning of a line while in insert mode.',
    },
    -- {
    --   key = "gV",
    --   actions = [[`[v`]']],
    --   description = 'highlight last inserted text',
    -- },
    -- {
      -- modes = { "n", "x" },
    --   key = "/",
    --   actions = "/\v",
    --   description = "Always search with 'very magic' mode.",
    -- },
    -- {
      -- modes = { "n", "x" },
    --   key = "?",
    --   actions = "?\v",
    --   description = "Always search with 'very magic' mode.",
    -- },
  },
})

-- ╭──────────────────────────────────────────────────────────╮
-- │ SPELLCHECK                                               │
-- ╰──────────────────────────────────────────────────────────╯

set_keymap({
  list = {
        {
          key = "<leader>sr",
          actions = function()
              vim.cmd("mkspell! ./spell/en.utf-8.add")
          end,
          description = "Recreate spell database file",
      },
      {
          key = "zn",
          actions = "]s",
          description = "Go to next misspelled word",
      },
      {
          key = "zp",
          actions = "[s",
          description = "Go to previous misspelled word",
      },
      {
          key = "zf",
          actions = function()
              vim.api.nvim_input("z=1<CR>")
              vim.cmd("w")
              vim.cmd("e")
          end,
          description = "Apply the first misspell suggestion",
      },
      {
          key = "<leader>lf",
          actions = function()
              vim.api.nvim_input("[s")
              vim.api.nvim_input("z=1<CR>")
              vim.cmd("w")
              vim.cmd("e")
              vim.api.nvim_input("A")
          end,
          description = "Go to first misspell, fix it and go back to the end of line in insert mode",
      },
      {
        key = "cos",
        actions = ":set spell!<CR>",
        description = "Toggle spellcheck",
      },
      {
        key = "coH",
        actions = ":set hlsearch!<CR>",
        description = "Toggle highlight search",
    },
  },
})

-- Avoid issues because of remapping <c-a> and <c-x> below
-- vim.cmd [[
--   nnoremap <Plug>SpeedDatingFallbackUp <c-a>
--   nnoremap <Plug>SpeedDatingFallbackDown <c-x>
-- ]]


-- This will help with Vertical edit mode so we dont need to press <ESC> to
-- save changes vertically
-- keymap.set('i', '<C-c>', '<ESC>')

-- Print Current Datetime
-- keymap.set('n', '<leader>ncd', ':lua require("utils.functions").notify_current_datetime()<CR>', silent)

-- keymap.set('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])


-- save file using CTRL-S
-- keymap.set('<C-s>', ':write<Cr>', silent)

-- Jump to a tag directly when there is only one match.
-- keymap.set('n', '<C-]>', 'g<C-]>zt')

-- Open links under cursor in browser with gx
-- if vim.fn.has 'macunix' == 1 then
--   vim.keymap.set('n', 'gx', "<cmd>silent execute '!open ' . shellescape('<cWORD>')<CR>", silent)
-- else
--   vim.keymap.set('n', 'gx', "<cmd>silent execute '!xdg-open ' . shellescape('<cWORD>')<CR>", silent)
-- end

-- Open a new buffer in current session
-- keymap.set('<leader>e', ':e <C-R>=expand("%:p:h") . "/" <CR>')

-- QuickFix navigation mappings.
-- keymap.set('n', '<Up>', ':cprevious<CR>', silent)
-- keymap.set('n', '<Down>', ':cnext<CR>', silent)
-- keymap.set('n', '<Left>', ':cpfile<CR>', silent)
-- keymap.set('n', '<Right>', ':cnfile<CR>', silent)

-- keymap.set('n', '<Space>,', ':cp<CR>', silent)
-- keymap.set('n', '<Space>.', ':cn<CR>', silent)

-- From https://bitbucket.org/sjl/dotfiles/src/tip/vim/vimrc
-- The `zzzv` keeps search matches in the middle of the window.
-- and make sure n will go forward when searching with ? or #
-- https://vi.stackexchange.com/a/2366/4600
-- keymap.set('n', 'n', [[(v:searchforward ? 'n' : 'N') . 'zzzv']], { expr = true })
-- keymap.set('n', 'N', [[(v:searchforward ? 'N' : 'n') . 'zzzv']], { expr = true })


-- Move by 'display lines' rather than 'logical lines' if no v:count was
-- provided.  When a v:count is provided, move by logical lines.
-- Store relative line number jumps in the jumplist if they exceed a threshold.
-- vim.keymap.set('n', 'j', [[v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj']], { expr = true })
-- vim.keymap.set('x', 'j', [[v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj']], { expr = true })
-- vim.keymap.set('n', 'k', [[v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk']], { expr = true })
-- vim.keymap.set('x', 'k', [[v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk']], { expr = true })

-- vim.keymap.set('n', '<Leader>p', [[:t.<left><left>]])
-- vim.keymap.set('n', '<leader>e', [[:exe getline(line('.'))<cr>]])

-- keymap.set('n', '<C-g>', ':call ahmed#utils#SynStack()<cr>')

-- maintain the same shortcut as vim-gtfo becasue it's in my muscle memory.
-- keymap.set('n', 'gof', ':call ahmed#utils#OpenFileFolder()<cr>', {
--   silent = true,
-- })

-- Quick note taking per project
-- keymap.set('n', '<Localleader>t', ':tab drop .git/todo.md<CR>')

-- Redirect change operations to the blackhole
-- keymap.set('n', 'c', '"_c')
-- keymap.set('n', 'C', '"_C')

-- Create a directory if it doesn't exist
-- keymap.set('n', '<leader>mkd', ':!mkdir -p %:p:h<', {
--   silent = true,
-- })

-- new file in current directory
-- keymap.set('n', '<Leader>n', [[:e <C-R>=expand("%:p:h") . "/" <CR>]])

-- -- Manually invoke speeddating in case switch.vim didn't work
-- -- keymap.set('n', '<C-a>', ':if !switch#Switch() <bar> call speeddating#increment(v:count1) <bar> endif<CR>', silent)
-- keymap.set(
--   'n',
--   '<C-x>',
--   ":if !switch#Switch({'reverse': 1}) <bar> call speeddating#increment(-v:count1) <bar> endif<CR>",
--   silent
-- )
