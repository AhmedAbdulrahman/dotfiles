local colors = require('utils.colors')
local set_highlight = require('utils.set-highlight')

local purple = colors.purple
local red = colors.red
local white = colors.white
local yellow = colors.yellow
local orange = colors.orange
local blue = colors.blue
local green = colors.green
local greyLight = colors.grey_light

if NvimConfig.colorscheme == 'aylin' then
  set_highlight({
    list = {
      { group = 'MatchParen', foreground = red, background = blue },
      -- Treesitter
      { group = '@number', foreground = red },
      { group = '@type.builtin', foreground = red },
      { group = '@type', foreground = white },
      { group = '@keyword', foreground = red },
      { group = '@parameter', foreground = orange },
      { group = '@property', foreground = white },
      { group = '@punctuation.bracket', foreground = purple },
      { group = '@punctuation.delimiter', foreground = purple },
      { group = '@tag', foreground = red },
      { group = '@tag.tsx', foreground = red },
      { group = '@constructor.tsx', foreground = red },
      { group = '@tag.delimiter.tsx', foreground = purple },
      { group = '@tag.delimiter', foreground = white },
      { group = '@tag.attribute', foreground = green },
      { group = '@attribute', foreground = yellow },
      { group = '@namespace', foreground = yellow },

      -- Telescope
      { group = 'TelescopeTitle', foreground = yellow },
      { group = 'TelescopeNormal', foreground = 'None' },
      { group = 'TelescopeBorder', foreground = blue },
      { group = 'TelescopeMatching', foreground = blue },

      -- Completion Menu Colors
      { group = 'CmpItemAbbr', foreground = white },
      { group = 'CmpItemKindClass', foreground = orange },
      { group = 'CmpItemKindConstructor', foreground = purple },
      { group = 'CmpItemKindFolder', foreground = '#0db9d7' },
      { group = 'CmpItemKindFunction', foreground = '#7fdbca' },
      { group = 'CmpItemKindSnippet', foreground = '#a9b1d6' },
      { group = 'CmpItemKindVariable', foreground = yellow },
      { group = 'CmpItemKindText', foreground = greyLight },
      { group = 'CmpItemMenu', foreground = red },
      { group = 'CmpItemAbbrMatch', foreground = blue },
      { group = 'CmpItemAbbrMatchFuzzy', foreground = blue },

      -- HTML
      { group = 'htmlTagName', foreground = yellow },
      { group = 'htmlArg', foreground = red },
    },
  })
end
