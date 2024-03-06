local transparent_value = 0

if vim.g.transparency then
  transparent_value = 2
end

return {
  transparent_background_level = transparent_value,
  dim_inactive_windows = true,
  float_style = "dim"
}
