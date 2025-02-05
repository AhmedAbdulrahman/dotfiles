return {
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        css = { { "prettied", "prettier" } },
        graphql = { { "prettied", "prettier" } },
        html = { { "prettied", "prettier" } },
        javascript = { { "prettied", "prettier" } },
        javascriptreact = { { "prettied", "prettier" } },
        json = { { "prettied", "prettier" } },
        lua = { "stylua" },
        markdown = { { "prettied", "prettier" } },
        python = { "isort", "black" },
        sql = { "sql-formatter" },
        svelte = { { "prettied", "prettier" } },
        typescript = { { "prettied", "prettier", "sql-formatter" } },
        typescriptreact = { { "prettied", "prettier" } },
        yaml = { "prettier" },
        xml = { "xmlformatter" }
      },
    })
  }
}
