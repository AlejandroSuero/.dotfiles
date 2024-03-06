return {
  "xiyaowong/transparent.nvim",
  cmd = "TransparentToggle",
  config = true,
  keys = {
    {
      "<C-t>",
      function()
        vim.cmd.TransparentToggle()
        local old = "transparency = " .. tostring(vim.g.transparency)
        local new = "transparency = " .. tostring(not vim.g.transparency)
        require("aome.core.utils").replace_word(old, new)
        vim.g.transparency = not vim.g.transparency
      end,
      desc = "Toggle transparency",
    },
  },
}
