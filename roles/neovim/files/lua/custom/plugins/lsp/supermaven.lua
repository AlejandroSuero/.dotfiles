return {
  "supermaven-inc/supermaven-nvim",
  lazy = false,
  -- enable = false,
  config = function()
    require("supermaven-nvim").setup {
      color = {
        suggestion_color = "#89b4fa",
        cterm = 117,
      },
    }
  end,
 dev = true,
}
