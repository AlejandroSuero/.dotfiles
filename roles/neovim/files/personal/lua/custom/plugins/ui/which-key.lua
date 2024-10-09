return {
  "folke/which-key.nvim",
  keys = { "<leader>", "<C-r>", '"', "`", "'", "c", "v", "g" },
  cmd = "WhichKey",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
  config = function(_, opts)
    require("which-key").setup(opts)
  end,
  lazy = true,
}
