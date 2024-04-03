return {
  "nvim-tree/nvim-web-devicons",
  config = function()
    local web_devicons = require "nvim-web-devicons"

    web_devicons.set_icon {
      gql = {
        icon = "",
        color = "#e535ab",
        cterm_color = "199",
        name = "GraphQL",
      },
      toml = {
        icon = "󰰥",
        color = "#4e94ce",
        name = "TOML",
      },
      http = {
        icon = "󰖟",
        color = "#4e94ce",
        name = "HTTP",
      },
      astro = {
        icon = "",
        color = "#e77751",
        name = "Astro",
      },
      yaml = {
        icon = "󰬠",
        color = "#e77751",
        name = "Yaml",
      },
      yml = {
        icon = "󰬠",
        color = "#e77751",
        name = "Yml",
      },
    }
  end,
  event = "VeryLazy",
}
