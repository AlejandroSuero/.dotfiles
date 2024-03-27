return {
  "tpope/vim-fugitive",
  lazy = true,
  cmd = { "G", "Git" },
  keys = {
    { "<leader>gs", "<cmd>tab Git<cr>", desc = "Git status" },
  },
}
