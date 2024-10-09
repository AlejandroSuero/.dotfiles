local map_tele = require "aome.telescope.mappings"

-- Dotfiles
map_tele("<leader>en", "edit_neovim", nil, false, "[e]dit [n]eovim files")
map_tele("<leader>eb", "edit_bash", nil, false, "[e]dit [b]ash files")

-- File search
map_tele("<leader>ff", "find_files", nil, false, "[f]ind [f]iles")
map_tele("<leader>fg", "git_files", nil, false, "[f]ind [g]it files")
map_tele("<leader>fd", "diagnostics", nil, false, "[f]ind [d]iagnostics")
map_tele("<leader>fb", "file_browser", nil, false, "[f]ile [b]rowser")
map_tele("<leader>fs", "fs", nil, false, "[f]ile [s]earch")
map_tele("<leader>pv", "project_search", nil, false, "[p]roject [v]iew")
map_tele("<leader>ps", "grep_prompt", nil, false, "[p]roject [s]earch")

-- Misc
map_tele("<leader>cs", "colorscheme", nil, false, "[c]olor[s]chemes")
map_tele("<leader>km", "keymaps", nil, false, "[k]ey[m]aps")
map_tele("<leader>ht", "help_tags", nil, false, "[h]elp [t]ags")
map_tele("<leader>cm", "commands", nil, false, "[c]o[m]mands")
map_tele("<leader>fB", "builtin", nil, false, "[f]ind [B]uiltin Telescope")
map_tele("<leader>ft", "todo", nil, false, "[f]ind [t]odo")
