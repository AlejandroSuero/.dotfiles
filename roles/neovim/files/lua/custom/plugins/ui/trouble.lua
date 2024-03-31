return {
  {
    "folke/trouble.nvim",
    config = function()
      local trouble = require "trouble"
      trouble.setup {
        icons = false,
      }

      local mappings = {
        n = {
          ["<leader>tq"] = {
            function()
              trouble.toggle()
            end,
            "[t]rouble [q]uickfix",
          },
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
