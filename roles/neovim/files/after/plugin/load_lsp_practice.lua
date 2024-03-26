local ok, telescope_builtin = pcall(require, "telescope.builtin")
if not ok then
  vim.notify("telescope not loaded", vim.log.levels.WARN)
  return
end

local path_to_executable = os.getenv "HOME" .. "/dev/lsp-practice/main"
if package.config:sub(1, 1) ~= "/" then
  path_to_executable = path_to_executable .. ".exe"
end

local client = vim.lsp.start_client {
  name = "lsp_practice",
  cmd = { path_to_executable },
  on_attach = function(client, bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }

    local mappings = {
      n = {
        ["gR"] = {
          telescope_builtin.lsp_references,
          "LSP show references",
        },
        ["gD"] = {
          vim.lsp.buf.declaration,
          "LSP go to declaration",
        },
        ["gd"] = {
          telescope_builtin.lsp_definitions,
          "LSP show definitions",
        },
        ["gi"] = {
          telescope_builtin.lsp_implementations,
          "LSP show implementations",
        },
        ["gt"] = {
          telescope_builtin.lsp_type_definitions,
          "LSP show type definitions",
        },
        ["<leader>ca"] = {
          vim.lsp.buf.code_action,
          "LSP see available code actions",
        },
        ["<leader>rn"] = {
          vim.lsp.buf.rename,
          "LSP rename",
        },
        ["<leader>D"] = {
          function()
            telescope_builtin.diagnostics { bufnr = bufnr }
          end,
          "LSP show buffer diagnostics",
        },
        ["[d"] = {
          vim.diagnostic.goto_prev,
          "LSP go to previous diagnostic",
        },
        ["]d"] = {
          vim.diagnostic.goto_next,
          "LSP go to next diagnostic",
        },
        ["<leader>ld"] = {
          vim.diagnostic.open_float,
          "LSP show line diagnostic",
        },
        ["K"] = {
          vim.lsp.buf.hover,
          "LSP show documentation under cursor",
        },
      },
      i = {
        ["<C-h>"] = {
          vim.lsp.buf.signature_help,
          "LSP show signature",
        },
      },
    }
    require("aome.core.utils").map_keys(mappings, opts)

    if client and client.server_capabilities.documentHighlightProvider then
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = bufnr,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = bufnr,
        callback = vim.lsp.buf.clear_references,
      })
    end
  end,
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
