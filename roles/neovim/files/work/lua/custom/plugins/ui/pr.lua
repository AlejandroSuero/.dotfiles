return {
  "AlejandroSuero/pr.nvim",
  event = "VeryLazy",
  config = function()
    require("pr").setup()
  end,
  dev = true,
}
