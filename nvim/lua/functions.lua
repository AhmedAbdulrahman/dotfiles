-- luacheck: max line length 160

local utils = require('utils')
local async = require('plenary.async')
local Job = require "plenary.job"
local keymap = vim.keymap

-- Custom Folds, make them look better
vim.cmd([[
  function! CustomFold()
    return printf('   %-6d%s', v:foldend - v:foldstart + 1, getline(v:foldstart))
  endfunction
]])

-- It manages folds automatically based on treesitter
local parsers = require('nvim-treesitter.parsers')
local configs = parsers.get_parser_configs()
local ft_str = table.concat(
  vim.tbl_map(function(ft)
    return configs[ft].filetype or ft
  end, parsers.available_parsers()),
  ','
)

vim.cmd(
  'autocmd Filetype '
    .. ft_str
    .. ' setlocal foldmethod=expr foldexpr=nvim_treesitter#foldexpr()'
)

-- Exported functions
local M = {}

M.mkview_filetype_blocklist = {
  diff = true,
  gitcommit = true,
  hgcommit = true,
}

M.quit_on_q_allowlist = {
  preview = true,
  qf = true,
  fzf = true,
  netrw = true,
  help = true,
  taskedit = true,
  diff = true,
  man = true,
  grepper = true,
}

M.colorcolumn_blocklist = {
  qf = true,
  fzf = true,
  netrw = true,
  help = true,
  markdown = true,
  startify = true,
  text = true,
  gitconfig = true,
  gitrebase = true,
  conf = true,
  tags = true,
  vimfiler = true,
  dos = true,
  json = true,
  diff = true,
  minpacprgs = true,
  gitcommit = true,
  GrepperSide = true,
}

M.heavy_plugins_blocklist = {
  preview = true,
  qf = true,
  fzf = true,
  netrw = true,
  help = true,
  taskedit = true,
  diff = true,
  man = true,
  startify = true,
  gitcommit = true,
  hgcommit = true,
  vimfiler = true,
  dos = true,
  minpacprgs = true,
}

-- Local functions
--  Loosely based on: http://vim.wikia.com/wiki/Make_views_automatic
--  from https://github.com/wincent/wincent/blob/c87f3e1e127784bb011b0352c9e239f9fde9854f/roles/dotfiles/files/.vim/autoload/autocmds.vim#L20-L37
local function should_mkview()
  return vim.bo.buftype == ''
    and vim.fn.getcmdwintype() == ''
    and M.mkview_filetype_blocklist[vim.bo.filetype] == nil
    and vim.fn.exists('$SUDO_USER') == 0 -- Don't create root-owned files.
end

local function should_quit_on_q()
  return vim.wo.diff == true or M.quit_on_q_allowlist[vim.bo.filetype] == true
end

local function should_turn_off_colorcolumn()
  return vim.bo.textwidth == 0
    or vim.wo.diff == true
    or M.colorcolumn_blocklist[vim.bo.filetype] == true
    or vim.bo.buftype == 'terminal'
    or vim.bo.readonly == true
end

local function cleanup_marker(marker)
  if vim.fn.exists(marker) == 1 then
    vim.api.nvim_command('silent! call matchdelete(' .. marker .. ')')
    vim.api.nvim_command('silent! unlet ' .. marker)
  end
end

-- Exported functions
M.mkview = function()
  if should_mkview() then
    local success, err = pcall(function()
      if vim.fn.exists('*haslocaldir') and vim.fn.haslocaldir() then
        -- We never want to save an :lcd command, so hack around it...
        vim.api.nvim_command('cd -')
        vim.api.nvim_command('mkview')
        vim.api.nvim_command('lcd -')
      else
        vim.api.nvim_command('mkview')
      end
    end)
    if not success then
      if
        err:find('%f[%w]E186%f[%W]') == nil -- No previous directory: probably a `git` operation.
        and err:find('%f[%w]E190%f[%W]') == nil -- Could be name or path length exceeding NAME_MAX or PATH_MAX.
        and err:find('%f[%w]E5108%f[%W]') == nil
      then
        error(err)
      end
    end
  end
