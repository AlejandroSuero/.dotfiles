return {
  "stevearc/conform.nvim",
  event = "VeryLazy",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      javascript = { { "eslintd", "eslint", "prettierd", "prettier" } },
      typescript = { { "eslintd", "eslint", "prettierd", "prettier" } },
      javascriptreact = { { "eslintd", "eslint", "prettierd", "prettier" } },
      typescriptreact = { { "eslintd", "eslint", "prettierd", "prettier" } },
      astro = { { "eslintd", "eslint", "prettierd", "prettier" } },
      go = { { "goimports-reviser", "golines", "gofumpt" } },
      c = { "clang_format" },
      yaml = { "yamlfix" },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
  },
  config = function(_, opts)
    require("conform").setup(opts)
  end,
}
