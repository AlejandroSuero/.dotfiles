return {
  "themaxmarchuk/tailwindcss-colors.nvim",
  event = { "BufReadPre *.{js,ts,jsx,tsx}", "BufNewFile *.{js,ts,jsx,tsx}" },
  ft = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
  config = function()
    require("tailwindcss-colors").setup()
  end,
}