end

M.loadview = function()
  if should_mkview() then
    vim.api.nvim_command('silent! loadview')
    vim.api.nvim_command('silent! ' .. vim.fn.line('.') .. 'foldopen!')
  end
end

M.quit_on_q = function()
  if should_quit_on_q() then
    keymap.set(
      'n',
      'q',
      (
          (vim.wo.diff == true or vim.bo.filetype == 'man') and ':qa!'
          or (vim.bo.filetype == 'qf') and ':cclose'
          or ':q'
        ) .. '<cr>',
      { buffer = true, silent = true }
    )
  end
end

M.disable_heavy_plugins = function()
  if
    M.heavy_plugins_blocklist[vim.bo.filetype] ~= nil
    or vim.regex('\\.min\\..*$'):match_str(vim.fn.expand('%:t')) ~= nil
    or vim.fn.getfsize(vim.fn.expand('%')) > 200000
  then
    if vim.fn.exists(':ALEDisableBuffer') == 2 then
      vim.api.nvim_command(':ALEDisableBuffer')
    end
  end
end

M.highlight_overlength = function()
  cleanup_marker('w:last_overlength')

  if should_turn_off_colorcolumn() then
    vim.api.nvim_command('match NONE')
  else
    -- Use tw + 1 so invisble characters are not marked
    -- I have to escape the escape backslash to be able to pass it to vim
    -- Ex: I want "\(" I have to do it in Lua as "\\("
    local overlength_pattern = '\\%>' .. (vim.bo.textwidth + 1) .. 'v.\\+'
    -- [TODO]: figure out how to convert this to Lua
    vim.api.nvim_command(
      "let w:last_overlength = matchadd('OverLength', '"
        .. overlength_pattern
        .. "')"
    )
  end
end

M.yank_current_file_name = function()
	local file_name = vim.api.nvim_buf_get_name(0)
	local input_pipe = vim.loop.new_pipe(false)

	local yanker = Job:new {
	  writer = input_pipe,
	  command = "pbcopy",
	}

	-- @TODOUA: This works perfectly but double-check if it could be better(less)
	yanker:start()
	input_pipe:write(file_name)
	input_pipe:close()
	yanker:shutdown()

	require "notify"("Yanked: " .. file_name, "info", { title = "File Name Yanker", timeout = 1000 })
end

-- Project specific override
-- Better than what I had before https://github.com/mhinz/vim-startify/issues/292#issuecomment-335006879
M.source_project_config = function()
  local files = {
    '.vim/local.vim',
    '.vim/local.lua',
  }

  for _, file in pairs(files) do
    local current_file = vim.fn.findfile(file, vim.fn.expand('%:p') .. ';')

    if vim.fn.filereadable(current_file) == 1 then
      vim.api.nvim_command(string.format('silent source %s', current_file))
    end
  end
end

M.first_nvim_run = function()
  local is_first_run = utils.file_exists('/tmp/first-nvim-run')

  if is_first_run then
    async.run(function()
      require('notify')(
        "Welcome to Nvim config! Hope you'll have a nice experience!",
        'info',
        { title = 'Nvim', timeout = 5000 }
      )
	  require('notify')(
		"Please install treesitter servers manually by :TSInstall command.",
	  	"info",
		{ title = "Installation", timeout = 10000 }
	)
    end)
    local suc = os.remove('/tmp/first-nvim-run')
    if not suc then
      print("Error: Couldn't remove /tmp/first-nvim-run!")
    end
  end
end

-- M.first_nvim_run()

local win = require('lspconfig.ui.windows')
local _default_opts = win.default_opts
win.default_opts = function(options)
  local opts = _default_opts(options)
  opts.border = NvimConfig.ui.float.border
  return opts
end

return M
