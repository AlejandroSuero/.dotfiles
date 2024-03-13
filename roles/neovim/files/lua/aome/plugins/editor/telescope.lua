local executable = "make"
local build_command = executable
if vim.fn.has "win32" == 1 then
  executable = "cmake"
  build_command = executable
    .. " -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
end
return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "nvim-telescope/telescope-file-browser.nvim",
    { -- If encountering errors, see telescope-fzf-native README for install instructions
      "nvim-telescope/telescope-fzf-native.nvim",

      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      build = build_command,

      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function()
        return vim.fn.executable(executable) == 1
      end,
    },
  },
  lazy = true,
  cmd = {
    "Telescope",
  },
  keys = {
    {
      "<leader>ff",
      "<cmd>Telescope find_files<cr>",
      desc = "[Telescope] Find project files",
    },
    {
      "<leader>fg",
      "<cmd>Telescope git_files<cr>",
      desc = "[Telescope] Find git files",
    },
    {
      "<leader>cs",
      "<cmd>Telescope colorscheme<cr>",
      desc = "[Telescope] Change colorscheme",
    },
    {
      "<leader>km",
      "<cmd>Telescope keymaps<cr>",
      desc = "[Telescope] Show keymaps",
    },
    {
      "<leader>ht",
      "<cmd>Telescope help_tags<cr>",
      desc = "[Telescope] Show help tags",
    },
    {
      "<leader>cm",
      "<cmd>Telescope commands<cr>",
      desc = "[Telescope] Show commands",
    },
    {
      "<leader>pd",
      "<cmd>Telescope diagnostics<cr>",
      desc = "[Telescope] Show diagnostics",
    },
    {
      "<leader>fb",
      function()
        local telescope = require "telescope"
        local telescope_buffer_dir = function()
          return vim.fn.expand "%:p:h"
        end
        telescope.extensions.file_browser.file_browser {
          path = "%:p:h",
          cwd = telescope_buffer_dir(),
          respect_gitignore = false,
          hidden = true,
          grouped = true,
          previewer = false,
          initial_mode = "normal",
          layout_config = {
            height = math.floor(vim.o.lines / 2),
            width = math.floor(vim.o.columns / 2),
          },
        }
      end,
      desc = "[Telescope] file browser",
    },
  },
  config = function()
    local telescope = require "telescope"

    local actions = require "telescope.actions"
    local action_state = require "telescope.actions.state"
    local fb_actions = telescope.extensions.file_browser.actions

    local replace = require("aome.core.utils").replace_word

    telescope.setup {
      defaults = {
        preview = true,
        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-t>"] = actions.select_tab,
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
          n = {
            ["q"] = actions.close,
          },
        },
        file_ignore_patterns = {
          "node_modules/",
          "%.git/",
          "%.DS_Store$",
          "target/",
          "build/",
          "%.o$",
        },
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden",
        },
        layout_config = {
          prompt_position = "top",
          horizontal = {
            width_padding = 0.1,
            height_padding = 0.1,
            preview_width = 0.6,
          },
          vertical = {
            width_padding = 0.1,
            height_padding = 0.1,
            preview_height = 0.5,
          },
        },
        path_display = { "smart" },
        prompt_position = "top",
        prompt_prefix = " 󰍉 ",
        selection_caret = "  ",
        sorting_strategy = "ascending",
        winblend = 0,
        set_env = { ["COLORTERM"] = "truecolor" },
        border = {},
        borderchars = {
          "─",
          "│",
          "─",
          "│",
          "╭",
          "╮",
          "╯",
          "╰",
        },
        color_devicons = true,
      },
      pickers = {
        colorscheme = {
          prompt_prefix = " 󰏘 ",
          enable_preview = true,
          attach_mappings = function(prompt_bufnr, map)
            -- reload theme while typing
            vim.schedule(function()
              vim.api.nvim_create_autocmd("TextChangedI", {
                buffer = prompt_bufnr,
                callback = function()
                  if action_state.get_selected_entry() then
                    local colorscheme = action_state.get_selected_entry()[1]
                    vim.cmd.colorscheme(colorscheme)
                    local old = 'colorscheme = "' .. vim.g.colorscheme .. '"'
                    local new_data = 'colorscheme = "' .. colorscheme .. '"'
                    vim.g.colorscheme = colorscheme
                    replace(old, new_data)
                  end
                end,
              })
            end)
            local replace_colorscheme = function()
              local colorscheme = action_state.get_selected_entry()[1]
              vim.cmd.colorscheme(colorscheme)
              local old = 'colorscheme = "' .. vim.g.colorscheme .. '"'
              local new_data = 'colorscheme = "' .. colorscheme .. '"'
              vim.g.colorscheme = colorscheme
              replace(old, new_data)
            end
            -- -- reload theme on cycling
            map("i", "<C-n>", function()
              actions.move_selection_next(prompt_bufnr)
              replace_colorscheme()
            end)

            map("i", "<Down>", function()
              actions.move_selection_next(prompt_bufnr)
              replace_colorscheme()
            end)

            map("i", "<C-j>", function()
              actions.move_selection_next(prompt_bufnr)
              replace_colorscheme()
            end)

            map("i", "<C-p>", function()
              actions.move_selection_previous(prompt_bufnr)
              replace_colorscheme()
            end)

            map("i", "<Up>", function()
              actions.move_selection_previous(prompt_bufnr)
              replace_colorscheme()
            end)

            map("i", "<C-k>", function()
              actions.move_selection_previous(prompt_bufnr)
              replace_colorscheme()
            end)

            map("n", "j", function()
              actions.move_selection_next(prompt_bufnr)
              replace_colorscheme()
            end)

            map("n", "k", function()
              actions.move_selection_previous(prompt_bufnr)
              replace_colorscheme()
            end)

            ------------ save theme to aomerc on enter ----------------
            actions.select_default:replace(function()
              if action_state.get_selected_entry() then
                actions.close(prompt_bufnr)
                replace_colorscheme()
              end
            end)
            return true
          end,
        },
        find_files = {
          prompt_prefix = " 󰈔 ",
          find_command = { "rg", "--files", "--ignore", "--hidden" },
        },
        git_files = {
          prompt_prefix = " 󰊢 ",
          show_untracked = true,
        },
        keymaps = {
          prompt_prefix = " 󰌌 ",
        },
        commands = {
          prompt_prefix = "  ",
        },
        help_tags = {
          prompt_prefix = " 󰞋 ",
        },
        grep_string = {
          prompt_prefix = " 󰬶 ",
        },
        diagnostics = {
          prompt_prefix = " 󱉦 ",
        },
      },
      extensions = {
        fzf = {
          fuzzy = true, -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = "smart_case", -- or "ignore_case" or "respect_case"
        },
        file_browser = {
          theme = "dropdown",
          -- disables netrw and use telescope-file-browser in its place
          hijack_netrw = false,
          mappings = {
            -- your custom insert mode mappings
            ["n"] = {
              -- your custom normal mode mappings
              ["%"] = fb_actions.create,
              ["-"] = fb_actions.goto_parent_dir,
              ["/"] = function()
                vim.cmd "startinsert"
              end,
              ["<C-u>"] = function(prompt_bufnr)
                for i = 1, 10 do
                  actions.move_selection_previous(prompt_bufnr)
                end
              end,
              ["<C-d>"] = function(prompt_bufnr)
                for i = 1, 10 do
                  actions.move_selection_next(prompt_bufnr)
                end
              end,
              ["<PageUp>"] = actions.preview_scrolling_up,
              ["<PageDown>"] = actions.preview_scrolling_down,
            },
          },
        },
      },
    }

    local builtin = require "telescope.builtin"

    local mappings = {
      n = {
        -- find string
        ["<leader>ps"] = {
          function()
            builtin.grep_string {
              search = vim.fn.input "Grep -> ",
            }
          end,
          "[Telescope] Grep string",
        },
      },
    }

    require("aome.core.utils").map_keys(mappings)

    pcall(require("telescope").load_extension, "fzf")
    pcall(require("telescope").load_extension, "file_browser")
  end,
}
