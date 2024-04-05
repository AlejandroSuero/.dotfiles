return {
  "stevearc/conform.nvim",
  event = "VeryLazy",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      javascript = { "prettierd" },
      typescript = { "prettierd" },
      javascriptreact = { "prettierd" },
      typescriptreact = { "prettierd" },
      astro = { "prettierd" },
      go = { { "goimports-reviser", "golines", "gofumpt" } },
      c = { "clang_format" },
      markdown = { "prettierd" },
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
