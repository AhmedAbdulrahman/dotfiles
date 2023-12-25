local present, neotest = pcall(require, "neotest")
if not present then
  return
end

-- ╭──────────────────────────────────────────────────────────╮
-- │ Setup                                                    │
-- ╰──────────────────────────────────────────────────────────╯
neotest.setup({
  adapters = {
    require("neotest-jest")({
      cwd = require("neotest-jest").root,
    }),
  },
  discovery = {
    enabled = true,
  },
  diagnostic = {
    enabled = true
  },
  floating = {
    border = NvimConfig.ui.float.border or "rounded",
    max_height = 0.6,
    max_width = 0.6
  },
  highlights = {
    adapter_name = "NeotestAdapterName",
    border = "NeotestBorder",
    dir = "NeotestDir",
    expand_marker = "NeotestExpandMarker",
    failed = "NeotestFailed",
    file = "NeotestFile",
    focused = "NeotestFocused",
    indent = "NeotestIndent",
    namespace = "NeotestNamespace",
    passed = "NeotestPassed",
    running = "NeotestRunning",
    skipped = "NeotestSkipped",
    test = "NeotestTest"
  },
  icons = {
    running = "󰥔 ",
    unknown = "?",
    running_animated = vim.tbl_map(function(s)
      return s .. " "
    end, { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }),
  },
  floating = {
    border = NvimConfig.ui.float.border,
  },
  output = {
    enabled = true,
    open_on_run = false,
  },
  run = {
    enabled = true
  },
  status = {
    virtual_text = true,
    signs = false,
  },
  strategies = {
    integrated = {
      width = 180
    }
  },
  summary = {
    enabled = true,
    expand_errors = true,
    follow = true,
    mappings = {
      attach = "a",
      expand = { "<CR>", "<2-LeftMouse>" },
      expand_all = "e",
      jumpto = "i",
      output = "o",
      run = "r",
      short = "O",
      stop = "u"
    }
  }
})
