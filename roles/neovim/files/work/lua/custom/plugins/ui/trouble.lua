return {
  {
    "folke/trouble.nvim",
    keys = {
      {
        "<leader>tq",
        "<cmd>Trouble diagnostics toggle focus=true<CR>",
        { desc = "[t]rouble [q]uickfix" },
      },
      {
        "<leader>n",
        function()
          vim.cmd "Trouble diagnostics next"
          vim.cmd "Trouble diagnostics jump"
        end,
        { desc = "[t]rouble [n]ext" },
      },
      {
        "<leader>N",
        function()
          vim.cmd "Trouble diagnostics prev"
          vim.cmd "Trouble diagnostics jump"
        end,
        { desc = "[t]rouble [n]ext" },
      },
    },
    config = function()
      local trouble = require "trouble"
      trouble.setup {
        icons = nil,
      }
    end,
  },
}
