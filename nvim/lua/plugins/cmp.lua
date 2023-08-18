-- Requires
local lspkind = require('lspkind')
local types = require('cmp.types')

local _, tabnine = pcall(require, 'cmp_tabnine.config')

local cmp_status_ok, cmp = pcall(require, 'cmp')
if not cmp_status_ok then
  return
end

local snip_status_ok, luasnip = pcall(require, 'luasnip')
if not snip_status_ok then
  return
end

local has_copilot, copilot_cmp = pcall(require, 'copilot_cmp.comparators')

require('luasnip/loaders/from_vscode').lazy_load()

local check_backspace = function()
  local col = vim.fn.col('.') - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s')
end

local deprioritize_snippet = function(entry1, entry2)
  if entry1:get_kind() == types.lsp.CompletionItemKind.Snippet then
    return false
  end
  if entry2:get_kind() == types.lsp.CompletionItemKind.Snippet then
    return true
  end
end

local function limit_lsp_types(entry, ctx)
  local kind = entry:get_kind()
  local line = ctx.cursor.line
  local col = ctx.cursor.col
  local char_before_cursor = string.sub(line, col - 1, col - 1)
  local char_after_dot = string.sub(line, col, col)

  if char_before_cursor == '.' and char_after_dot:match('[a-zA-Z]') then
    if
      kind == types.lsp.CompletionItemKind.Method
      or kind == types.lsp.CompletionItemKind.Field
      or kind == types.lsp.CompletionItemKind.Property
    then
      return true
    else
      return false
    end
  elseif string.match(line, '^%s+%w+$') then
    if
      kind == types.lsp.CompletionItemKind.Function
      or kind == types.lsp.CompletionItemKind.Variable
    then
      return true
    else
      return false
    end
  end

  return true
end

local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt' then
    return false
  end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0
    and vim.api
        .nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]
        :match('^%s*$')
      == nil
end

--- Get completion context, i.e., auto-import/target module location.
--- Depending on the LSP this information is stored in different parts of the
--- lsp.CompletionItem payload. The process to find them is very manual: log the payloads
--- And see where useful information is stored.
---@param completion lsp.CompletionItem
---@param source cmp.Source
---@see Astronvim, because i just discovered they're already doing this thing, too
--  https://github.com/AstroNvim/AstroNvim
local function get_lsp_completion_context(completion, source)
  local ok, source_name = pcall(function()
    return source.source.client.config.name
  end)
  if not ok then
    return nil
  end
  if source_name == 'tsserver' or source_name == 'typescript-tools' then
    return completion.detail
  elseif source_name == 'pyright' then
    if completion.labelDetails ~= nil then
      return completion.labelDetails.description
    end
  end
end

lspkind.init({
  symbol_map = {
    Text = '',
    Method = 'ƒ',
    Function = 'ﬦ',
    Constructor = '',
    Variable = '',
    Class = '',
    Interface = 'ﰮ',
    Module = '',
    Property = '',
    Unit = '',
    Value = '',
    Enum = '了',
    Keyword = '',
    Snippet = '﬌',
    Color = '',
    File = '',
    Folder = '',
    EnumMember = '',
    Constant = '',
    Struct = '',
    Copilot = '[]',
  },
})
-- Setup
local source_mapping = {
  npm = NvimConfig.icons.terminal .. '[NPM]',
  cmp_tabnine = NvimConfig.icons.light,
  Copilot = NvimConfig.icons.copilot .. '[COP]',
  Codeium = NvimConfig.icons.codeium,
  nvim_lsp = NvimConfig.icons.stack .. '[LSP]',
  buffer = NvimConfig.icons.buffer .. '[BUF]',
  nvim_lua = NvimConfig.icons.bomb,
  luasnip = NvimConfig.icons.snippet .. '[SNP]',
  calc = NvimConfig.icons.calculator,
  path = NvimConfig.icons.folderOpen2,
  treesitter = NvimConfig.icons.tree,
  zsh = NvimConfig.icons.terminal .. '[ZSH]',
}

