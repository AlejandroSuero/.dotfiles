return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    -- Automatically install LSPs and related tools to stdpath for neovim
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      config = function()
        require("mason-tool-installer").setup {
          auto_update = true,
          debounce_hours = 24,
          ensure_installed = {
            "black",
            "isort",
          },
        }
      end,
    },
    { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
    {
      "folke/lazydev.nvim",
      opts = {
        library = {
          "luvit-meta/library",
        },
      },
    },

    -- Useful status updates for LSP.
    -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
    {
      "j-hui/fidget.nvim",
      opts = {},
    },
    "simrat39/inlay-hints.nvim",
    "jose-elias-alvarez/nvim-lsp-ts-utils",
    "b0o/schemastore.nvim",
  },
  config = function()
    require "aome.lsp"
  end,
}
