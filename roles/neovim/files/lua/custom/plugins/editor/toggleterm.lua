return {
  "akinsho/toggleterm.nvim",
  cmd = { "ToggleTerm" },
  keys = {
    { "<C-t>", "<cmd>ToggleTerm<CR>", desc = "[t]oggle [t]erminal" },
  },
  opts = {
    open_mapping = [[<C-t>]],
    direction = "float",
    insert_mappings = false,
    float_opts = {
      border = "curved",
      title_pos = "center",
    },
  },
}
