local mappings = {
  n = {
    ["<leader>ee"] = {
      "oif err != nil {<CR>}<Esc>Oreturn err<Esc>",
      "[Go] if err not nil",
    },
  },
}

require("aome.core.utils").map_keys(mappings, { noremap = true, silent = true })

--- snippets
require "aome.snippets.ft.go"
