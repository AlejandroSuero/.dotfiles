return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "windwp/nvim-ts-autotag",
    "nvim-treesitter/playground",
    "nvim-treesitter/nvim-treesitter-context",
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  build = ":TSUpdate",
  config = function()
    local treesitter = require "nvim-treesitter.configs"

    treesitter.setup {
      highlight = {
        enable = true,
      },
      indent = { enable = true },
      autotag = {
        enable = true,
        enable_rename = true,
        enable_close = true,
        enable_close_on_slash = true,
      },
      ensure_installed = {
        "json",
        "javascript",
        "typescript",
        "tsx",
        "yaml",
        "html",
        "css",
        "prisma",
        "markdown",
        "markdown_inline",
        "svelte",
        "graphql",
        "bash",
        "lua",
        "vim",
        "vimdoc",
        "dockerfile",
        "gitignore",
        "php",
        "go",
        "rust",
        "c",
        "astro",
        "jsdoc",
      },
      auto_install = true,
    }

    local ok, ts_context_commentstring =
      pcall(require, "ts_context_commentstring")
    if not ok then
      vim.notify("Tresitter context comment string not loaded", 3)
      return
    end
    ts_context_commentstring.setup {
      enable_autocmd = false,
      languages = {
        typescript = "// %s",
      },
    }
  end,
}
