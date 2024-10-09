---@diagnostic disable: unused-local
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
      modules = {},
      sync_install = false,
      ignore_install = {},
      highlight = {
        enable = true,
      },
      indent = { enable = true },
      autotag = {
        enable = true,
        enable_rename = true,
        enable_close = false,
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
        "astro",
        "jsdoc",
        "http",
        "xml",
      },
      auto_install = true,
    }
  end,
}
