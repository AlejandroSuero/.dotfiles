return {
  "folke/todo-comments.nvim",
  event = "InsertEnter",
  config = function()
    local todo = require "todo-comments"
    todo.setup {
      signs = false,
    }

    local mappings = {
      n = {
        ["]T"] = {
          function()
            todo.jump_next()
          end,
          "[T]odo next",
        },
        ["[T"] = {
          function()
            todo.jump_prev()
          end,
          "[T]odo prev",
        },
      },
    }

    require("aome.core.utils").map_keys(mappings)
  end,
}
