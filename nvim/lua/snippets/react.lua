local present, ls = pcall(require, "luasnip")
if not present then
  return
end

local fmt = require('luasnip.extras.fmt').fmt
local snippet = ls.snippet
local insert_node = ls.insert_node
local function_node = ls.function_node
local dynamic_node = ls.dynamic_node
local snippet_node = ls.snippet_node
local text_node = ls.text_node
local rep = require('luasnip.extras').rep

-- Get a list of  the property names given an `interface_declaration`
-- treesitter *tsx* node.
-- Ie, if the treesitter node represents:
--   interface {
--     prop1: string;
--     prop2: number;
--   }
-- Then this function would return `{"prop1", "prop2"}
---@param id_node {} Stands for "interface declaration node"
---@return string[]
local function get_prop_names(id_node)
  local object_type_node = id_node:child(2)
  if object_type_node:type() ~= 'object_type' then
    return {}
  end

  local prop_names = {}

  for prop_signature in object_type_node:iter_children() do
    if prop_signature:type() == 'property_signature' then
      local prop_iden = prop_signature:child(0)
      local prop_name = vim.treesitter.query.get_node_text(prop_iden, 0)
      prop_names[#prop_names + 1] = prop_name
    end
  end

  return prop_names
end

local function replace_each(replacer)
  return function(args)
    local len = #args[1][1]
    return { replacer:rep(len) }
  end
end

local react = {
  snippet(
    'comp',
    fmt(
      [[
	import * as React from 'react'
	import {{ styled }} from '@mui/system'

	const BREAKPOINT_KEY = 'md'

	const Root = styled('section')(({{ theme }}) => ({{}}))

	{}interface {}Props {{
	  {}
	}}

	function {}({{{}}}: {}Props) {{
	  return (
		<Root>
		  {}
		</Root>
	  );
	}};

	export default {}
	]]    ,
      {
      insert_node(1, 'export '),

      -- Initialize component name to file name
      dynamic_node(2, function(_, snip)
        local dirname = vim.fn.expand('%'):match('([^/]+)/[^/]+$')
        local filename = vim.fn.expand('%:t')
        if filename == 'index.tsx' then
          return snippet_node(nil, {
            insert_node(1, dirname),
          })
        end

        return snippet_node(nil, {
          insert_node(
            1,
            vim.fn.substitute(snip.env.TM_FILENAME, '\\..*$', '', 'g')
          ),
        })
      end, { 1 }),
      insert_node(3, '// Props'),
      dynamic_node(4, function(_, snip)
        local dirname = vim.fn.expand('%'):match('([^/]+)/[^/]+$')
        local filename = vim.fn.expand('%:t')
        if filename == 'index.tsx' then
          return snippet_node(nil, {
            insert_node(1, dirname),
          })
        end

        return snippet_node(nil, {
          insert_node(
            1,
            vim.fn.substitute(snip.env.TM_FILENAME, '\\..*$', '', 'g')
          ),
        })
      end, { 1 }),
      function_node(function(_, snip, _)
        local pos_begin = snip.nodes[10].mark:pos_begin()
        local pos_end = snip.nodes[10].mark:pos_end()
        local parser = vim.treesitter.get_parser(0, 'tsx')
        local tstree = parser:parse()

        local node = tstree[1]:root():named_descendant_for_range(
          pos_begin[1],
          pos_begin[2],
          pos_end[1],
          pos_end[2]
        )

        while node ~= nil and node:type() ~= 'interface_declaration' do
          node = node:parent()
        end

        if node == nil then
          return ''
        end

        -- `node` is now surely of type "interface_declaration"
        local prop_names = get_prop_names(node)

        -- Does this lua->vimscript->lua thing cause a slow down? Dunno.
        return vim.fn.join(prop_names, ', ')
      end, { 3 }),
      rep(2),
      insert_node(5, 'null'),
      rep(4),
    }
    )
  )
}

local js_ts = {
  snippet(
    { trig = 'import', dscr = 'import statement' },
    fmt("import {} from '{}{}'", {
      insert_node(1, 'name'),
      insert_node(2),
      dynamic_node(3, function(_, snip, _)
        local text = snip.nodes[1][1]
        local _, _, typish, target = text:find('^%s*(%a*)%s*{?%s*(%a+).*}?%s*$')
        if typish == 'type' and target then
          return snippet(1, { insert_node(1, target) })
        elseif typish and target then
          return snippet(1, { insert_node(1, typish .. target) })
        else
          return snippet(1, { insert_node(1, 'specifier') })
        end
      end, { 1 }),
    })
  ),

  snippet(
    { trig = 'require', dscr = 'require statement' },
    fmt("const {} = require('{}{}');", {
      insert_node(1, 'name'),
      insert_node(2),
      dynamic_node(3, function(_, snip, _)
        local text = snip.nodes[1][1]
        return snippet(1, { insert_node(1, text) })
      end, { 1 }),
    })
  ),

  snippet(
    { trig = '**', dscr = 'docblock' },
    text_node({ '/**', '' }),
    function_node(function(_, snip, _)
      local lines = vim.tbl_map(function(line)
        return ' * ' .. vim.trim(line)
      end, snip.env.SELECT_RAW)
      if #lines == 0 then
        return ' * '
      else
        return lines
      end
    end, {}),
    insert_node(1),
    text_node({ '', ' */' })
  ),
}

ls.add_snippets(nil, {
  all = {
    snippet({ trig = 'bbox', wordTrig = true }, {
      text_node({ '╔' }),
      function_node(replace_each('═'), { 1 }),
      text_node({ '╗', '║' }),
      insert_node(1, { 'content' }),
      text_node({ '║', '╚' }),
      function_node(replace_each('═'), { 1 }),
      text_node({ '╝' }),
      insert_node(0),
    }),
    snippet({ trig = 'sbox', wordTrig = true }, {
      text_node({ '*' }),
      function_node(replace_each('-'), { 1 }),
      text_node({ '*', '|' }),
      insert_node(1, { 'content' }),
      text_node({ '|', '*' }),
      function_node(replace_each('-'), { 1 }),
      text_node({ '*' }),
      insert_node(0),
    }),
  },
  javascript = js_ts,
  typescript = js_ts,
  javascriptreact = vim.tbl_extend('force', {}, js_ts, react),
  typescriptreact = vim.tbl_extend('force', {}, js_ts, react),
})
