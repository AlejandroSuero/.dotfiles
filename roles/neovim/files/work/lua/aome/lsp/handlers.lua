-- Jump directly to the first available definition every time.
vim.lsp.handlers["textDocument/definition"] = function(_, result)
  if not result or vim.tbl_isempty(result) then
    print "[LSP] Could not find definition"
    return
  end

  if vim.islist(result) then
    vim.lsp.util.jump_to_location(result[1], "utf-8")
  else
    vim.lsp.util.jump_to_location(result, "utf-8")
  end
end

vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.handlers["textDocument/publishDiagnostics"], {
      signs = {
        severity = { min = vim.diagnostic.severity.WARN },
      },
      underline = {
        severity = { min = vim.diagnostic.severity.ERROR },
      },
      virtual_text = true,
    })

local M = {}

M.implementation = function()
  local params = vim.lsp.util.make_position_params()

  vim.lsp.buf_request(
    0,
    "textDocument/implementation",
    params,
    function(err, result, ctx, config)
      vim.lsp.handlers["textDocument/implementation"](err, result, ctx, config)
      vim.cmd [[normal! zz]]
    end
  )
end

return M
