return {
  terminal_colors = true,
  variant = "cooler",
  highlight_overrides = vim.g.transparency and {
    Normal = { bg = "NONE" },
    NormalNC = { bg = "NONE" },
    CursorLine = { bg = "#222128" },
  } or {},
}
