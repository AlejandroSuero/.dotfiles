local mappings = {
  n = {
    ["<leader>ee"] = {
      "oif err != nil {<CR>}<Esc>Oreturn err<Esc>",
      "[Go] if err not nil",
    },
  },
}

vim.opt.expandtab = false
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2

require("aome.core.utils").map_keys(mappings, { noremap = true, silent = true })

--- snippets
require "aome.snippets.ft.go"
