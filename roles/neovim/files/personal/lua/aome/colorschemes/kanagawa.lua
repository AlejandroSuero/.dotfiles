return {
  undercurl = true, -- enable undercurls
  commentStyle = { italic = true },
  keywordStyle = { italic = false, bold = true },
  statementStyle = { bold = true },
  typeStyle = {},
  transparent = vim.g.transparency, -- do not set background color
  dimInactive = true, -- dim inactive window `:h hl-NormalNC`
  terminalColors = true, -- define vim.g.terminal_color_{0,17}
  background = { -- map the value of 'background' option to a theme
    dark = "wave", -- try "dragon" !
    light = "dragon",
  },
}
