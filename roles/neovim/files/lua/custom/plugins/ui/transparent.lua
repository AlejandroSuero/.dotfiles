return {
  "xiyaowong/transparent.nvim",
  cmd = "TransparentToggle",
  config = function()
    local transparent = require "transparent"
    transparent.setup {
      groups = {
        "Normal",
        "NormalFloat",
      },
    }
  end,
  keys = {
    {
      "<leader>tt",
      function()
        vim.g.transparent_enabled = vim.g.transparency
        local old = "transparency = " .. tostring(vim.g.transparency)
        local new = "transparency = " .. tostring(not vim.g.transparency)
        require("aome.core.utils").replace_word(old, new)
        vim.g.transparency = not vim.g.transparency
        vim.cmd.TransparentToggle()
      end,
      desc = "[t]oggle [t]ransparency",
    },
  },
}
