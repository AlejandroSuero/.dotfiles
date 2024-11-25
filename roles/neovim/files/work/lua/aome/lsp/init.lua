local lspconfig = vim.F.npcall(require, "lspconfig")
if not lspconfig then
  return
end

local lsputils = vim.F.npcall(require, "lspconfig.util")
if not lsputils then
  return
end

local cmp_lsp = vim.F.npcall(require, "cmp_nvim_lsp")
if not cmp_lsp then
  return
end

local imap = require("aome.core.utils").imap
local nmap = require("aome.core.utils").nmap
local autocmd = require("aome.core.utils").auto.autocmd
local autocmd_clear = vim.api.nvim_clear_autocmds

local telescope_mapper = require "aome.telescope.mappings"
local handlers = require "aome.lsp.handlers"

local ts_util = require "nvim-lsp-ts-utils"
-- local inlays = require "aome.lsp.inlay"
local codelens = require "aome.lsp.codelens"

local custom_init = function(client)
  client.config.flags = client.config.flags or {}
  client.config.flags.allow_incremental_sync = true
end

local augroup_highlight =
  vim.api.nvim_create_augroup("custom-lsp-references", { clear = true })
local augroup_codelens =
  vim.api.nvim_create_augroup("custom-lsp-codelens", { clear = true })

local toggle_virtlines = function()
    -- Display type information
    autocmd_clear { group = augroup_codelens, buffer = 0 }
    autocmd {
      { "BufEnter", "BufWritePost", "CursorHold" },
      augroup_codelens,
      codelens.refresh_virtlines,
      0,
    }

    vim.keymap.set(
      "n",
      "<space>TT",
      codelens.toggle_virtlines,
      { silent = true, desc = "[T]oggle [T]ypes", buffer = 0 }
    )
end

local filetype_attach = setmetatable({
  typescript = toggle_virtlines,
  typescriptreact = toggle_virtlines,
  javascript = toggle_virtlines,
  javascriptreact = toggle_virtlines,

  rust = function()
    telescope_mapper("<space>wrs", "lsp_workspace_symbols", {
      ignore_filename = true,
      query = "#",
    }, true, "[w]orkspace [r]ust [s]ymbols")
  end,
}, {
  __index = function()
    return function() end
  end,
})

local buf_nnoremap = function(opts)
  if opts[3] == nil then
    opts[3] = {}
  end
  opts[3].buffer = 0

  nmap(opts)
end

local buf_inoremap = function(opts)
  if opts[3] == nil then
    opts[3] = {}
  end
  opts[3].buffer = 0

  imap(opts)
end

