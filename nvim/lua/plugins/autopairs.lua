require('nvim-autopairs').setup({
    check_ts = true, -- enable treesitter
    ts_config = {
      lua = { "string", "source" }, -- don't add pairs in lua string treesitter nodes
      javascript = { "string", "template_string" }, -- don't add pairs in javscript template_string treesitter nodes
      java = false, -- don't check treesitter on java
    },
    fast_wrap = {
      map = "<M-e>",
      chars = { "{", "[", "(", '"', "'" },
      pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
      offset = 0, -- Offset from pattern match
      end_key = "$",
      keys = "qwertyuiopzxcvbnmasdfghjkl",
      check_comma = true,
      highlight = "PmenuSel",
      highlight_grey = "LineNr",
    },
    disable_filetype = { "TelescopePrompt", "vim", "spectre_panel" },
})

-- import nvim-autopairs completion functionality
local cmp_autopairs = require('nvim-autopairs.completion.cmp')

-- import nvim-cmp plugin (completions plugin)
local cmp_status_ok, cmp = pcall(require, "cmp")

if not cmp_status_ok then
  return
end

-- make autopairs and completion work together
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done({ map_char = { tex = '' } })
)
