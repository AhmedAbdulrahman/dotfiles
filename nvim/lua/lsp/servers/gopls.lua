local M = {}

M.filetypes = {
   "go",
   "gomod",
   "gowork",
   "gotmpl"
}

M.settings = {
  gopls = {
    -- automaticly import packages
    completeUnimported = true,
    -- adds placeholders for functions parameters
    usePlaceholders = true,
    analyses = {
      -- give warning for parameters not used
      unusedparams = true,
    }
  }
}

return M
