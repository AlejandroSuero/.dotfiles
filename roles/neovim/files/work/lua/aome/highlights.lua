local augroup = vim.api.nvim_create_augroup
local AomeGroup = augroup("Aome", {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", {})

autocmd("TextYankPost", {
  group = yank_group,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank {
      higroup = "IncSearch",
      timeout = 100,
    }
  end,
})

autocmd({ "BufWritePre" }, {
  group = AomeGroup,
  pattern = "*",
  command = [[%s/\s\+$//e]],
})
