return {
  "AlejandroSuero/freeze.nvim",
  branch = "feature/add-installation",
  config = true,
  keys = {
    { "<leader>fz", "<cmd>Freeze<cr>", desc = "[f]ree[z]e file" },
    {
      "<leader>fz",
      "<cmd>FreezeLine<cr>",
      desc = "[f]ree[z]e line",
      mode = "v",
    },
  },
}
