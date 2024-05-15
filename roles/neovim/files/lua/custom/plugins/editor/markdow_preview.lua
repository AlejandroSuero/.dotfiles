return {
  "ellisonleao/glow.nvim",
  dev = true,
  config = function()
    local glow = require "glow"

    glow.setup {
      style = "dark",
      width = vim.o.columns - 20,
      height = vim.o.lines - 20,
    }
  end,
  cmd = "Glow",
  keys = {
    {
      "<leader>md",
      "<cmd>Glow<CR>",
      desc = "[m]arkdown [p]review toggle",
    },
  },
  ft = { "markdown" },
}
