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
        local filename = vim.fn.expand "%:t:r"
        local ignored_filanames = { "local", "private", "cache", ".env" }
        for _, ignored in ipairs(ignored_filanames) do
          if string.find(filename, ignored) then
            return true
          end
        end
      end,
      dot_repeat = true,
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
  dev = true,
}
