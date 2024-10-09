return {
  "tpope/vim-fugitive",
  lazy = true,
  cmd = { "G", "Git" },
  keys = {
    { "<leader>gs", "<cmd>tab Git<cr>", desc = "[g]it [s]tatus" },
    { "<leader>GD", "<cmd>Gvdiff<cr>", desc = "[G]it [D]iff" },
    { "<leader>GM", "<cmd>Gvdiffsplit!<cr>", desc = "[G]it [M]erge" },
  },
}
