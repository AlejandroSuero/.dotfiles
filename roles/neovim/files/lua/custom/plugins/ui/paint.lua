return {
  "folke/paint.nvim",
  config = function()
    require("paint").setup {
      highlights = {
        {
          -- FIXME:
          -- filter can be a table of buffer options that should match,
          -- or a function called with buf as param that should return true.
          -- The example below will paint @something in comments with Constant
          filter = { filetype = "lua" },
          pattern = "%s*%-%-%-%s*(@%w+)",
          hl = "Constant",
          -- TODO:
        },
      },
    }
  end,
  ft = { "lua" },
  event = "VeryLazy",
}
