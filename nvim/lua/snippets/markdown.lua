local ls = require('luasnip')
local fmt = require('luasnip.extras.fmt').fmt
local s = ls.snippet
local insert_node = ls.insert_node

ls.add_snippets('markdown', {
  s(
    { trig = 'frontmatter', dscr = 'Document frontmatter' },
    fmt(
      [[
      ---
      tags: {}
      ---
    ]],
      {
        insert_node(1, 'value'),
      }
    )
  ),
})
