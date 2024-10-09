return {
  "supermaven-inc/supermaven-nvim",
  lazy = false,
  config = function()
    require("supermaven-nvim").setup {
      keymaps = {
        accept_suggestion = "<S-Tab>",
      },
      color = {
        suggestion_color = vim.api.nvim_get_hl(0, { name = "NonText" }).fg,
        cterm = vim.api.nvim_get_hl(0, { name = "NonText" }).cterm,
        suggestion_group = "NonText",
      },
      ignore_filetypes = {
        alpha = true,
        man = true,
        help = true,
        text = true,
        gitrebase = true,
        gitstatus = true,
        diff = true,
        fugitiveblame = true,
        env = true,
      },
      log_level = "off",
    }
  end,
}
