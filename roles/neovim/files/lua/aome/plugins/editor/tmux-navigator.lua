return {
  "christoomey/vim-tmux-navigator",
  lazy = true,
  keys = {
    {
      "<C-h>",
      vim.cmd.TmuxNavigateLeft,
      desc = "Tmux navigate left",
    },
    {
      "<C-j>",
      vim.cmd.TmuxNavigateDown,
      desc = "Tmux navigate down",
    },
    { "<C-k>", vim.cmd.TmuxNavigateUp, desc = "Tmux navigate up" },
    {
      "<C-l>",
      vim.cmd.TmuxNavigateRight,
      desc = "Tmux navigate right",
    },
  },
}
