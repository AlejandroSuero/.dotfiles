return {
  compile = false,             -- enable compiling the colorscheme
  undercurl = true,            -- enable undercurls
  commentStyle = { italic = false },
  functionStyle = {},
  keywordStyle = { italic = false, bold = true },
  statementStyle = { bold = true },
  typeStyle = {},
  transparent = vim.g.transparency,         -- do not set background color
  dimInactive = true,         -- dim inactive window `:h hl-NormalNC`
  terminalColors = true,       -- define vim.g.terminal_color_{0,17}
  theme = "wave",              -- Load "wave" theme when 'background' option is not set
}
