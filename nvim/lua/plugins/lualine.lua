require('multicursors').setup({
  hint_config = false,
})

local lualine = require('lualine')

-- Color table for highlights
local colors = {
  bg = '#262f3e',
  fg = '#606375',
  yellow = '#ecc48d',
  cyan = '#7fdbca',
  darkblue = '#1f2430',
  green = '#addb67',
  orange = '#FF8800',
  violet = '#FD98B9',
  magenta = '#c792ea',
  blue = '#6cbeff',
  red = '#f45c7f',
}

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand('%:p:h')
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
  spell_status = function()
    local spell = vim.api.nvim_get_option_value('spell', {})
    local lang = vim.api.nvim_get_option_value('spelllang', {})
    if spell then
      local res = '[SPELL'
      if lang then
        res = res .. ' ' .. string.upper(lang)
      end
      res = res .. ']'
      return res
    end
    return ''
  end,
  current_buffer_number = function()
    return '﬘ ' .. vim.api.nvim_get_current_buf()
  end,
  word_count = function()
    if vim.bo.filetype == 'markdown' or vim.bo.filetype == 'text' then
      return string.format(
        '%%4* %d %s %%*',
        vim.fn.wordcount()['words'],
        'words'
      )
    end
    return ''
  end,
  diff_source = function()
    local gitsigns = vim.b.gitsigns_status_dict
    if gitsigns then
      return {
        added = gitsigns.added,
        modified = gitsigns.changed,
        removed = gitsigns.removed,
      }
    end
  end,
  is_hydra_active = function()
    local ok, hydra = pcall(require, 'hydra.statusline')
    return ok and hydra.is_active()
  end,
  get_hydra_name = function()
    local ok, hydra = pcall(require, 'hydra.statusline')
    if ok and hydra.is_active() then
      return hydra.get_name()
    end
    return ''
  end,
}

-- Config
local config = {
  options = {
    -- Disable sections and component separators
    section_separators = { left = '', right = '' },
    component_separators = { left = '⦁', right = '⦁' },
    disabled_filetypes = {},
    theme = {
      -- We are going to use lualine_c an lualine_x as left and
      -- right section. Both are highlighted by c theme .  So we
      -- are just setting default looks o statusline
      normal = {
        c = { fg = colors.fg, bg = colors.bg },
        y = { fg = colors.fg, bg = colors.bg },
      },
      inactive = { c = { fg = colors.fg, bg = colors.bg } },
    },
  },
  sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {
      conditions.spell_status,
      { conditions.current_buffer_number, color = { fg = colors.fg } },
      { conditions.word_count, color = { fg = colors.fg } },
      -- {
      -- 	'filetype',
      -- 	separator = {
      -- 		left = '⦁',
      -- 	}
      -- }
    },
    lualine_z = {},
    -- These will be filled later
    lualine_c = {},
    lualine_x = {},
  },
  inactive_sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_v = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
  extensions = { 'fugitive' },
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x ot right section
local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

ins_left({
  function()
    return '▊'
  end,
  color = { fg = colors.bg }, -- Sets highlighting of component
  left_padding = 0, -- We don't need space before this
})

ins_left({
  'mode',
  -- mode component
  fmt = function(str)
    -- auto change color according to neovims mode
    local mode_color = {
      n = colors.red,
      i = colors.green,
      v = colors.blue,
      [''] = colors.blue,
      V = colors.blue,
      c = colors.magenta,
      no = colors.red,
      s = colors.orange,
      S = colors.orange,
      [''] = colors.orange,
      ic = colors.yellow,
      R = colors.violet,
      Rv = colors.violet,
      cv = colors.red,
      ce = colors.red,
      r = colors.cyan,
      rm = colors.cyan,
      ['r?'] = colors.cyan,
      ['!'] = colors.red,
      t = colors.red,
    }
    vim.api.nvim_command(
      'hi! LualineMode guifg='
        .. mode_color[vim.fn.mode()]
        .. ' guibg='
        .. colors.bg
    )
    return str:sub(1, 1)
  end,
  color = 'LualineMode',
  left_padding = 0,
})

ins_left({
  -- filesize component
  'filesize',
  condition = conditions.buffer_not_empty,
})

ins_left({
  'filename',
  file_status = true, -- displays file status (readonly status, modified status)
  path = 0, -- 0 = just filename, 1 = relative path, 2 = absolute path
  shorting_target = 40, -- Shortens path to leave 40 space in the window
  symbols = { modified = '[]', readonly = ' ' },
  -- for other components. Terrible name any suggestions?
  condition = conditions.buffer_not_empty,
  color = { fg = colors.violet, gui = 'bold' },
})

ins_left({ 'location' })

ins_left({ 'progress', color = { fg = colors.fg, gui = 'bold' } })

ins_left({
  'diagnostics',
  sources = { 'nvim_diagnostic' },
  symbols = { error = ' ', warn = ' ', info = ' ' },
  color_error = colors.red,
  color_warn = colors.yellow,
  color_info = colors.cyan,
})

ins_left({
  conditions.get_hydra_name,
  condition = conditions.is_hydra_active,
  color = { fg = colors.violet, gui = 'bold' },
})

--   Insert mid section. You can make any number of sections in neovim :)
--   for lualine it's any number greater then 2
ins_left({
  function()
    return '%='
  end,
})

ins_left({
  -- Lsp server name .
  function()
    local msg = 'No Active Lsp'
    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then
      return msg
    end
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        return client.name
      end
    end
    return msg
  end,
  icon = 'LSP:',
  color = { fg = '#ffffff', gui = 'bold' },
})

-- Add components to right sections
ins_right({
  'o:encoding', -- option component same as &encoding in viml
  upper = true, -- I'm not sure why it's upper case either ;)
  condition = conditions.hide_in_width,
  color = { fg = colors.green, gui = 'bold' },
})

ins_right({
  'fileformat',
  symbols = {
    unix = '', -- e712
    dos = '', -- e70f
    mac = '', -- e711
  },
  upper = true,
  icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
  color = { fg = colors.green, gui = 'bold' },
})

ins_right({
  'branch',
  icon = '',
  condition = conditions.check_git_workspace,
  color = { fg = colors.violet, gui = 'bold' },
})

ins_right({
  'diff',
  -- Is it me or the symbol for modified us really weird
  symbols = { added = ' ', modified = '柳 ', removed = ' ' },
  color_added = colors.green,
  color_modified = colors.orange,
  color_removed = colors.red,
  condition = conditions.diff_source,
})

ins_right({
  function()
    return '▊'
  end,
  color = { fg = colors.bg },
  right_padding = 0,
})

-- Now don't forget to initialize lualine
lualine.setup(config)
