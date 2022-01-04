
local lspkind = require('lspkind')
local tabnine = require('cmp_tabnine.config')

local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
  return
end

require("luasnip/loaders/from_vscode").lazy_load()

-- Utils
local check_backspace = function()
	local col = vim.fn.col "." - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

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
    ['<C-k>'] = cmp.mapping.select_prev_item(),
    ['<C-j>'] = cmp.mapping.select_next_item(),
	['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-2), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(2), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping {
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    },
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(function(fallback)
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
		"i",
		"s",
	  }),
	  ["<S-Tab>"] = cmp.mapping(function(fallback)
		if cmp.visible() then
		  cmp.select_prev_item()
		elseif luasnip.jumpable(-1) then
		  luasnip.jump(-1)
		else
		  fallback()
		end
	  end, {
		"i",
		"s",
	  }),
  },

  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = lspkind.symbolic(vim_item.kind, { with_text = true })
      local menu = source_mapping[entry.source.name]
      local maxwidth = 100

      if entry.source.name == 'cmp_tabnine' then
        if
          entry.completion_item.data ~= nil
          and entry.completion_item.data.detail ~= nil
        then
          menu = menu .. '[' .. entry.completion_item.data.detail .. ']'
        end
      end

      vim_item.menu = menu
      vim_item.abbr = string.sub(vim_item.abbr, 1, maxwidth)

      return vim_item
    end,
  },

  -- You should specify your *installed* sources.
  sources = {
	{ name = 'luasnip' },
    { name = 'nvim_lsp' },
    { name = 'npm' },
    { name = 'cmp_tabnine', max_item_count = 3 },
    { name = 'buffer', keyword_length = 5 },
    { name = 'path' },
    { name = 'calc' },
    { name = 'nvim_lua' },
  },

  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },

  documentation = {
    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
  },

  experimental = {
    native_menu = false,
    ghost_text = true,
  },
})

tabnine:setup({
	max_lines                = 1000;
	max_num_results          = 3;
	sort                     = true;
	show_prediction_strength = true;
})
