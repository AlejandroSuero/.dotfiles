return {
  "AlejandroSuero/colorscheme-installer.nvim",
  lazy = false,
  dev = true,
  config = function()
    require("colorscheme-installer").setup()
  end,
}
