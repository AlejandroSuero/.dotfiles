return {
  "stevearc/dressing.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    input = {
      relative = "win",
    },
    select = {
      backend = { "telescope", "builtin", "fzf_lua", "fzf", "nui" },
    },
  },
}
