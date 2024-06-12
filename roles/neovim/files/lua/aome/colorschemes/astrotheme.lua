return {
  palette = "astrodark", -- String of the default palette to use when calling `:colorscheme astrotheme`
  background = { -- :h background, palettes to use when using the core vim background colors
    light = "astromars",
    dark = "astrodark",
  },

  style = {
    transparent = vim.g.transparency, -- Bool value, toggles transparency.
  },

  plugin_default = "auto", -- Sets how all plugins will be loaded
  -- "auto": Uses lazy / packer enabled plugins to load highlights.
  -- true: Enables all plugins highlights.
  -- false: Disables all plugins.

  plugins = { -- Allows for individual plugin overrides using plugin name and value from above.
    ["bufferline.nvim"] = false,
  },
}
