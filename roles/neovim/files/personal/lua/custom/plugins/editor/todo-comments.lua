return {
  "numToStr/Comment.nvim",
  dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
  lazy = true,
  keys = {
    { "gcc", desc = "Comment current line" },
    { "gc", mode = "v", desc = "Comment selected text" },
  },
  config = function()
    local comment = require "Comment"
    comment.setup {
      pre_hook = function(ctx)
        -- Only calculate commentstring for tsx filetypes
        if vim.bo.filetype == "typescriptreact" then
          local utils = require "Comment.utils"

          -- Determine whether to use linewise or blockwise commentstring
          local type = ctx.ctype == utils.ctype.linewise and "__default"
            or "__multiline"

          -- Determine the location where to calculate commentstring from
          local location = nil
          if ctx.ctype == utils.ctype.blockwise then
            location =
              require("ts_context_commentstring.utils").get_cursor_location()
          elseif
            ctx.cmotion == utils.cmotion.v
            or ctx.cmotion == utils.cmotion.V
          then
            location =
              require("ts_context_commentstring.utils").get_visual_start_location()
          end

          return require("ts_context_commentstring.internal").calculate_commentstring {
            key = type,
            location = location or ctx.location,
          }
        end
      end,
    }
  end,
}
