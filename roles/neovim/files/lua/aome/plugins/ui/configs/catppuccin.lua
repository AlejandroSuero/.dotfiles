return {
  flavour = "macchiato",
  transparent_background = vim.g.transparency,
  term_colors = true,
  dim_inactive = {
    enabled = true,
    shade = "dark",
    percentage = 0.50,
  },
  styles = {
    conditionals = {},
  },
  integrations = {
    cmp = true,
    gitsigns = true,
    nvimtree = true,
    treesitter = true,
    mini = {
      enabled = true,
      indentscope_color = "",
    },
    alpha = true,
    harpoon = true,
    indent_blankline = {
      enabled = true,
      scope_color = "lavender",
    },
    native_lsp = {
      enabled = true,
    },
    semantic_tokens = true,
    leap = true,
    telescope = {
      enabled = true,
      style = "nvchad",
    },
  },
}
