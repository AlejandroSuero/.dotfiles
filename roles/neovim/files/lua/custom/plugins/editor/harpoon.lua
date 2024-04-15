return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local harpoon = require "harpoon"
    harpoon:setup {}

    local mappings = {
      n = {
        ["<leader>a"] = {
          function()
            harpoon:list():append()
          end,
          "[Harpoon] Append current file to list",
        },
        ["<C-e>"] = {
          function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
          end,
          "[Harpoon] Open quick menu",
        },
        ["<leader>hn"] = {
          function()
            harpoon:list():next()
          end,
          "[Harpoon] Navigate to next item",
        },
        ["<leader>hp"] = {
          function()
            harpoon:list():prev()
          end,
          "[Harpoon] Navigate to previous item",
        },
      },
    }
    -- Mappings for <leader>n where n is a number 1 -> 9
    for i = 1, 9, 1 do
      vim.keymap.set("n", "<leader>" .. tostring(i), function()
        harpoon:list():select(i)
      end, { desc = "[Harpoon] Navigate to item " .. tostring(i) })
    end
    require("aome.core.utils").map_keys(mappings)
  end,
}
