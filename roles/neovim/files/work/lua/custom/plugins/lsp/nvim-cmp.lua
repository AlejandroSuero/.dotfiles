return {
  "hrsh7th/nvim-cmp",
  lazy = false,
  priority = 100,
  dependencies = {
    -- Snippet Engine & its associated nvim-cmp source
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "onsails/lspkind.nvim",

    -- Adds other completion capabilities.
    --  nvim-cmp does not ship with all sources by default. They are split
    --  into multiple repos for maintenance purposes.
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-buffer",
    "folke/lazydev.nvim",
    {
      "Dynge/gitmoji.nvim",
      opts = {
        filetypes = { "gitcommit" },
        completion = {
          append_space = false,
          complete_as = "emoji",
        },
      },
      ft = "gitcommit",
    },
  },
  config = function()
    vim.opt.completeopt = "menu,menuone,noselect"
    vim.opt.shortmess:append "c"

    local lspkind = require "lspkind"
    lspkind.init {}

    local cmp = require "cmp"

    local luasnip = require "luasnip"

    cmp.setup {
      sources = {
        { name = "lazydev", group_index = 0 },
        { name = "gitmoji" },
        { name = "supermaven" },
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "buffer" }, -- text within current buffer
      },
      snippet = { -- configure how nvim-cmp interacts with snippet engine
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item {
          behavior = cmp.SelectBehavior.Select,
        }, -- previous suggestion
        ["<C-n>"] = cmp.mapping.select_next_item {
          behavior = cmp.SelectBehavior.Select,
        }, -- next suggestion
        ["<C-y>"] = cmp.mapping(
          cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          },
          { "i", "c" }
        ),
      },
    }

    vim.api.nvim_set_hl(0, "CmpItemKindSupermaven", { fg = "#44bdff" })
  end,
}
