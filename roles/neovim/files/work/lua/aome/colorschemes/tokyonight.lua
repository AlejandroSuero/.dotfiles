local transparent = function()
  if vim.g.transparency == true then
    return "transparent"
  end
  return "dark"
end
return {
  -- your configuration comes here
  -- or leave it empty to use the default settings
  style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
  light_style = "night", -- The theme is used when the background is set to light
  transparent = vim.g.transparency, -- Enable this to disable setting the background color
  terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
  styles = {
    comments = { italic = false },
    keywords = { italic = false, bold = true },
    functions = {},
    variables = {},
    -- Background styles. Can be "dark", "transparent" or "normal"
    sidebars = transparent, -- style for sidebars, see below
    floats = transparent, -- style for floating windows
  },
  dim_inactive = true, -- dims inactive windows
  lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold
  cache = false,
}
