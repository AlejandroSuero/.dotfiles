return {
  "supermaven-inc/supermaven-nvim",
  -- event = "VeryLazy",
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
      condition = function()
        return vim.fn.expand "%:t:r" == "api"
      end,
      dot_repeat = true,
      ignore_filetypes = {
        "help",
        "man",
        "text",
        "gitrebase",
        "gitstatus",
        "diff",
        "fugitiveblame",
        "alpha",
        alpha = true,
        man = true,
        help = true,
        text = true,
        gitrebase = true,
        gitstatus = true,
        diff = true,
        fugitiveblame = true,
      },
      log_level = "off",
    }
  end,
  dev = true,
}
