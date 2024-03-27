return {
  {
    "vhyrro/luarocks.nvim",
    priority = 1000,
    config = true,
  },
  {
    "rest-nvim/rest.nvim",
    ft = "http",
    dependencies = { "luarocks.nvim" },
    keys = {
      { "<leader>rr", "<cmd>Rest run<CR>", desc = "[r]est [r]un under cursor" },
      { "<leader>rl", "<cmd>Rest run last<CR>", desc = "[r]est run [l]ast" },
    },
    config = function()
      require("rest-nvim").setup()
    end,
  },
}
