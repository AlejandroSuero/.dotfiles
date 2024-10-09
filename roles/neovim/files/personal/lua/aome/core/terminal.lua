local set = vim.opt_local

vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("aome-term-open", {}),
  callback = function()
    set.number = false
    set.relativenumber = false
    set.scrolloff = 0
  end,
})

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { noremap = true })

vim.keymap.set("n", "<leader>st", function()
  vim.cmd.new()
  vim.cmd.wincmd "J"
  vim.api.nvim_win_set_height(0, 12)
  vim.wo.winfixheight = true
  vim.cmd.term()
end, { desc = "[s]plit [t]erminal" })
