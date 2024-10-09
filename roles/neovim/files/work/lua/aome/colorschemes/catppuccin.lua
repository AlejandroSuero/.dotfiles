return {
  flavour = "mocha", -- latte, frappe, macchiato, mocha
  background = { -- :h background
    light = "macchiato",
    dark = "mocha",
  },
  transparent_background = vim.g.transparency, -- disables setting the background color.
  term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
  dim_inactive = {
    enabled = true, -- dims the background color of inactive window
    shade = "dark",
    percentage = 0.30, -- percentage of the shade to apply to the inactive window
  },
  styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
    conditionals = {},
  },
  default_integrations = true,
  integrations = {
    cmp = true,
    gitsigns = true,
    nvimtree = true,
    treesitter = true,
    notify = false,
  },
}
