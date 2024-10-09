return {
  "stevearc/dressing.nvim",
  event = "VeryLazy",
  opts = {
    input = {
      relative = "win",
      title_pos = "center",
      win_options = {
        winblend = 0,
      },
    },
    select = {
      backend = { "telescope", "builtin", "fzf_lua", "fzf", "nui" },
    },
  },
}
