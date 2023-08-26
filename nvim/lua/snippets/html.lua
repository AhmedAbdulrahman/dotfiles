local ls = require('luasnip')
local fmt = require('luasnip.extras.fmt').fmt
local s = ls.snippet
local i = ls.insert_node

local html5 = s(
  'html5',
  fmt(
    [[
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width={}, initial-scale={}">
    <title>{}</title>
</head>
<body>
    {}
</body>
</html>
]],
    {
      i(1, 'device-width'),
      i(2, '1.0'),
      i(3, 'Document'),
      i(4),
    }
  )
)

local script =
  s('script:import', fmt("<script src='{}'></script>", { i(1, 'index.js') }))

local snippets = {
  html5,
  script,
}

return snippets