local custom_attach = function(client, bufnr)
  if client.name == "copilot" then
    return
  end

  local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })

  buf_inoremap {
    "<C-s>",
    vim.lsp.buf.signature_help,
    { desc = "signature [h]elp" },
  }

  buf_nnoremap { "<leader>rn", vim.lsp.buf.rename, { desc = "[r]e[n]ame" } }
  buf_nnoremap {
    "<leader>ca",
    vim.lsp.buf.code_action,
    { desc = "[c]ode [a]ction" },
  }

  buf_nnoremap { "[d", vim.diagnostic.goto_prev, { desc = "prev [d]iagnostic" } }
  buf_nnoremap { "]d", vim.diagnostic.goto_next, { desc = "next [d]iagnostic" } }

  buf_nnoremap { "gd", vim.lsp.buf.definition, { desc = "[g]o to [d]efinition" } }
  buf_nnoremap {
    "gD",
    vim.lsp.buf.declaration,
    { desc = "[g]o to [D]eclaration" },
  }
  buf_nnoremap {
    "gT",
    vim.lsp.buf.type_definition,
    { desc = "[g]o to [T]ype definition" },
  }
  buf_nnoremap { "K", vim.lsp.buf.hover, { desc = "lsp:hover" } }

  buf_nnoremap {
    "<leader>gI",
    handlers.implementation,
    { desc = "[g]o to [I]mplementation" },
  }
  buf_nnoremap {
    "<leader>lr",
    "<cmd>lua R('aome.lsp.codelens').run()<CR>",
    { desc = "code[l]ens [r]un" },
  }
  buf_nnoremap { "<leader>rs", "LspRestart", { desc = "Lps [r]e[s]tart" } }

  telescope_mapper("gr", "lsp_references", nil, true, "[g]o to [r]eferences")
  telescope_mapper(
    "gI",
    "lsp_implementations",
    nil,
    true,
    "[g]o to [I]mplementation"
  )
  telescope_mapper(
    "<leader>wd",
    "lsp_document_symbols",
    { ignore_filename = true },
    true
  )
  telescope_mapper(
    "<leader>ws",
    "lsp_dynamic_workspace_symbols",
    { ignore_filename = true },
    true,
    "[w]orkspace [s]ymbols"
  )

  -- Set autocommands conditional on server_capabilities
  if
    client.server_capabilities.documentHighlightProvider
    and client.server_capabilities.documentHighlight
  then
    autocmd_clear { group = augroup_highlight, buffer = bufnr }
    autocmd {
      "CursorHold",
      augroup_highlight,
      vim.lsp.buf.document_highlight,
      bufnr,
    }
    autocmd {
      "CursorMoved",
      augroup_highlight,
      vim.lsp.buf.clear_references,
      bufnr,
    }
  else
    autocmd_clear { group = augroup_highlight, buffer = bufnr }
  end
  -- Attach any filetype specific options to the client
  filetype_attach[filetype]()
end

local updated_capabilities = vim.lsp.protocol.make_client_capabilities()
updated_capabilities.textDocument.completion.completionItem.snippetSupport =
  true
updated_capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false

-- Completion configuration
vim.tbl_deep_extend(
  "force",
  updated_capabilities,
  cmp_lsp.default_capabilities()
)
updated_capabilities.textDocument.completion.completionItem.insertReplaceSupport =
  false

updated_capabilities.textDocument.codeLens = { dynamicRegistration = false }

local servers = {
  lua_ls = {
    Lua = {
      library = {
        [vim.fn.expand "$VIMRUNTIME/lua"] = true,
        [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
      },
      completion = {
        callSnippet = "Replace",
      },
      diagnostics = { enable = false },
    },
  },

  emmet_ls = true,

  tailwindcss = {
    on_attach = function(_, bufnr)
      require("tailwindcss-colors").buf_attach(bufnr)
    end,
  },

  html = true,
  yamlls = {
    settings = {
      schemas = require("schemastore").yaml.schemas(),
    },
    filetypes = { "yaml", "yaml.docker-compose" },
  },

  -- Enable jsonls with json schemas
  jsonls = {
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
        validate = { enable = true },
      },
    },
  },

  htmx = true,
  cssls = true,

  astro = true,

  biome = true,

  eslint = true,

  ts_ls = {
    init_options = ts_util.init_options,
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },

    on_attach = function(client)
      custom_attach(client)

      ts_util.setup { auto_inlay_hints = false }
      ts_util.setup_client(client)
    end,
    diagnostics = {
      virtual_text = function()
        for _, client in ipairs(vim.lsp.get_clients { bufnr = 0 }) do
          if client.name == "eslint" then
            return false
          end
        end
        return true
      end,
    },
  },
}

require("mason").setup()
require("mason-lspconfig").setup {
  ensure_installed = { "lua_ls", "jsonls", "eslint", "ts_ls", "tailwindcss" },
}

local setup_server = function(server, config)
  if not config then
    return
  end

  if type(config) ~= "table" then
    config = {}
  end

  config = vim.tbl_deep_extend("force", {
    on_init = custom_init,
    on_attach = custom_attach,
    capabilities = updated_capabilities,
  }, config)

  lspconfig[server].setup(config)
end

for server, config in pairs(servers) do
  setup_server(server, config)
end

return {
  on_init = custom_init,
  on_attach = custom_attach,
  capabilities = updated_capabilities,
}
