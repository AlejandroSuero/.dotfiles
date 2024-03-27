return {
  "nvim-tree/nvim-web-devicons",
  config = function()
    require("nvim-web-devicons").set_icon {
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
    }
  end,
  event = "VeryLazy",
}
