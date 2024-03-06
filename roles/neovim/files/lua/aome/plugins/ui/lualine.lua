---@diagnostic disable: undefined-doc-name
---Returns the lsp client attach to the workspace
---@return string " lsp_client" Lsp client in the format of " lsp_client"
local show_lsp = function()
  local lsp_client = vim.lsp.get_active_clients()[1].config.name
  if lsp_client == "null-ls" then
    lsp_client = vim.lsp.get_active_clients()[2].config.name
  end
  return string.format("%s %s", " ", lsp_client)
end

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

---Gets the filename and if modified or not
---@param reverse boolean
---@return string filename_and_status - A modified or not status with the filename
local get_filename_and_status = function(reverse)
  local filename = vim.fn.expand "%:t"
  local modified = vim.bo.modified
  local file_status = " "
  if modified then
    file_status = " "
  end

  if reverse == true then
    return string.format("%s %s", file_status, filename)
  else
    return string.format("%s %s", filename, file_status)
  end
end

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = { "BufReadPre", "BufNewFile" },
  lazy = true,
  config = function()
    local lualine = require "lualine"
    local lazy_status = require "lazy.status"

    lualine.setup {
      options = {
        icons_enabled = true,
        theme = "auto",
        section_separators = { left = "", right = "" },
        component_separators = { left = "/", right = "\\" },
        disabled_filetypes = {},
        globalstatus = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = {
          function()
            return get_filename_and_status(false)
          end,
        },
        lualine_x = {
          {
            "diagnostics",
            sources = { "nvim_diagnostic" },
            symbols = {
              error = "",
              warn = "",
              info = "",
              hint = "",
            },
          },
          { lazy_status.updates, cond = lazy_status.has_updates },
          { "encoding" },
          { "filetype" },
        },
        lualine_y = { show_lsp },
        lualine_z = { get_date },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          function()
            return get_filename_and_status(false)
          end,
        },
        lualine_x = { get_date },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      winbar = {
        lualine_z = {
          function()
            return get_filename_and_status(true)
          end,
        },
      },
      extensions = { "fugitive", "quickfix" },
    }
  end,
}
