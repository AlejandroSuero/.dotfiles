return {
  "ggandor/leap.nvim",
  keys = { "s" },
  config = function(_, _)
    require("leap").add_default_mappings()
  end,
}
