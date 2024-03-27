local plugins_path = "~/.config/nvim/lua/aome/lazy.lua"

local mappings = {
  i = { -- insert mode
    ["jk"] = { "<ESC>", "Leave insert mode" },
    ["<C-c>"] = { "<ESC>", "Leave insert mode" },
  },
  n = { -- normal mode
    ["<leader>l"] = {
      "<cmd>Lazy<CR>",
      "[Lazy] Open",
    },

    ["<leader>rs"] = {
      vim.cmd.LspRestart,
      "Restart LSP",
    },

    ["Y"] = { "yg$", "Copies until <eof>" },
    ["J"] = { "mzJ`z", "Better J behaviour" },

    ["zz"] = { "z.", "Centers buffer" },
    ["<C-d>"] = { "<C-d>zz", "Keeps cursor centered when down a page" },
    ["<C-u>"] = { "<C-u>zz", "Keeps cursor centered when up a page" },
    ["n"] = { "nzzzv", "Keeps cursor centered when next search result" },
    ["N"] = { "Nzzzv", "Keeps cursor centered when previous search result" },

    ["<leader>y"] = { '"+y', "Copies to system clipboard" },
    ["<leader>Y"] = { '"+Y', "Copies to system clipboard" },

    ["<leader>d"] = { '"_d', "Deletes into the void register" },

    ["Q"] = { "<nop>", "You won't wanna go there buddy" },

    ["<leader>fm"] = {
      vim.lsp.buf.format,
      "Formats current buffer if lsp available",
    },

    ["<leader>e"] = {
      vim.diagnostic.open_float,
      "Show diagnostic error messages",
    },

    -- quickfix navigation
    ["<C-n>"] = { "<cmd>cnext<CR>zz", "Next quickfix item" },
    ["<C-p>"] = { "<cmd>cprev<CR>zz", "Previous quickfix item" },

    -- Window
    ["<C-h>"] = { "<cmd>wincmd h<CR>", "Window Navigate left" },
    ["<C-j>"] = { "<cmd>wincmd j<CR>", "Window Navigate down" },
    ["<C-k>"] = { "<cmd>wincmd k<CR>", "Window Navigate up" },
    ["<C-l>"] = { "<cmd>wincdm l<CR>", "Window Navigate right" },

    ["<leader>sj"] = { "<cmd>split<CR>", "[w]indow [s]plit down" },
    ["<leader>sl"] = { "<cmd>vsplit<cr>", "[w]indow [s]plit right" },

    -- Tab
    ["<leader>te"] = { ":tabedit ", "[t]ab [e]dit" },
    ["<leader>tc"] = { "<cmd>tabclose<CR>", "[t]ab [c]lose" },
    ["<leader>tn"] = { "<cmd>tabnext<CR>", "[t]ab [n]next" },
    ["<leader>tp"] = { "<cmd>tabnext<CR>", "[t]ab [p]revious" },

    -- Utilities
    ["+"] = { "<C-a>", "Increment" },
    ["-"] = { "<C-x>", "Decrement" },
    ["<C-a>"] = { "gg<S-v>G", "Select all" },

    ["<leader>x"] = {
      "<cmd>!chmod +x %<CR>",
      "Make current file executable",
    },

    ["<leader>so"] = {
      function()
        vim.cmd "so"
      end,
      "Sources current file",
    },

    ["<leader>epp"] = {
      function()
        vim.cmd.edit(plugins_path)
      end,
      "Go edit " .. plugins_path,
    },

    ["<leader>bc"] = {
      function()
        if not vim.bo.modified then
          vim.cmd "bdelete"
          return
        end
        local filename =
          vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
        vim.ui.select({ "Yes", "No", "Cancel" }, {
          prompt = string.format("Save changes on %s", filename),
        }, function(choice)
          if choice == "Yes" then
            vim.cmd "w"
            vim.cmd "bdelete"
          elseif choice == "No" then
            vim.cmd "q!"
            vim.notify(
              string.format("Changes in file %s not saved", filename),
              3
            )
          else
            vim.notify("Action cancelled", 2)
          end
        end)
      end,
      "Closes current buffer",
    },

    ["<C-s>"] = { "<cmd>w<cr>", "Saves current file" },
    ["<C-S>"] = { "<cmd>wa<cr>", "Saves all files" },
  },
  v = { -- visual mode
    ["<leader>s"] = {
      function()
        vim.cmd "w"
      end,
      "Replace selected",
    },
    ["J"] = { ":m '>+1<CR>gv=gv", "Moves code block up" },
    ["K"] = { ":m '<-2<CR>gv=gv", "Moves code block down" },

    ["<leader>y"] = { '"+y', "Copies to system clipboard" },

    ["<leader>d"] = { '"_d', "Deletes into void register" },

    ["<leader>("] = {
      '"hy:s/<C-r>h/(<C-r>h)/',
      "Surrounds with (",
    },
  },
  x = { -- x mode
    -- paste over and not delete and paste
    ["<leader>P"] = { '"_dP', "Paste over without copying into register" },
  },
}

require("aome.core.utils").map_keys(mappings)
