return {
  "folke/zen-mode.nvim",
  lazy = true,
  opts = {
    window = {
      width = math.floor((vim.o.columns / 2) + 20),
      backdrop = 0.50,
      options = {
        cursorline = true,
      },
      plugins = {
        gitsigns = { enabled = false },
        options = {
          laststatus = 3,
        },
      },
    },
    on_open = function(_)
      vim.cmd.colorscheme(vim.g.colorscheme)
    end,
    on_close = function()
      vim.cmd.colorscheme(vim.g.colorscheme)
    end,
  },
  config = function(_, opts)
    local zen_mode = require "zen-mode"
    zen_mode.setup(opts)
  end,
  cmd = "ZenMode",
  keys = {
    { "<leader>zz", "<cmd>ZenMode<cr>", desc = "Enter zen mode" },
  },
}
