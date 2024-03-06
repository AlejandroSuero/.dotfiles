return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
      current_line_blame = true,
      numhl = true,
      max_file_length = 10000,
    },
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    "rhysd/git-messenger.vim",
    cmd = { "GitMessenger" },
    keys = {
      { "<leader>gm", "<cmd>GitMessenger<CR>", desc = "[g]it [m]essenger" },
    },
  },
}
