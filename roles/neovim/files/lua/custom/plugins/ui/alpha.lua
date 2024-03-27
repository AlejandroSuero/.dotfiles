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

    ---Adds zero if the number is less than 10
    ---@param number string|integer
    ---@return string number
    local add_zero = function(number)
      if number < 10 then
        return 0 .. number
      end
      return tostring(number)
    end

    local get_date = function()
      local date = os.date "*t"
      local formatted_date = add_zero(date.day)
        .. "-"
        .. add_zero(date.month)
        .. "-"
        .. date.year
        .. " | "
        .. add_zero(date.hour)
        .. ":"
        .. add_zero(date.min)
      return formatted_date
    end

    local header = dashboard.section.header
    local footer = dashboard.section.footer
    local buttons = dashboard.section.buttons

    local plugins = #vim.tbl_keys(require("lazy").plugins())
    local datetime = get_date()
    local info = string.format("  %d plugins  at  %s", plugins, datetime)
    local version = string.format("NVIM Version %s", nvim_version)

    local fortune = require "alpha.fortune"()

    -- Set header
    header.val = {
      "╭────────────────── 青目 ──────────────────╮",
      "│                                          │",
      "│     󰝚 I'm Blue da ba dee da ba daa 󰝚     │",
      "│                                          │",
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
      info,
      version,
    }
    for _, text in pairs(fortune) do
      table.insert(footer.val, text)
    end

    -- Send config to alpha
    alpha.setup(dashboard.opts)

    -- Disable folding on alpha buffer
    vim.cmd [[autocmd FileType alpha setlocal nofoldenable]]
  end,
}
