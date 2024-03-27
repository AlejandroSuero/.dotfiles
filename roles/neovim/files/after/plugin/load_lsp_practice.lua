local path_to_executable = os.getenv "HOME" .. "/dev/lsp-practice/main"
if package.config:sub(1, 1) ~= "/" then
  path_to_executable = path_to_executable .. ".exe"
end

local client = vim.lsp.start_client {
  name = "lsp_practice",
  cmd = { path_to_executable },
  on_attach = require("aome.plugins.lsp.configs.lsp").on_attach,
}

if not client then
  vim.notify(
    "Hey, the client thingy wasn't done correctly",
    vim.log.levels.WARN
  )
  return
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.lsp.buf_attach_client(0, client)
  end,
})
