return {
  -- {
  --   "ethanholz/freeze.nvim",
  --   config = true,
  --   opts = {
  --     theme = "rose-pine-moon",
  --     copy = true,
  --     open = true,
  --   },
  --   event = "verylazy",
  --   keys = {
  --     { "<leader>fz", "<cmd>freeze<cr>", desc = "[f]ree[z]e file" },
  --     {
  --       "<leader>fz",
  --       "<cmd>freezeline<cr>",
  --       desc = "[f]ree[z]e line",
  --       mode = "v",
  --     },
  --   },
  --   dev = true,
  -- },
  {
    "AlejandroSuero/freeze-code.nvim",
    event = { "VeryLazy", "BufReadPre", "BufNewFile" },
    config = function()
      require("freeze-code").setup {
        copy = true,
        freeze_config = {
          theme = "rose-pine-moon",
          config = "full",
        },
      }
    end,
    dev = true,
  },
}
