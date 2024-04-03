return {
  "mfussenegger/nvim-lint",
  event = "VeryLazy",
  config = function()
    local lint = require "lint"
    lint.linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      astro = { "eslint_d" },
      json = { "jsonlint" },
      markdown = { "markdownlint" },
      lua = { "luacheck" },
      go = { "golangcilint" },
      yaml = { "ansible_lint", "yamllint" },
    }

    local lint_augroup =
      vim.api.nvim_create_augroup("aome-lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
