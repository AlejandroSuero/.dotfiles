local configs = "aome.colorschemes."
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = require(configs .. "catppuccin"),
  },
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
  {
    "AstroNvim/astrotheme",
    lazy = false,
    priority = 1000,
    config = true,
    opts = require(configs .. "astrotheme"),
    dev = true,
  },
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
    dev = true,
    opts = require(configs .. "cyberdream"),
  },
}
