SHOULD_RELOAD_TELESCOPE = true
local reloader = function()
  if SHOULD_RELOAD_TELESCOPE then
    R "plenary"
    R "telescope"
    R "aome.telescope.setup"
  end
end

local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local fb_actions = require "telescope._extensions.file_browser.actions"
local themes = require "telescope.themes"

local replace = require("aome.core.utils").replace_word

local set_prompt_to_entry_value = function(prompt_bufnr)
  local entry = action_state.get_selected_entry()
  if not entry or not type(entry) == "table" then
    return
  end

  action_state.get_current_picker(prompt_bufnr):reset_prompt(entry.ordinal)
end

local M = {}

function M.edit_neovim()
  local opts_with_preview, opts_without_preview

  opts_with_preview = {
    prompt_title = "~ dotfiles ~",
    shorten_path = false,
    cwd = "~/.config/nvim",

    layout_strategy = "flex",
    layout_config = {
      width = 0.9,
      height = 0.8,

      horizontal = {
        width = { padding = 0.15 },
      },
      vertical = {
        preview_height = 0.75,
      },
    },

    mappings = {
      i = {
        ["<C-y>"] = false,
      },
    },

    attach_mappings = function(_, map)
      map("i", "<c-y>", set_prompt_to_entry_value)
      map("i", "<M-c>", function(prompt_bufnr)
        actions.close(prompt_bufnr)
        vim.schedule(function()
          require("telescope.builtin").find_files(opts_without_preview)
        end)
      end)

      return true
    end,
  }

  opts_without_preview = vim.deepcopy(opts_with_preview)
  opts_without_preview.previewer = false

  require("telescope.builtin").find_files(opts_with_preview)
end

function M.edit_bash()
  require("telescope.builtin").find_files {
    shorten_path = false,
    cwd = "~/.config/bash/",
    prompt = "~ dotfiles ~",
    hidden = true,

    layout_strategy = "horizontal",
    layout_config = {
      preview_width = 0.55,
    },
  }
end

function M.find_files()
  require("telescope.builtin").find_files {
    initial_mode = "insert",
    layout_config = {
      height = vim.o.lines - 20,
    },
  }
end

function M.fs()
  local opts = themes.get_ivy {
    cwd = vim.fn.expand "%:h",
    hidden = true,
    sorting_strategy = "ascending",
  }
  require("telescope.builtin").find_files(opts)
end

function M.builtin()
  require("telescope.builtin").builtin()
end

function M.git_files()
  local opts = themes.get_dropdown {
    winblend = 0,
    previewer = false,
    shorten_path = false,
    initial_mode = "insert",

    layout_config = {
      width = 0.8,
    },
  }

  require("telescope.builtin").git_files(opts)
end

function M.colorscheme()
  local opts = {
    enable_preview = true,
    initial_mode = "insert",
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
  }
  require("telescope.builtin").colorscheme(opts)
end

function M.buffer_git_files()
  require("telescope.builtin").git_files(themes.get_dropdown {
    cwd = vim.fn.expand "%:p:h",
    winblend = 0,
    border = true,
    previewer = false,
    shorten_path = false,
  })
end

function M.lsp_code_actions()
  local opts = themes.get_dropdown {
    winblend = 0,
    border = true,
    previewer = false,
    shorten_path = false,
    initial_mode = "insert",
  }

  require("telescope.builtin").lsp_code_actions(opts)
end

function M.live_grep()
  require("telescope.builtin").live_grep {
    previewer = false,
    fzf_separator = "|>",
    initial_mode = "insert",
  }
end

function M.grep_prompt()
  require("telescope.builtin").grep_string {
    path_display = { "shorten" },
    search = vim.fn.input "Grep String > ",
  }
end

function M.grep_open_files(opts)
  opts = opts or {}
  opts.grep_open_files = true
  opts.path_display = { "shorten" }
  opts.prompt_title = "Live Grep in Open Files"

  require("telescope.builtin").live_grep(opts)
