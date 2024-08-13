return {
  {
    "numToStr/Comment.nvim",
    dependencies = "JoosepAlviste/nvim-ts-context-commentstring",
    config = function()
      require('ts_context_commentstring').setup()

      require('Comment').setup {
        ---Add a space b/w comment and the line
        ---@type boolean
        padding = true,

        ---Lines to be ignored while comment/uncomment.
        ---Could be a regex string or a function that returns a regex string.
        ---Example: Use '^$' to ignore empty lines
        ---@type string|function
        ignore = nil,

        ---Create basic (operator-pending) and extended mappings for NORMAL + VISUAL mode
        ---@type table
        mappings = {
          ---operator-pending mapping
          ---Includes `gcc`, `gcb`, `gc[count]{motion}` and `gb[count]{motion}`
          basic = true,
          ---extra mapping
          ---Includes `gco`, `gcO`, `gcA`
          extra = true,
          ---extended mapping
          ---Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
          extended = false,
        },

        ---LHS of toggle mapping in NORMAL + VISUAL mode
        ---@type table
        toggler = {
          ---line-comment keymap
          line = 'gcc',
          ---block-comment keymap
          block = 'gbc',
        },

        ---LHS of operator-pending mapping in NORMAL + VISUAL mode
        ---@type table
        opleader = {
          ---line-comment keymap
          line = 'gc',
          ---block-comment keymap
          block = 'gb',
        },

        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),

        ---Post-hook, called after commenting is done
        ---@type function|nil
        post_hook = nil,
      }
    end,
  },
}

-- require('ts_context_commentstring').setup()

-- require('Comment').setup({
--   ---Add a space b/w comment and the line
--   padding = true,
--   ---Whether the cursor should stay at its position
--   sticky = true,
--  ---Lines to be ignored while (un)comment
--   ignore = nil,
--    ---LHS of toggle mappings in NORMAL mode
--    toggler = {
--     ---Line-comment toggle keymap
--     line = "gcc",
--     ---Block-comment toggle keymap
--     block = "gbc",
--   },
--   ---LHS of operator-pending mappings in NORMAL and VISUAL mode
--   opleader = {
--     ---Line-comment keymap
--     line = "gc",
--     ---Block-comment keymap
--     block = "gb",
--   },
--   ---LHS of extra mappings
--   extra = {
--     ---Add comment on the line above
--     above = "gcO",
--     ---Add comment on the line below
--     below = "gco",
--     ---Add comment at the end of line
--     eol = "gcA",
--   },
--   ---Enable keybindings
--   ---NOTE: If given `false` then the plugin won't create any mappings
--   mappings = {
--     ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
--     basic = true,
--     ---Extra mapping; `gco`, `gcO`, `gcA`
--     extra = true,
--   },
--   ---Function to call before (un)comment
--   pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),

--   -- post_hook = nil,
-- })
