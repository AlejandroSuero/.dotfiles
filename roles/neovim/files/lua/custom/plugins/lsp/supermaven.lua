return {
  "supermaven-inc/supermaven-nvim",
  lazy = false,
  -- enable = false,
  config = function()
    require("supermaven-nvim").setup {
      color = {
        suggestion_color = "#DC8CE2", -- default
        cterm = 117,
      },
      -- silence_info = true,
    }
  end,
  dev = true,
}
