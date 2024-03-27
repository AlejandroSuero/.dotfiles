return {
  "folke/noice.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  keys = { ":", "/" },
  config = function()
    local noice = require "noice"
    noice.setup {
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = false, -- use a classic bottom cmdline for search
        command_palette = false, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
      notify = {
        enabled = false,
      },
      messages = {
        enabled = false,
      },
      cmdline = {
        view = "cmdline_popup",
        opts = {},
        format = {
          cmdline = {
            pattern = "^:",
            icon = "  :",
            lang = "vim",
          },
          search_down = {
            kind = "search",
            pattern = "^/",
            icon = " 󰍉  ",
            lang = "regex",
          },
          search_up = {
            kind = "search",
            pattern = "^%?",
            icon = " 󰍉  ",
            lang = "regex",
          },
          filter = {
            pattern = "^:%s*!",
            icon = "  ",
            lang = "bash",
          },
          lua = {
            pattern = {
              "^:%s*lua%s+",
              "^:%s*lua%s*=%s*",
              "^:%s*=%s*",
            },
            icon = "  ",
            lang = "lua",
          },
          help = {
            pattern = "^:%s*he?l?p?%s+",
            icon = "?",
          },
          input = {
            icon = " 󱔏 ",
            lang = "text",
            opts = {
              border = {
                text = {
                  top = " Search String ",
                },
              },
            },
          }, -- Used by input()
        },
      },
      views = {
        cmdline_popup = {
          border = {
            style = "none",
            padding = { 1, 2 },
          },
          filter_options = {},
          win_options = {
            winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
            winblend = 0,
          },
        },
      },
    }
  end,
}
