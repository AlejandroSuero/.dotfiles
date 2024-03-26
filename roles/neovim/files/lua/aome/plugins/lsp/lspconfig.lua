local organize_imports = function()
  local params = {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(0) },
  }
  vim.lsp.buf.execute_command(params)
end

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    -- Automatically install LSPs and related tools to stdpath for neovim
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    {
      "folke/neodev.nvim",
      opts = {},
    },

    -- Useful status updates for LSP.
    -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
    { "j-hui/fidget.nvim", opts = {} },
  },
  config = function()
    local neodev = vim.F.npcall(require, "neodev")
    if neodev then
      neodev.setup {
        override = function(_, library)
          library.enabled = true
          library.plugins = true
        end,
        lspconfig = true,
        pathStrict = true,
      }
    end

    local lspconfig = vim.F.npcall(require, "lspconfig")
    if not lspconfig then
      return
    end
    local ok_builtin, telescope_builtin = pcall(require, "telescope.builtin")
    if not ok_builtin then
      vim.notify("Telescope builtin is not loaded", 3)
      return
    end

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("aome-lsp-attach", { clear = true }),
      callback = function(event)
        local opts = { noremap = true, silent = true, buffer = event.buf }

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
                telescope_builtin.diagnostics { bufnr = event.buf }
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

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = event.buf,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = event.buf,
            callback = vim.lsp.buf.clear_references,
          })
        end
      end,
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend(
      "force",
      capabilities,
      require("cmp_nvim_lsp").default_capabilities()
    )

    capabilities.textDocument.completion.completionItem = {
      documentationFormat = { "markdown", "plaintext" },
      snippetSupport = true,
      preselectSupport = true,
      insertReplaceSupport = true,
      labelDetailsSupport = true,
      deprecatedSupport = true,
      commitCharactersSupport = true,
      tagSupport = { valueSet = { 1 } },
      resolveSupport = {
        properties = {
          "documentation",
          "detail",
          "additionalTextEdits",
        },
      },
    }

    -- Change the Diagnostic symbols in the sign column (gutter)
    -- (not in youtube nvim video)
    local signs = { Error = "E", Warn = "W", Hint = "H", Info = "I" }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    local servers = {
      html = {},
      tsserver = {
        commands = {
          OrganizeImports = {
            organize_imports,
            description = "Organize Imports",
          },
        },
        completions = {
          completeFunctionCalls = true,
        },
        nit_options = {
          preferences = {
            disableSuggestions = true,
          },
        },
      },
      astro = {},
      rust_analyzer = {
        settings = {
          ["rust-analyzer"] = {
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
              runBuildScripts = true,
            },
            -- Add clippy lints for Rust.
            checkOnSave = {
              allFeatures = true,
              command = "clippy",
              extraArgs = { "--no-deps" },
            },
            procMacro = {
              enable = true,
              ignored = {
                ["async-trait"] = { "async_trait" },
                ["napi-derive"] = { "napi" },
                ["async-recursion"] = { "async_recursion" },
              },
            },
          },
        },
      },
      svelte = {},
      tailwindcss = {},
      cssls = {},
      jsonls = {},
      prismals = {},
      graphql = {},
      emmet_ls = {
        filetypes = {
          "html",
          "typescriptreact",
          "javascriptreact",
          "css",
          "sass",
          "scss",
          "less",
          "svelte",
          "astro",
        },
      },
      pyright = {},
      lua_ls = {
        settings = { -- custom settings for lua
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            workspace = {
              -- make language server aware of runtime files
              library = {
                "${3rd}/luv/library",
                unpack(vim.api.nvim_get_runtime_file("", true)),
                [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
                [vim.fn.stdpath "config" .. "lua/aome"] = true,
                [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
              },
              completion = {
                callSnippet = "Replace",
              },
              checkThirdParty = false,
              maxPreload = 100000,
              preloadFileSize = 10000,
            },
          },
        },
      },
      gopls = {
        -- root_dir = function(fname)
        --   local Path = require "plenary.path"
        --
        --   local absolute_cwd = Path:new(vim.uv.cwd()):absolute()
        --   local absolute_fname = Path:new(fname):absolute()
        --
        --   if
        --     string.find(absolute_cwd, "/cmd/", 1, true)
        --     and string.find(absolute_fname, absolute_cwd, 1, true)
        --   then
        --     return absolute_cwd
        --   end
        --
        --   return require("lspconfig.util").root_pattern("go.mod", ".git")(fname)
        -- end,

        settings = {
          gopls = {
            codelenses = { test = true },
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            } or nil,
          },
        },
      },
      clangd = {
        capabilities = capabilities,
      },
    }

    local mason_configs = require "aome.plugins.lsp.configs.mason"

    -- You can add other tools here that you want Mason to install
    -- for you, so that they are available from within Neovim.
    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, mason_configs.ensure_installed)
    require("mason-tool-installer").setup { ensure_installed = ensure_installed }

    require("mason-lspconfig").setup {
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          -- This handles overriding only values explicitly passed
          -- by the server configuration above. Useful when disabling
          -- certain features of an LSP (for example, turning off formatting for tsserver)
          server.capabilities = vim.tbl_deep_extend(
            "force",
            {},
            capabilities,
            server.capabilities or {}
          )
          lspconfig[server_name].setup(server)
        end,
      },
    }
  end,
}
