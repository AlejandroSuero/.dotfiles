local M = {}

-- Loads configuration
M.load_config = function()
  local aomerc =
    vim.api.nvim_get_runtime_file("lua/aome/core/aomerc.lua", false)[1]
  if aomerc == nil then
    print "aomerc.lua not found"
    print "creating aomerc.lua"
    local file =
      io.open(vim.fn.stdpath "config" .. "/lua/aome/core/aomerc.lua", "w")
    if file ~= nil then
      file:write "vim.g.transparency = false\n"
      file:write 'vim.g.colorscheme = "rose-pine"\n'
      file:write "vim.g.aome_netrw_list = 0"
      file:close()
      require "aome.core.aomerc"
    else
      vim.notify(
        "A problem occurred when creating aomerc.lua",
        vim.log.levels.ERROR
      )
    end
  else
    require "aome.core.aomerc"
  end
end

--- Map table into insert mode mapping
--@param tbl table { "keys", "command", opts }
M.imap = function(tbl)
  vim.keymap.set("i", tbl[1], tbl[2], tbl[3])
end

--- Map table into normal mode mapping
--@param tbl table { "keys", "command", opts }
M.nmap = function(tbl)
  vim.keymap.set("n", tbl[1], tbl[2], tbl[3])
end

-- Maps keys with options
---@param mappings_table table Table that contains the mappings
---@param mapping_opt table|nil that contains the mapping options
M.map_keys = function(mappings_table, mapping_opt)
  for mode, mappings in pairs(mappings_table) do
    local default_opts =
      vim.tbl_deep_extend("force", { mode = mode }, mapping_opt or {})

    for lhs, mapping_info in pairs(mappings) do
      if type(mapping_info) ~= "table" then
        mapping_info = { mapping_info }
      end
      local opts =
        vim.tbl_deep_extend("force", default_opts, mapping_info.opts or {})

      mapping_info.opts, opts.mode = nil, nil
      opts.desc = mapping_info[2] or "No description added"
      local rhs = mapping_info[1]

      vim.keymap.set(mode, lhs, rhs, opts)
    end
  end
end

--- Replace old colorscheme for the new one
---@param old string Old string you want to change
---@param new string New string you want to change
---@param path_name string|nil Path for the change to apply
M.replace_word = function(old, new, path_name)
  if path_name == nil then
    path_name = "/lua/aome/core/aomerc.lua"
  end
  local options = vim.fn.stdpath "config" .. path_name
  local file = io.open(options, "r")
  local added_pattern = string.gsub(old, "-", "%%-") -- add % before - if exists
  if file == nil then
    vim.notify("Config file not found", vim.log.levels.ERROR)
    return
  end
  local new_content = file:read("*all"):gsub(added_pattern, new)

  file = io.open(options, "w")
  if file then
    file:write(new_content)
    file:close()
  end
end

M.auto = {
  autocmd = function(args)
    local event = args[1]
    local group = args[2]
    local callback = args[3]

    vim.api.nvim_create_autocmd(event, {
      group = group,
      buffer = args[4],
      callback = function()
        callback()
      end,
      once = args.once,
    })
  end,
}

return M
