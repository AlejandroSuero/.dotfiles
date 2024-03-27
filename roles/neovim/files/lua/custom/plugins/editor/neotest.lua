return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    -- adapters --
    "nvim-neotest/neotest-go",
    "nvim-neotest/neotest-jest",
    "marilari88/neotest-vitest",
  },
  keys = {
    {
      "<leader>tr",
      "<cmd>lua require('neotest').run.run()<CR>",
      desc = "[t]est [r]un",
    },
    {
      "<leader>tK",
      "<cmd>lua require('neotest').output.open()<CR>",
      desc = "[t]est [K]hover",
    },
    {
      "<leader>to",
      "<cmd>lua require('neotest').summary.toggle()<CR>",
      desc = "[t]est [o]pen summary",
    },
  },
  event = "VeryLazy",
  config = function()
    local neotest = require "neotest"
    ---@diagnostic disable-next-line: missing-fields
    neotest.setup {
      adapters = {
        require "neotest-go" {
          recursive_run = true,
        },
        require "neotest-jest" {
          jestCommand = require("neotest-jest.jest-util").getJestCommand(
            vim.fn.expand "%:p:h"
          ) .. " --watch",
        },
        require "neotest-vitest" {
          -- Filter directories when searching for test files. Useful in large projects (see Filter directories notes).
          ---@diagnostic disable-next-line: unused-local
          filter_dir = function(name, rel_path, root)
            return name ~= "node_modules"
          end,
          vitestCommand = "vitest --watch",
        },
      },
    }
  end,
}
