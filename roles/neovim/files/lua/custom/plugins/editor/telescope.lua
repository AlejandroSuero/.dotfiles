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
  config = function()
    require "aome.telescope.setup"
    require "aome.telescope.keys"
  end,
}
