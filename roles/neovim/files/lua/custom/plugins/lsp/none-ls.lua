return {
  "nvimtools/none-ls.nvim", -- configure formatters & linters
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "nvimtools/none-ls-extras.nvim", dev = true },
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
      debug = true,
      root_dir = null_ls_utils.root_pattern(
        ".null-ls-root",
        "Makefile",
        ".git",
        "package.json",
        "selene.toml",
        ".luacheck",
        "ansible.cfg"
      ),
      -- setup formatters & linters
      sources = {
        -- formatting
        formatting.stylua,
        formatting.gofumpt,
        formatting.goimports_reviser,
        formatting.golines,
        formatting.clang_format,
        formatting.biome.with {
          condition = function(utils)
            return utils.root_has_file { "biome.json", "biome.jsonc" }
          end,
        },
        formatting.prettier.with {
          condition = function(utils)
            return utils.root_has_file { "package-lock.json" }
              and not utils.root_has_file { "biome.json", "biome.jsonc" }
          end,
        },
        formatting.prettierd.with {
          condition = function(utils)
            return utils.root_has_file { "pnpm-lock.yaml" }
              and not utils.root_has_file { "biome.json", "biome.jsonc" }
          end,
        },
        diagnostics.markdownlint.with {
          condition = function(utils)
            return utils.root_has_file { ".markdownlint.json" }
          end,
        },
        -- code_actions
        code_actions.refactoring,
        -- require "none-ls.diagnostics.stylua",
        require("none-ls.code_actions.eslint_d").with {
          condition = function(utils)
            return utils.root_has_file { "pnpm-lock.yaml" }
              and not utils.root_has_file { "biome.json", "biome.jsonc" }
          end,
        },
        -- diagnostics
        diagnostics.codespell.with {
          filetypes = { "markdown", "text" },
        },
        diagnostics.ansiblelint.with {
          condition = function(utils)
            return utils.root_has_file { "ansible.cfg" }
          end,
        },
        diagnostics.golangci_lint.with {
          condition = function(utils)
            return utils.root_has_file { ".golangci.yml", ".golangci.yaml" }
          end,
        },
        diagnostics.markdownlint.with {
          condition = function(utils)
            return utils.root_has_file { ".markdownlint.json" }
          end,
        },
        diagnostics.yamllint.with {
          condition = function(utils)
            return utils.root_has_file { ".yamllint.yml", ".yamllint.yaml" }
          end,
        },
        diagnostics.selene.with {
          condition = function(utils)
            return utils.root_has_file { "selene.toml", ".selene.toml" }
          end,
        },
        -- diagnostics.stylua.with {
        --   condition = function(utils)
        --     return utils.root_has_file { "stylua.toml", ".stylua.toml" }
        --   end,
        -- },
        require("none-ls-luacheck.diagnostics.luacheck").with {
          condition = function(utils)
            return utils.root_has_file { ".luacheckrc" }
          end,
        },
        require("none-ls.diagnostics.eslint").with {
          condition = function(utils)
            return utils.root_has_file { "package-lock.json" }
          end,
        },
        require("none-ls.diagnostics.eslint_d").with {
          condition = function(utils)
            return utils.root_has_file { "pnpm-lock.yaml" }
          end,
        },
      },
    }
  end,
}