end

function M.oldfiles()
  require("telescope").extensions.frecency.frecency(themes.get_ivy {})
end

function M.my_plugins()
  require("telescope.builtin").find_files {
    cwd = "~/dev/nvim_plugins/",
  }
end

function M.installed_plugins()
  require("telescope.builtin").find_files {
    cwd = vim.fn.stdpath "data" .. "/lazy/",
  }
end

function M.project_search()
  require("telescope.builtin").find_files {
    previewer = false,
    layout_strategy = "vertical",
    cwd = require("lspconfig.util").root_pattern ".git"(vim.fn.expand "%:p"),
  }
end

function M.buffers()
  require("telescope.builtin").buffers {
    shorten_path = false,
  }
end

function M.curbuf()
  local opts = themes.get_dropdown {
    winblend = 0,
    border = true,
    previewer = false,
    shorten_path = false,
  }
  require("telescope.builtin").current_buffer_fuzzy_find(opts)
end

function M.help_tags()
  require("telescope.builtin").help_tags {
    show_version = true,
    initial_mode = "insert",
  }
end

function M.search_all_files()
  require("telescope.builtin").find_files {
    find_command = { "rg", "--no-ignore", "--files" },
  }
end

function M.file_browser()
  local opts

  local telescope_buffer_dir = function()
    return vim.fn.expand "%:p:h"
  end

  opts = {
    sorting_strategy = "ascending",
    scroll_strategy = "cycle",
    layout_config = {
      prompt_position = "top",
    },
    path = "%:p:h",
    cwd = telescope_buffer_dir(),
    respect_gitignore = false,
    hidden = true,
    grouped = true,
    previewer = false,

    attach_mappings = function(prompt_bufnr, map)
      local current_picker = action_state.get_current_picker(prompt_bufnr)

      local modify_cwd = function(new_cwd)
        local finder = current_picker.finder

        finder.path = new_cwd
        finder.files = true
        current_picker:refresh(false, { reset_prompt = true })
      end

      map("i", "-", function()
        modify_cwd(current_picker.cwd .. "/..")
      end)

      map("i", "~", function()
        modify_cwd(vim.fn.expand "~")
      end)

      map("n", "yy", function()
        local entry = action_state.get_selected_entry()
        vim.fn.setreg("+", entry.value)
      end)

      map("n", "%", fb_actions.create)
      map("n", "-", fb_actions.goto_parent_dir)

      return true
    end,
  }

  require("telescope").extensions.file_browser.file_browser(opts)
end

function M.git_status()
  local opts = themes.get_dropdown {
    winblend = 0,
    border = true,
    previewer = false,
    shorten_path = false,
  }

  -- Can change the git icons using this.
  opts.git_icons = {
    changed = "M",
  }

  require("telescope.builtin").git_status(opts)
end

function M.git_commits()
  require("telescope.builtin").git_commits {
    winblend = 5,
  }
end

function M.search_only_certain_files()
  require("telescope.builtin").find_files {
    find_command = {
      "rg",
      "--files",
      "--type",
      vim.fn.input "Type: ",
    },
  }
end

function M.lsp_references()
  require("telescope.builtin").lsp_references {
    layout_strategy = "vertical",
    layout_config = {
      prompt_position = "top",
    },
    sorting_strategy = "ascending",
    ignore_filename = false,
  }
end

function M.lsp_implementations()
  require("telescope.builtin").lsp_implementations {
    layout_strategy = "vertical",
    layout_config = {
      prompt_position = "top",
    },
    sorting_strategy = "ascending",
    ignore_filename = false,
  }
end

function M.vim_options()
  require("telescope.builtin").vim_options {
    layout_config = {
      width = 0.5,
    },
    sorting_strategy = "ascending",
  }
end

return setmetatable({}, {
  __index = function(_, k)
    reloader()

    if M[k] then
      return M[k]
    else
      return require("telescope.builtin")[k]
    end
  end,
})
