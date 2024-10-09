local select_opts = { "Commit", "Pull", "Push", "Push -u", "Fetch" }
local advanced_opts = {
  prompt = "Vim-Fugitive options",
  format_item = function(item)
    if item == "Push -u" then
      return item .. " origin <branch> eg. (origin main)"
    end
    return item
  end,
}
local callback = function(choice)
  if choice == nil then
    vim.notify("No choice selected", vim.log.levels.WARN)
    return
  end
  if choice == "Push -u" then
    vim.ui.input(
      { prompt = "Branch to push from: empty = main" },
      function(input)
        if input == nil then
          vim.notify("No input", vim.log.levels.WARN)
          return nil
        end
        if input == "" then
          vim.notify("No input, using default (main)", vim.log.levels.WARN)
          vim.cmd "Git push origin main"
        else
          vim.cmd "Git push"
        end
      end
    )
  elseif choice == "Fetch" then
    vim.cmd "Git fetch --all -p"
  else
    vim.cmd("Git " .. choice:lower())
  end
end

local fugitive_select = function()
  vim.ui.select(select_opts, advanced_opts, callback)
end

local opts = { noremap = true, silent = true, buffer = 0 }
local mappings = {
  n = {
    ["<leader>go"] = {
      fugitive_select,
      "[Fugitive] Git options",
    },
    ["<leader>gaa"] = {
      "<cmd>Git add .<CR>",
      "[Fugitive] Git add .",
    },
    ["<leader>gaA"] = {
      "<cmd>Git add .<CR>",
      "[Fugitive] Git add -A",
    },
    ["<leader>gai"] = {
      function()
        vim.ui.input(
          { prompt = "Git add: write down the files to add" },
          function(input)
            if input == nil then
              vim.notify("No input", vim.log.levels.WARN)
              return nil
            end
            if input == "" then
              vim.notify(
                "No input, using default (git add -A)",
                vim.log.levels.WARN
              )
              vim.cmd "Git add -A"
            else
              vim.cmd("Git add " .. input)
            end
          end
        )
      end,
      "[Fugitive] Git add input",
    },
  },
}

require("aome.core.utils").map_keys(mappings, opts)
