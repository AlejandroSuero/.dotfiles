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
      templ = {
        icon = "󰅄",
        color = "#00ADD8",
        name = "Templ",
      },
    }
  end,
  event = "VeryLazy",
}
