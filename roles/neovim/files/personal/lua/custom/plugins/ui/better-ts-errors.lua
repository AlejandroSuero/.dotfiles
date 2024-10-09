return {
  "OlegGulevskyy/better-ts-errors.nvim",
  dependencies = { "MunifTanjim/nui.nvim" },
  ft = { "typescript", "typescriptreact" },
  event = { "BufReadPre *.ts", "BufReadPre *.tsx", "BufNewFile *.ts", "BufNewFile *.tsx" },
  config = {
    keymaps = {
      toggle = "<leader>dd", -- default '<leader>dd'
      go_to_definition = "<leader>dx", -- default '<leader>dx'
    },
  },
}
