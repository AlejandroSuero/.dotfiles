return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-telescope/telescope-file-browser.nvim",
    { -- If encountering errors, see telescope-fzf-native README for install instructions
      "nvim-telescope/telescope-fzf-native.nvim",

      build = "make",
    },
  },
  lazy = false,
  config = function()
    require "aome.telescope.setup"
    require "aome.telescope.keys"
  end,
}
