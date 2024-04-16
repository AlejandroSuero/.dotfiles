local configs = "aome.colorschemes."
return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = require(configs .. "tokyonight"),
  },
  {
    "rose-pine/neovim",
    lazy = false,
    priority = 1000,
    name = "rose-pine",
    opts = require(configs .. "rose-pine"),
  },
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    config = true,
    opts = require(configs .. "gruvbox"),
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = true,
    opts = require(configs .. "kanagawa"),
  },
  {
    "tjdevries/colorbuddy.nvim",
    lazy = false,
  },
}
