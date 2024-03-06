return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local alpha = require "alpha"
    local dashboard = require "alpha.themes.dashboard"

    local lazy_path = vim.fn.stdpath "config" .. "/lua/aome/lazy.lua"
    local nvim_version = "v"
      .. vim.version().major
      .. "."
      .. vim.version().minor
      .. "."
      .. vim.version().patch

    local header = dashboard.section.header
    local footer = dashboard.section.footer
    local buttons = dashboard.section.buttons

    -- Set header
    header.val = {
      "╭───────────────── 青目 ───────────────────╮",
      "│                                          │",
      "│             ████████████████             │",
      "│       ██████                ██████       │",
      "│     ██      ▓▓▓▓░░░░░░░░    ░░    ██     │",
      "│   ██      ▓▓▓▓▓▓▓▓▓▓▓▓        ░░    ██   │",
      "│   ████      ▓▓▓▓▓▓▓▓▓▓▓▓    ░░    ████   │",
      "│   ██▒▒██████                ██████▒▒██   │",
      "│   ██▒▒▒▒▒▒▒▒████████████████▒▒▒▒▒▒▒▒██   │",
      "│   ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██   │",
      "│   ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██   │",
      "│   ██▒▒▒▒██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██▒▒▒▒▒▒▒▒██   │",
      "│   ██▒▒██  ██▒▒▒▒▒▒▒▒▒▒▒▒██  ██▒▒▒▒▒▒██   │",
      "│   ██▒▒▒▒██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██▒▒▒▒▒▒▒▒██   │",
      "│   ██░░░░▒▒▒▒██▒▒▒▒▒▒▒▒██▒▒▒▒░░░░▒▒▒▒██   │",
      "│   ██▒▒▒▒▒▒▒▒▒▒████████▒▒▒▒▒▒▒▒▒▒▒▒▒▒██   │",
      "│     ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██     │",
      "│       ██████▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██████       │",
      "│             ████████████████             │",
      "│               ┌─┐┌─┐┌┬┐┌─┐               │",
      "╰────────────── ├─┤│ ││││├┤  ──────────────╯",
      "                ┴ ┴└─┘┴ ┴└─┘               ",
    }

    -- Set menu
    buttons.val = {
      dashboard.button("e", "  > New File", ":e "),
      dashboard.button("SPC ee", "  > Toggle file explorer", "<cmd>Ex<CR>"),
      dashboard.button(
        "SPC pf",
        "󰱼  > Find File",
        "<cmd>Telescope find_files<CR>"
      ),
      dashboard.button(
        "SPC ps",
        "  > Find Word",
        "<cmd>Telescope live_grep<CR>"
      ),
      dashboard.button(
        "SPC epp",
        "󱇧  > Edit lazy.lua",
        "<cmd>e " .. lazy_path .. "<CR>"
      ),
      dashboard.button("q", "  > Quit NVIM", "<cmd>qa<CR>"),
    }

    footer.val = {
      " ",
      " ",
      " ",
      "NVIM version " .. nvim_version,
    }

    -- Send config to alpha
    alpha.setup(dashboard.opts)

    -- Disable folding on alpha buffer
    vim.cmd [[autocmd FileType alpha setlocal nofoldenable]]
  end,
}
