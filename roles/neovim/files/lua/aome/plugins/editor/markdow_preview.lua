return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  build = "cd app && npm install",
  keys = {
    {
      "<leader>md",
      "<cmd>MarkdownPreviewToggle<CR>",
      desc = "[m]arkdown [p]review toggle",
    },
  },
  init = function()
    vim.g.mkdp_filetypes = { "markdown" }
  end,
  ft = { "markdown" },
}
