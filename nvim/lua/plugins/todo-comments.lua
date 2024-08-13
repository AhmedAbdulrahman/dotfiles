return {
  {
    "folke/todo-comments.nvim",
    event = "BufEnter",
    opts = {
      signs = true,      -- show icons in the signs column
      sign_priority = 8, -- sign priority
      -- keywords recognized as todo comments
      keywords = {
        FIX = {
          alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
        },
        WARN = { alt = { "WARNING" } },
        PERF = { alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
      },
      highlight = {
        before = "",                     -- "fg" or "bg" or empty
        keyword = "wide",                -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
        after = "fg",                    -- "fg" or "bg" or empty
        pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlightng (vim regex)
        comments_only = true,            -- uses treesitter to match keywords in comments only
        max_line_len = 400,              -- ignore lines longer than this
        exclude = {},                    -- list of file types to exclude highlighting
      },
    },
    keys = {
      { "n", "]t", function() require("todo-comments").jump_next() end, { desc = "Next todo comment" } },
      { "n", "[t", function() require("todo-comments").jump_prev() end, { desc = "Previous todo comment" } }
    }
  }
}
