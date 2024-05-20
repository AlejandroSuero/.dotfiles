return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
      numhl = true,
      max_file_length = 10000,
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local mappings = {
          n = {
            ["]h"] = {
              gs.next_hunk,
              "next [h]unk",
            },
            ["[h"] = {
              gs.prev_hunk,
              "previous [h]unk",
            },
            ["<leader>hb"] = {
              gs.toggle_current_line_blame,
              "Line [b]lame",
            },
            ["<leader>hs"] = {
              gs.stage_hunk,
              "[h]unk [s]tage",
            },
            ["<leader>hr"] = {
              gs.reset_hunk,
              "[h]unk [r]eset",
            },
            ["<leader>hS"] = {
              gs.stage_buffer,
              "[h]unk [S]tage buffer",
            },
            ["<leader>hR"] = {
              gs.reset_buffer,
              "[h]unk [R]eset buffer",
            },
            ["<leader>hd"] = {
              gs.diffthis,
              "[h]unk [d]iff",
            },
            ["<leader>hD"] = {
              function()
                gs.diffthis "~"
              end,
              "[h]unk [D]iff ~",
            },
            ["<leader>hu"] = {
              gs.undo_stage_hunk,
              "[h]unk [u]ndo stage",
            },
            ["<leader>hp"] = {
              gs.preview_hunk,
              "[h]unk [p]review",
            },
          },
          v = {
            ["<leader>hs"] = {
              function()
                gs.stage_hunk { vim.fn.line ".", vim.fn.line "v" }
              end,
              "[h]unk [s]tage selected",
            },
            ["<leader>hr"] = {
              function()
                gs.reset_hunk { vim.fn.line ".", vim.fn.line "v" }
              end,
              "[h]unk [r]eset selected",
            },
          },
        }

        require("aome.core.utils").map_keys(mappings, { buffer = bufnr })
      end,
    },
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    "rhysd/git-messenger.vim",
    cmd = { "GitMessenger" },
    keys = {
      { "<leader>gm", "<cmd>GitMessenger<CR>", desc = "[g]it [m]essenger" },
    },
  },
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    keys = {
      { "<C-g>", "<cmd>LazyGit<CR>", desc = "Open lazy[g]it" },
    },
  },
}
