return {
  "nvimtools/none-ls.nvim", -- configure formatters & linters
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
    "gbprod/none-ls-luacheck.nvim",
  },
  config = function()
    -- import null-ls plugin
    local null_ls = require "null-ls"
    local null_ls_utils = require "null-ls.utils"

    -- for conciseness
    local formatting = null_ls.builtins.formatting -- to setup formatters
    local diagnostics = null_ls.builtins.diagnostics -- to setup linters
    local code_actions = null_ls.builtins.code_actions

    -- configure null_ls
    null_ls.setup {
      -- add package.json as identifier for root (for typescript monorepos)
      root_dir = null_ls_utils.root_pattern(
        ".null-ls-root",
        "Makefile",
        ".git",
        "package.json",
        "selene.toml",
        ".luacheck"
      ),
      -- setup formatters & linters
      sources = {
        -- formatting
        formatting.stylua,
        formatting.gofumpt,
        formatting.goimports_reviser,
        formatting.golines,
        formatting.clang_format,
        formatting.prettierd,
        formatting.markdownlint,
        -- code_actions
        code_actions.refactoring,
        require "none-ls.code_actions.eslint_d",
        -- diagnostics
        diagnostics.ansiblelint,
        diagnostics.golangci_lint,
        diagnostics.markdownlint,
        diagnostics.yamllint,
        diagnostics.selene.with {
          condition = function(utils)
            return utils.root_has_file { "selene.toml" }
          end,
        },
        require("none-ls-luacheck.diagnostics.luacheck").with {
          condition = function(utils)
            return utils.root_has_file { ".luacheck" }
          end,
        },
        require "none-ls.diagnostics.eslint_d",
      },
    }
  end,
}