local buffer_option = {
  -- Complete from all visible buffers (splits)
  get_bufnrs = function()
    local bufs = {}
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      bufs[vim.api.nvim_win_get_buf(win)] = true
    end
    return vim.tbl_keys(bufs)
  end,
}

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  -- You must set mapping if you want.
  mapping = {
    ['<C-j>'] = cmp.mapping.select_next_item({
      behavior = cmp.SelectBehavior.Insert,
    }),
    ['<C-k>'] = cmp.mapping.select_prev_item({
      behavior = cmp.SelectBehavior.Insert,
    }),
    ['<Down>'] = cmp.mapping.select_next_item({
      behavior = cmp.SelectBehavior.Select,
    }),
    ['<Up>'] = cmp.mapping.select_prev_item({
      behavior = cmp.SelectBehavior.Select,
    }),
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-2), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(2), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(
      cmp.mapping.complete({
        config = {
          sources = {
            { name = 'copilot' },
          },
        },
      }),
      { 'i', 'c' }
    ),
    ['<CR>'] = cmp.mapping.confirm({
      -- this is the important line for Copilot
      behavior = cmp.ConfirmBehavior.Replace,
      select = NvimConfig.plugins.completion.select_first_on_enter,
    }),
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif cmp.visible() and has_words_before() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
      elseif luasnip.expandable() then
        luasnip.expand()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif check_backspace() then
        fallback()
      else
        fallback()
      end
    end, {
      'i',
      's',
    }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {
      'i',
      's',
    }),
  },

  formatting = {
    format = function(entry, vim_item)
      -- Set the highlight group for the Codeium source
      if entry.source.name == 'codeium' then
        vim_item.kind_hl_group = 'CmpItemKindCopilot'
      end

      -- Get the item with kind from the lspkind plugin
      local item_with_kind = require('lspkind').cmp_format({
        mode = 'symbol_text',
        maxwidth = 50,
        symbol_map = source_mapping,
      })(entry, vim_item)

      item_with_kind.kind =
        lspkind.symbolic(item_with_kind.kind, { with_text = true })
      item_with_kind.menu = source_mapping[entry.source.name]
      item_with_kind.menu = vim.trim(item_with_kind.menu or '')
      item_with_kind.abbr =
        string.sub(item_with_kind.abbr, 1, item_with_kind.maxwidth)

      if entry.source.name == 'cmp_tabnine' then
        if
          entry.completion_item.data ~= nil
          and entry.completion_item.data.detail ~= nil
        then
          item_with_kind.kind = ' '
            .. lspkind.symbolic('Event', { with_text = false })
            .. ' TabNine'
          item_with_kind.menu = item_with_kind.menu
            .. entry.completion_item.data.detail
        else
          item_with_kind.kind = ' '
            .. lspkind.symbolic('Event', { with_text = false })
            .. ' TabNine'
          item_with_kind.menu = item_with_kind.menu .. ' TBN'
        end
      end

      local completion_context =
        get_lsp_completion_context(entry.completion_item, entry.source)
      if completion_context ~= nil and completion_context ~= '' then
        item_with_kind.menu = item_with_kind.menu
          .. [[ -> ]]
          .. completion_context
      end

      if string.find(vim_item.kind, 'Color') then
        -- Override for plugin purposes
        vim_item.kind = 'Color'
        local tailwind_item =
          require('cmp-tailwind-colors').format(entry, vim_item)
        item_with_kind.menu = lspkind.symbolic('Color', { with_text = false })
          .. ' Color'
        item_with_kind.kind = ' ' .. tailwind_item.kind
      end

      return item_with_kind
    end,
  },

  -- You should specify your *installed* sources.
  sources = {
    {
      name = 'nvim_lsp',
      priority = 10,
      -- Limits LSP results to specific types based on line context (FIelds, Methods, Variables)
      entry_filter = limit_lsp_types,
    },
    { name = 'nvim_lsp_signature_help', priority = 9 },
    { name = 'npm', priority = 9 },
    { name = 'codeium', priority = 9 },
    { name = 'copilot', priority = 9 },
    { name = 'cmp_tabnine', priority = 7 },
    { name = 'luasnip', priority = 7 },
    {
      name = 'buffer',
      priority = 7,
      keyword_length = 5,
      option = buffer_option,
    },
    { name = 'nvim_lua', priority = 5 },
    { name = 'path', priority = 4 },
    { name = 'calc', priority = 3 },
  },

  sorting = {
    --keep priority weight at 2 for much closer matches to appear above copilot
    --set to 1 to make copilot always appear on top
    comparators = {
      deprioritize_snippet,
      cmp.config.compare.exact,
      has_copilot and copilot_cmp.prioritize or nil,
      has_copilot and copilot_cmp.score or nil,
      cmp.config.compare.offset,
      cmp.config.compare.score,
      cmp.config.compare.recently_used,
      cmp.config.compare.locality,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },

  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },

  window = {
    completion = cmp.config.window.bordered({
      winhighlight = 'Normal:CmpMenu,FloatBorder:CmpMenuBorder,CursorLine:CmpSelection,Search:None',
      border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
      scrollbar = '║',
    }),
    documentation = cmp.config.window.bordered({
      winhighlight = 'NormalFloat:NormalFloat,FloatBorder:FloatBorder',
      border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
      scrollbar = '║',
    }),
  },

  experimental = {
    native_menu = false,
    ghost_text = true,
  },

  preselect = cmp.PreselectMode.Item,
})

-- ╭──────────────────────────────────────────────────────────╮
-- │ Cmdline                                                  │
-- ╰──────────────────────────────────────────────────────────╯

-- `/` cmdline setup.
-- cmp.setup.cmdline('/', {
--   mapping = cmp.mapping.preset.cmdline(),
--   sources = {
--     { name = 'buffer' },
--   },
-- })
-- -- `:` cmdline setup.
-- cmp.setup.cmdline(':', {
--   mapping = cmp.mapping.preset.cmdline(),
--   sources = cmp.config.sources({
--     { name = 'path' },
--   }, {
--     { name = 'cmdline' },
--   }),
-- })

-- ╭──────────────────────────────────────────────────────────╮
-- │ tabnine                                                  │
-- ╰──────────────────────────────────────────────────────────╯

if NvimConfig.plugins.ai.tabnine.enabled then
  tabnine:setup({
    max_lines = 1000,
    max_num_results = 3,
    sort = true,
    show_prediction_strength = true,
    run_on_every_keystroke = true,
    snipper_placeholder = '..',
    ignored_file_types = {},
  })
end
