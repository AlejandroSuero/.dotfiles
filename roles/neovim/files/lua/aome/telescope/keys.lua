local map_tele = require "aome.telescope.mappings"

-- Dotfiles
map_tele("<leader>en", "edit_neovim")
map_tele("<leader>eb", "edit_bash")

-- File search
map_tele("<leader>ff", "find_files")
map_tele("<leader>fg", "git_files")
map_tele("<leader>fd", "diagnostics")
map_tele("<leader>fb", "file_browser")
map_tele("<leader>fs", "fs")
map_tele("<leader>pv", "project_search")
map_tele("<leader>ps", "grep_prompt")

-- Misc
map_tele("<leader>cs", "colorscheme")
map_tele("<leader>km", "keymaps")
map_tele("<leader>ht", "help_tags")
map_tele("<leader>cm", "commands")
map_tele("<leader>fB", "builtin")
