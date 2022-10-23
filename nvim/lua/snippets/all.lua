local ls = require('luasnip')
local fmt = require('luasnip.extras.fmt').fmt

local i = ls.insert_node
local s = ls.snippet
local t = ls.text_node
local f = ls.function_node

local function replace_each(replacer)
  return function(args)
    local len = #args[1][1]
    return { replacer:rep(len) }
  end
end

ls.add_snippets('all', {
  s(
    { trig = 'lorem', dscr = 'Lorem ipsum' },
    t(
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
    )
  ),
  s(
    -- TODO: can probably make this one much smarter; right now it's basically just syntax reminder
    { trig = 'table', dscr = 'Table template' },
    fmt(
      [[
      | {}  | Second Header |
      | ------------- | ------------- |
      | Content Cell  | Content Cell  |
      | Content Cell  | Content Cell  |
    ]],
      {
        i(1, 'First Header'),
      }
    )
  ),
  s({ trig = 'bbox', wordTrig = true }, {
    t({ '╔' }),
    f(replace_each('═'), { 1 }),
    t({ '╗', '║' }),
    i(1, { 'content' }),
    t({ '║', '╚' }),
    f(replace_each('═'), { 1 }),
    t({ '╝' }),
    i(0),
  }),
  s({ trig = 'sbox', wordTrig = true }, {
    t({ '*' }),
    f(replace_each('-'), { 1 }),
    t({ '*', '|' }),
    i(1, { 'content' }),
    t({ '|', '*' }),
    f(replace_each('-'), { 1 }),
    t({ '*' }),
    i(0),
  }),
})
