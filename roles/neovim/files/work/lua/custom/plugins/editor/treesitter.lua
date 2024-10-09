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
        "php",
        "go",
        "rust",
        "c",
        "astro",
        "jsdoc",
        "http",
        "xml",
        "templ",
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
      commentary_integration = {
        Commentary = "gc",
        CommentaryLine = "gcc",
        ChangeCommentary = "cgc",
        CommentaryUndo = "gcu",
      },
      enable_autocmd = false,
      languages = {
        typescript = "// %s",
      },
      config = {},
    }
    local treesitter_parser_config =
      require("nvim-treesitter.parsers").get_parser_configs()

    ---@diagnostic disable-next-line: inject-field
    treesitter_parser_config.templ = {
      install_info = {
        url = "https://github.com/vrischmann/tree-sitter-templ.git",
        files = { "src/parser.c", "src/scanner.c" },
        branch = "master",
      },
    }

    vim.treesitter.language.register("templ", "templ")
  end,
}
