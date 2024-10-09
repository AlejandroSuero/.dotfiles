return {
  "NvChad/nvim-colorizer.lua",
  cmd = "ColorizerToggle",
  keys = {
    {
      "<leader>ct",
      "<cmd>ColorizerToggle<CR>",
      desc = "[Colorizer] Toggle colorizer",
    },
  },
  config = function()
    local colorizer = require "colorizer"

    colorizer.setup {
      user_default_options = {
        RRGGBBAA = true,
        AARRGGBB = true,
        tailwind = true,
        rgb_fn = true,
        hsl_fn = true,
        css = true,
        css_fn = true,
        names = false,
      },
    }
  end,
}
