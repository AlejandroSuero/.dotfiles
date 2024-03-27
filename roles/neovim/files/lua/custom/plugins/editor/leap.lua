return {
  "ggandor/leap.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function(_, _)
    require("leap").add_default_mappings()
  end,
}
