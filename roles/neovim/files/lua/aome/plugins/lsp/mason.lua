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
  opts = require "aome.plugins.lsp.configs.mason",
  config = function(_, opts)
    local mason = require "mason"

    if package.config:sub(1, 1) ~= "\\" then
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, {
        "phpactor",
      })
    else
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, {
        "intelephense",
      })
    end

    mason.setup(opts)

    vim.api.nvim_create_user_command("MasonInstallAll", function()
      vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
    end, {})

    vim.g.mason_binaries_list = opts.ensure_installed
  end,
}
