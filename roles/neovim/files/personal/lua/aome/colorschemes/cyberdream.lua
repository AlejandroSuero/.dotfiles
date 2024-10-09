---@module "cyberdream"
---@type Config
return {
  -- Enable transparent background
  transparent = vim.g.transparency,

  -- Enable italics comments
  italic_comments = false,

  -- Replace all fillchars with ' ' for the ultimate clean look
  hide_fillchars = false,

  -- Modern borderless telescope theme
  borderless_telescope = { border = false, style = "nvchad" },

  -- Set terminal colors used in `:terminal`
  terminal_colors = true,

  theme = {
    variant = "default", -- use "light" for the light variant. Also accepts "auto" to set dark or light colors based on the current value of `vim.o.background`
    overrides = function(colors)
      return {
        ["@variable.member"] = { link = "@property" },
        TelescopeMatching = { fg = colors.cyan },
        TelescopeResultsTitle = { fg = colors.blue },
        TelescopePromptCounter = { fg = colors.cyan },
        TelescopePromptTitle = { fg = colors.bg, bg = colors.blue, bold = true },
        TelescopePromptNormal = { fg = colors.fg, bg = colors.bgHighlight },
        TelescopePromptBorder = {
          fg = colors.bgHighlight,
          bg = colors.bgHighlight,
        },
        TelescopePromptPrefix = { fg = colors.blue, bg = colors.bgHighlight },
      }
    end,
  },
}
