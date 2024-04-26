return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "jayp0521/mason-null-ls.nvim",
  },
  cmd = {
    "Mason",
    "MasonInstall",
    "MasonInstallAll",
    "MasonUpdate",
    "MasonUninstall",
  },
  opts = require "aome.lsp.mason",
  config = function(_, opts)
    local mason = require "mason"

    mason.setup(opts)
    require("mason-null-ls").setup({
      ensure_installed = {
        "shellcheck",
        "luacheck",
        "eslint_d",
        "prettierd",
        "stylua",
        "markdownlint",
        "yamllint",
        "golines",
        "gofumpt",
        "goimports_reviser",
        "ansiblelint",
        "golangci_lint"
      }
    })

    vim.api.nvim_create_user_command("MasonInstallAll", function()
      vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
    end, {})

    vim.g.mason_binaries_list = opts.ensure_installed
  end,
}
