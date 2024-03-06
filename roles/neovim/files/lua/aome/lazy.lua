local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

local opts = {
  install = {
    colorscheme = { vim.g.colorscheme },
  },
  checker = {
    enable = true,
  },
  change_detection = {
    notify = false,
  },
  defaults = {
    lazy = true,
    version = false,
  },
  ui = {
    icons = {
      ft = "",
      lazy = "󰂠",
      loaded = "",
      not_loaded = "",
    },
  },
  performance = {
    rtp = {
      chache = {
        enabled = true,
      },
      disabled_plugins = {
        "gzip",
        "rplugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
      notify = false,
    },
  },
}

local ok, lazy = pcall(require, "lazy")
if not ok then
  vim.notify("Lazy not loaded", 3)
  return
end
lazy.setup({
  -- { import = "aome.plugins" },
  { import = "aome.plugins.ui" },
  { import = "aome.plugins.lsp" },
  { import = "aome.plugins.editor" },
}, opts)
