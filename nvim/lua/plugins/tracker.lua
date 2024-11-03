print(vim.fn.stdpath("config"))
return {
  {
    "3rd/time-tracker.nvim",
    -- dir = lib.path.resolve(lib.env.dirs.vim.config, "plugins", "time-tracker.nvim"),
    event = "VeryLazy",
    opts = {
      data_file = vim.fn.stdpath("config") .. "/time-tracker.json",
    },
  },
}
