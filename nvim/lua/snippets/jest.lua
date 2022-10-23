local ls = require('luasnip')
local fmt = require('luasnip.extras.fmt').fmt
local s = ls.snippet
local insert_node = ls.insert_node

ls.add_snippets('jest', {
  s(
    { trig = 'describe', dscr = 'describe()' },
    fmt(
      [[
      describe('{}', () => {{
        {}{}
      }});
    ]],
      {
        insert_node(1, 'description'),
        insert_node(2, '// Body.'),
        insert_node(0),
      }
    )
  ),
  s(
    { trig = 'it', dscr = 'it()' },
    fmt(
      [[
      it('{}', () => {{
        {}{}
      }});
    ]],
      {
        insert_node(1, 'description'),
        insert_node(2, '// Body.'),
        insert_node(0),
      }
    )
  ),
})
