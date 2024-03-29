if not pcall(require, "telescope") then
  return
end

TelescopeMapArgs = TelescopeMapArgs or {}

--- Telescope key mappings
---@param key string Sequence of keys
---@param f string Function from "Telescope" to use
---@param desc string|nil A short description of what the mapping do
---@param options table|nil Options for the telescope function
---@param buffer boolean|nil Buffer to attach to
local map_tele = function(key, f, options, buffer, desc)
  local map_key = vim.api.nvim_replace_termcodes(key .. f, true, true, true)

  if not desc then
    desc = "[Telescope] " .. f
  end

  local map_options = {
    noremap = true,
    silent = true,
    desc = desc,
  }

  TelescopeMapArgs[map_key] = options or {}

  local mode = "n"
  local rhs = string.format(
    "<cmd>lua R('aome.telescope')['%s'](TelescopeMapArgs['%s'])<CR>",
    f,
    map_key
  )

  if not buffer then
    vim.api.nvim_set_keymap(mode, key, rhs, map_options)
  else
    vim.api.nvim_buf_set_keymap(0, mode, key, rhs, map_options)
  end
end

vim.api.nvim_set_keymap(
  "c",
  "<c-r><c-r>",
  "<Plug>(TelescopeFuzzyCommandSearch)",
  { noremap = false, nowait = true }
)

return map_tele
