local ok, telescope = pcall(require, "telescope")
if not ok then
  vim.notify("telescope not loaded", vim.log.levels.WARN)
  return
end

local actions = require "telescope.actions"

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
    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

    history = {
      path = "~/.local/share/nvim/databases/telescope_history.sqlite3",
      limit = 100,
    },
  },
  pickers = {
    colorscheme = {
      prompt_prefix = " 󰏘 ",
    },
    find_files = {
      prompt_prefix = " 󰈔 ",
      find_command = vim.fn.executable "fd" == 1
          and { "fd", "--strip-cwd-prefix", "--type", "f" }
        or nil,
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
  },
}

pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "file_browser")
