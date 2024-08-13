-- vim: foldmethod=marker
local fn = vim.fn
local env = vim.env
local g = vim.g
local opt = vim.opt
local cmd = vim.cmd
local bo = vim.bo

local au = require('utils.au')

local root = env.USER == 'root'

g.mapleader = ' ' --- Map leader key to SPC
g.maplocalleader = ',' -- Map local leader key to comma
g.speeddating_no_mappings = 1 --- Disable default mappings for speeddating

-- opt. them directly if they are installed, otherwise disable them. To avoid the then
-- runtime check cost, which can be slow.
-- Python This must be here becasue it makes loading vim VERY SLOW otherwise
g.python_host_skip_check = 1
-- Disable python2 provider
g.loaded_python_provider = 0

g.python3_host_skip_check = 1

if fn.executable('python3') == 1 then
  -- set the default python PATH, to supposedly boost 🏎  performance
  g.python3_host_prog = fn.exepath('python3')
else
  g.loaded_python3_provider = 0
end

if fn.executable('neovim-node-host') == 1 then
  g.node_host_prog = fn.exepath('neovim-node-host')
else
  g.loaded_node_provider = 0
end

if fn.executable('neovim-ruby-host') == 1 then
  g.ruby_host_prog = fn.exepath('neovim-ruby-host')
else
  g.loaded_ruby_provider = 0
end

g.loaded_perl_provider = 0

-- settings for displaying errors
-- g:errorformat = '%f:%l:%c: %trror: %m,' . '%f:%l:%c: %tarning: %m,' . '%f:%l:%c: %tote: %m'

-- Correct terminal colors
-- uses "gui" highlights instead of "cterm"
opt.termguicolors = true -- Enables 24-bit RGB color support in TUI.

-- Set font to be used in GUIs (Neovide, etc)
opt.guifont = "Cascadia Code PL"

-- Global Options
opt.mouse = table.concat({ -- Enable mouse support for normal and visual modes.
  'n', -- Normal mode
  'v', -- Visual mode
  --   'a'
})
-- line numbers
opt.number = true --- Shows current line number
opt.relativenumber = true --- Enables relative number
opt.startofline = true -- Move cursor to the start of each line when jumping with certain commands.
opt.report = 1000 -- Threshold for reporting number of lines changed.
opt.scrolloff = 8 -- Minimum number of screen lines to keep above and below the cursor.
opt.shortmess =
  table.concat({ -- Use abbreviations and short messages in command menu line.
    'f', -- Use "(3 of 5)" instead of "(file 3 of 5)".
    'i', -- Use "[noeol]" instead of "[Incomplete last line]".
    'l', -- Use "999L, 888C" instead of "999 lines, 888 characters".
    'm', -- Use "[+]" instead of "[Modified]".
    'n', -- Use "[New]" instead of "[New File]".
    'r', -- Use "[RO]" instead of "[readonly]".
    'w', -- Use "[w]", "[a]" instead of "written", "appended".
    'x', -- Use "[dos]", "[unix]", "[mac]" instead of "[dos format]", "[unix format]", "[mac format]".
    'o', -- Overwrite message for writing a file with subsequent message.
    'O', -- Message for reading a file overwrites any previous message.
    's', -- Disable "search hit BOTTOM, continuing at TOP" such messages.
    't', -- Truncate file message at the start if it is too long.
    'T', -- Truncate other messages in the middle if they are too long.
    'I', -- Don't give the :intro message when starting.
    'c', -- Don't give ins-completion-menu messages.
    'F', -- Don't give the file info when editing a file.
  })
