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
}
