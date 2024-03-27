return {
  "mfussenegger/nvim-lint",
  event = "VeryLazy",
  config = function()
    local lint = require "lint"
    lint.linters_by_ft = {
      javascript = { "eslint", "biomejs" },
      typescript = { "eslint", "biomejs" },
      javascriptreact = { "eslint", "biomejs" },
      typescriptreact = { "eslint", "biomejs" },
      astro = { "eslint", "biomejs" },
      json = { "jsonlint" },
      markdown = { "markdownlint" },
      lua = { "luacheck" },
      go = { "golangcilint" },
    }
  end,
}
