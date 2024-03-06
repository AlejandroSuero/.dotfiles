return {
  "christoomey/vim-tmux-navigator",
  lazy = true,
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
  },
  keys = {
    {
      "<leader><leader>h",
      vim.cmd.TmuxNavigateLeft,
      desc = "Tmux navigate left",
    },
    {
      "<leader><leader>j",
      vim.cmd.TmuxNavigateDown,
      desc = "Tmux navigate down",
    },
    { "<leader><leader>k", vim.cmd.TmuxNavigateUp, desc = "Tmux navigate up" },
    {
      "<leader><leader>l",
      vim.cmd.TmuxNavigateRight,
      desc = "Tmux navigate right",
    },
  },
}