opt.viewoptions = 'cursor,folds' -- save/restore just these (with `:{mk,load}view`)
opt.sidescroll = 3 -- Columns to scroll horizontally when cursor is moved off the screen.
opt.sidescrolloff = 5 -- Minimum number of screen columns to keep to cursor right.
-- Fix slight delay after pressing ESC then O http://ksjoberg.com/vim-esckeys.html
opt.timeoutlen = 300 -- Faster completion (cannot be lower than 200 because then commenting doesn't work)
opt.ttimeoutlen = 0 -- Time in milliseconds to wait for a key code sequence to complete.
opt.updatetime = 100 -- Trigger CursorHold event faster.
opt.updatecount = 0 -- Update swapfiles every 80 typed chars (I don't use swap files anymore)
opt.viminfo = "'1000" -- Increase the size of file history

opt.diffopt = { -- Option settings for diff mode.
  'vertical',
  'algorithm:histogram',
  'indent-heuristic',
  'hiddenoff',
}
opt.cmdheight = 2 --- Give more space for displaying messages
opt.completeopt = { -- Options for insert mode completion.
  'menu', -- Use the pop-up menu.
  'menuone', -- Use the pop-up menu also when there is only one match.
  'noselect', -- Do not select a match in the menu.
}

opt.virtualedit = 'block' -- Allow cursor to move where there is no text in visual block mode
opt.winblend = 10
opt.whichwrap = 'b,h,l,s,<,>,[,],~' -- Allow <BS>/h/l/<Left>/<Right>/<Space>, ~ to cross line boundaries

opt.fillchars = { -- Characters to be used in various user-interface elements.
  stl = ' ', -- Status line of the current window.
  stlnc = ' ', -- Status line of the non-current windows.
  vert = '┃', -- Vertical separator to be used with :vsplit.
  fold = '─', -- Character to be used with 'foldtext'.
  diff = '⣿', -- Deleted lines of the 'diff' option.
  msgsep = '‾', -- Message separator for 'display' option.
  eob = ' ', -- Empty lines at the end of a buffer.
  foldopen = '▾',
  foldsep = '│',
  foldclose = '▸',
}
opt.tildeop = true -- Make tilde command behave like an operator.
opt.list = true -- Show characters in 'listchars' in place of certain special characters.
opt.listchars = { -- Strings to use when 'list' option set.
  tab = '⋅ ', -- Characters to be used to show a tab.
  nbsp = '░', -- Character to show for a non-breakable space character.
  extends = '»', -- Character to show in the last column, when 'wrap' is off.
  precedes = '«', -- Character to show in the first visible column.
  trail = '␣',
  lead = "·",
}

if not vim.fn.has('nvim-0.6') then
  vim.opt.joinspaces = false
end

opt.concealcursor = 'n'
-- cursor behavior:
--   - no blinking in normal/visual mode
--   - blinking in insert-mode
opt.guicursor:append(
  'n-v-c:blinkon0,i-ci:ver25-Cursor/lCursor-blinkwait30-blinkoff100-blinkon100'
)
opt.pumheight = 10 -- Maximum number of items to show in the popup menu.
opt.pumblend = 10
-- opt.inccommand = 'split' -- Show live substitution results as you type.
if not vim.fn.has('nvim-0.6') then
  vim.opt.inccommand = 'nosplit'
end
opt.shiftround = true -- Round indent to multiple of 'shiftwidth'.
opt.foldcolumn = '0'
opt.foldnestmax = 0
opt.foldlevel = 99 -- Using ufo provider need a large value
opt.foldlevelstart = 99 -- Start editing with all folds open.
opt.foldopen = { -- Specifies for which type of commands folds will be opened.
  'hor', -- Horizontal movements: "l", "w", "fx", etc.
  'mark', -- Jumping to a mark: "'m", CTRL-O, etc.
  'percent', -- % key.
  'quickfix', -- ":cn", ":crew", ":make", etc.
  'tag', -- Jumping to a tag: ":ta", CTRL-T, etc.
  'undo', -- Undo or redo: "u" and CTRL-R.
}
opt.grepprg = 'grep ' -- Program to use for the :grep command.
  .. '--line-number '
  .. '--column -I'
  .. '--ignore-case'
  .. '--untracked'
  .. '--binary-file="without-match" '
  .. '--no-messages '
  .. '--recursive '
  .. '--exclude-dir={.git,node_modules} '
  .. '--perl-regexp'
opt.grepformat = '%f:%l:%c:%m,%f:%l:%m' -- Format to recognize for the :grep command output.
opt.fillchars = 'stl: '
opt.ignorecase = true -- Ignore case in search patterns.
opt.laststatus = 3 --- Have a global statusline at the bottom instead of one for each window
opt.smartcase = true -- Set 'noignorecase' if search pattern contains an uppercase letter.
opt.undolevels = 100000 -- Maximum number of changes that can be undone.
opt.splitbelow = true -- Splitting a window will put the new window below of the current one.
opt.splitright = true -- Splitting a window will put the new window right of the current one.
opt.switchbuf = 'useopen' -- Jump to the first open window that contains the specified buffer.
opt.showcmd = false -- Disable displaying key presses at the right bottom.
opt.showmatch = true -- Highlight matching [{()}]
opt.backspace = 'indent,eol,start' --- Making sure backspace works
--- Concealed text is completely hidden unless it has a custom replacement character defined (needed for dynamically showing tailwind classes)
opt.conceallevel = 2
opt.concealcursor = '' --- Set to an empty string to expand tailwind class when on cursorline
opt.encoding = 'utf-8' --- The encoding displayed
opt.fileencoding = 'utf-8' --- The encoding written to file
opt.incsearch = true --- Start searching before pressing enter

-- Window Options
opt.title = true
opt.breakindent = true -- Wrapped lines will be visually indented with same amount of space.
opt.breakindentopt = 'sbr,shift:' .. bo.shiftwidth
opt.showbreak = '↳  ' -- DOWNWARDS ARROW WITH TIP RIGHTWARDS (U+21B3, UTF-8: E2 86 B3)
opt.wrap = false -- Prevent wrapping for long lines.don't wrap text by default
vim.wo.colorcolumn = '80' -- formatting hints
opt.textwidth = 80
opt.linebreak = true -- Wrap long lines at a character in 'breakat'.
opt.number = true -- Print the line number in front of each line.
opt.cursorline = true -- Highlight the screen line of the cursor with CursorLine.
opt.signcolumn = 'yes:2' -- Always draw the sign column even there is no sign in it.
opt.foldmethod = 'indent' -- Use indent folding method to fold lines.
opt.emoji = false
opt.formatoptions:remove('c')
opt.formatoptions:remove('r')
opt.formatoptions:remove('o')
opt.formatoptions:append('n')
opt.formatoptions:append('r1')
opt.visualbell = false -- No beeping.
opt.errorbells = false -- No flashing.
opt.clipboard = 'unnamed,unnamedplus' -- yank and paste between vim and everything else

-- Buffer Options
opt.modeline = false -- Disable modeline feature altogether.
opt.softtabstop = -1 -- Number of spaces that a <Tab> counts.
opt.expandtab = true -- Use spaces instead of tab characters.
opt.shiftwidth = 2 -- Number of spaces to use for each step of auto indent.
opt.tabstop = 2 -- Number of spaces that a <Tab> in the file counts for.
opt.undofile = true -- Persist undo history to an undo file.
-- Use cmd until https://github.com/neovim/neovim/issues/14670 is fixed.
-- cmd('set keymap=diacritic') -- Enable diacritic key mappings in keymap folder.
cmd('syntax sync minlines=256') -- Start highlighting from 256 lines backwards
opt.synmaxcol = 300 -- Do not highlight very long lines
-- opt.lazyredraw = true -- Don't bother updating screen during macro playback

-- File find: navigable menu for tab completion
opt.wildmode = 'longest:full,list,full'
opt.wildignore:append(
  '*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem,*.pyc'
)
opt.wildignore:append('*.swp,*~,*/.DS_Store')
opt.wildignore:append('*node_modules/**')
if not vim.fn.has('nvim-0.6') then
  vim.opt.hidden = true
end
opt.tagcase = 'followscs'
opt.tags:prepend('./.git/tags;')

-- https://robots.thoughtbot.com/opt-in-project-specific-vim-spell-checking-and-word-completion
opt.spelllang = 'en_us'
opt.spellsuggest = '30'
opt.spellfile = string.format('%s%s', fn.stdpath('config'), '/spell/en.utf-8.add')

-- Disable unsafe commands. Only run autocommands owned by me http://andrew.stwrt.ca/posts/project-specific-vimrc/
opt.secure = true
opt.complete:append('kspell')

opt.backupcopy = 'yes' -- overwrite files to update, instead of renaming + rewriting
opt.backup = false
opt.writebackup = false -- Not needed

-- keep backup files out of the way
if not vim.fn.has('nvim-0.6') then
  vim.opt.backupdir =
    string.format('%s,%s%s', '.', vim.fn.stdpath('data'), '/backup//')
end

opt.swapfile = false
opt.directory = string.format('%s%s', fn.stdpath('data'), '/swap//') -- keep swap files out of the way
opt.directory:append('.')

if root then
  opt.undofile = false -- don't create root-owned files
else
  opt.undofile = true -- actually use undo files
  opt.undodir:append('.')
end

if root then -- don't create root-owned files then
  opt.shada = ''
  opt.shadafile = 'NONE'
else
  -- Defaults:
  --   Neovim: !,'100,<50,s10,h
  -- - ! save/restore global variables (only all-uppercase variables)
  -- - '100 save/restore marks from last 100 files
  -- - <50 save/restore 50 lines from each register
  -- - s10 max item size 10KB
  -- - h do not save/restore 'hlsearch' setting
  au.group('MyNeovimShada', function(gr)
    gr(
      { 'CursorHold', 'FocusGained', 'FocusLost' },
      { '*', [[if &bt == '' | rshada|wshada | endif]] }
    )
  end)
end

-- PLUGINS
vim.g.markdown_fenced_languages = {
  'css',
  'erb=eruby',
  'javascript',
  'js=javascript',
  'jsx=javascriptreact',
  'ts=typescript',
  'tsx=typescriptreact',
  'json=jsonc',
  'ruby',
  'sass',
  'scss=sass',
  'xml',
  'html',
  'py=python',
  'python',
  'clojure',
  'clj=clojure',
  'clojurescript',
  'cljs=clojurescript',
  'stylus=css',
  'less=css',
  'viml=vim',
  'mdx=markdown',
}

local vimrc_local = string.format('%s%s', env.HOME, '/.nvimrc.lua')

if fn.filereadable(vimrc_local) == 1 then
  cmd(string.format('silent source %s', vimrc_local))
end

if vim.g.neovide then
  vim.opt.title = true
  vim.opt.guifont = NvimConfig.ui.font
  vim.g.neovide_scale_factor = 1.1
  vim.g.neovide_refresh_rate = 144
  vim.g.neovide_underline_stroke_scale = 0.5
  vim.g.neovide_input_use_logo = 1
  vim.g.neovide_input_macos_option_key_is_meta = 'only_left'

  vim.keymap.set({ 'n', 'v' }, '<D-c>', '"+y')  -- Copy
  vim.keymap.set({'n', 'v'}, '<D-v>', '"*p')    -- Paste normal/visual mode
  vim.keymap.set({'c', 'i'}, '<D-v>', '<C-R>+') -- Paste command/insert mode
end
