return {
  "lukas-reineke/indent-blankline.nvim",
  lazy = true,
  event = { "BufReadPre", "BufNewFile" },
  main = "ibl",
  opts = {
    exclude = {
      filetypes = {
        "help",
        "terminal",
        "lazy",
        "lspinfo",
        "TelescopePrompt",
        "TelescopeResults",
        "mason",
        "",
      },
      buftypes = { "terminal" },
    },
    scope = {
      enabled = true,
    },
  },
  config = function(_, opts)
    local blankline = require "ibl"
    blankline.setup(opts)
  end,
}
