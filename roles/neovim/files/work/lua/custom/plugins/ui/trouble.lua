return {
  {
    "folke/trouble.nvim",
    keys = {
      {
        "<leader>tq",
        "<cmd>Trouble diagnostics toggle focus=false<CR>",
        { desc = "[t]rouble [q]uickfix" },
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
