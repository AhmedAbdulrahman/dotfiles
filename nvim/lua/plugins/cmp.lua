-- Requires
local lspkind = require('lspkind')
local tabnine = require('cmp_tabnine.config')

local cmp_status_ok, cmp = pcall(require, 'cmp')
if not cmp_status_ok then
  return
end

local snip_status_ok, luasnip = pcall(require, 'luasnip')
if not snip_status_ok then
  return
end

require('luasnip/loaders/from_vscode').lazy_load()

-- Utils
local check_backspace = function()
  local col = vim.fn.col('.') - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s')
end

-- Setup
local source_mapping = {
  buffer = NvimConfig.icons.buffer .. '[BUF]',
  calc = NvimConfig.icons.calculator,
  cmp_tabnine = NvimConfig.icons.light,
  luasnip = NvimConfig.icons.snippet,
  npm = NvimConfig.icons.terminal .. '[NPM]',
  nvim_lsp = NvimConfig.icons.paragraph .. '[LSP]',
  nvim_lua = NvimConfig.icons.bomb,
  path = NvimConfig.icons.folderOpen2,
  treesitter = NvimConfig.icons.tree,
  zsh = NvimConfig.icons.terminal .. '[ZSH]',
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
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<CR>'] = cmp.mapping.confirm({
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
      vim_item.kind = lspkind.symbolic(vim_item.kind, { with_text = true })

      -- set a name for each source
      local menu = source_mapping[entry.source.name]
      local maxwidth = 60

      if entry.source.name == 'cmp_tabnine' then
        if
          entry.completion_item.data ~= nil
          and entry.completion_item.data.detail ~= nil
        then
          menu = menu .. '[' .. entry.completion_item.data.detail .. ']'
        end
      end

      vim_item.menu = menu
      if #vim_item.abbr > maxwidth then
        vim_item.abbr = vim_item.abbr:sub(1, maxwidth) .. '...'
      end

      return vim_item
    end,
  },

  -- You should specify your *installed* sources.
  sources = {
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'npm' },
    { name = 'cmp_tabnine', max_item_count = 3 },
    {
      name = 'buffer',
      option = {
        get_bufnrs = function()
          return vim.api.nvim_list_bufs()
        end,
      },
    },
    { name = 'path' },
    { name = 'luasnip' },
    { name = 'calc' },
    { name = 'nvim_lua' },
  },

  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },

  documentation = {
    border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
  },

  experimental = {
    native_menu = false,
    ghost_text = true,
  },
})

tabnine:setup({
  max_lines = 1000,
  max_num_results = 3,
  sort = true,
  show_prediction_strength = true,
  run_on_every_keystroke = true,
  snipper_placeholder = '..',
  ignored_file_types = {},
})
