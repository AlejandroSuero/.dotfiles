return {
  {
    "folke/trouble.nvim",
    keys = {
      {
        "<leader>tq",
        "<cmd>TroubleToggle<CR>",
        { desc = "[t]rouble [q]uickfix" },
      },
    },
    config = function()
      local trouble = require "trouble"
      trouble.setup {
        icons = false,
      }

      local mappings = {
        n = {
          ["]t"] = {
            function()
              trouble.next { skip_groups = true, jump = true }
            end,
            "[t]rouble next",
          },
          ["[t"] = {
            function()
              trouble.previous { skip_groups = true, jump = true }
            end,
            "[t]rouble previous",
          },
        },
      }
      require("aome.core.utils").map_keys(mappings)
    end,
  },
}
