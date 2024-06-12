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
    keys = {
      {
        "<leader>fz",
        function()
          require("freeze-code.utils.api").freeze()
        end,
        desc = "[f]ree[z]e file",
      },
      {
        "<leader>fz",
        function()
          require("freeze-code.utils.api").freeze(vim.fn.line ".", vim.fn.line "v")
        end,
        desc = "[f]ree[z]e line",
        mode = "v",
      },
      {
        "<leader><leader>fz",
        function()
          require("freeze-code.utils.api").freeze_line()
        end,
        desc = "[f]ree[z]e current line",
      },
    },
    config = function()
      require("freeze-code").setup {
        freeze_config = {
          config = "user",
        },
      }
    end,
    dev = true,
  },
}
