local ls = require('luasnip')
local s = ls.snippet
local t = ls.text_node

local regular = {}

local auto = {
    s("sci", {
        t "[skip ci]",
    }),
}

return regular, auto
