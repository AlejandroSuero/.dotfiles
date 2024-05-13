return {
  -- {
  --   "ethanholz/freeze.nvim",
  --   config = true,
  --   opts = {
  --     theme = "rose-pine-moon",
  --     open = true,
  --     copy = true,
  --   },
  --   -- dev = true,
  --   keys = {
  --     { "<leader>fz", "<cmd>Freeze<cr>", desc = "[f]ree[z]e file" },
  --     {
  --       "<leader>fz",
  --       "<cmd>FreezeLine<cr>",
  --       desc = "[f]ree[z]e line",
  --       mode = "v",
  --     },
  --   },
  --   dev = true,
  -- enable = false,
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
