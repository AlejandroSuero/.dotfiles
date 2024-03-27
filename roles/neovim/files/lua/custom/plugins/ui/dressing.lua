return {
  "stevearc/dressing.nvim",
  event = { "BufReadPre", "BufNewFile" },
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
