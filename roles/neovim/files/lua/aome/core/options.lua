local env = vim.env

local options = {
  opt = { -- opt scope
    guicursor = "",
    guifont = "*",

    shada = { "'10", "<0", "s10", "h" },

    spell = false,
    spelllang = "en_gb",

    background = "dark",

    cmdheight = 1,

    shell = env.SHELL,

    number = true,
    relativenumber = true,

    tabstop = 2,
    softtabstop = 2,
    shiftwidth = 2,
    expandtab = true,

    smartindent = true,
    autoindent = true,

    wrap = false,

    swapfile = false,
    backup = false,
    undodir = os.getenv "HOME" .. "/.vim/undodir",
    undofile = true,

    hlsearch = false,
    incsearch = true,

    termguicolors = true,

    scrolloff = 13,
    signcolumn = "yes",

    winblend = 0,

    updatetime = 250,
    timeoutlen = 500,
    ttimeoutlen = 500,

    splitright = true,
    splitbelow = true,

    colorcolumn = "80",
    showmode = false,
    cursorline = true,

    listchars = {
      trail = " ",
    },

    fillchars = {
      eob = " ",
    },
  },
  g = { -- global scope
    loaded_gzip = 1,
    loaded_zip = 1,
    loaded_zipPlugin = 1,
    loaded_tar = 1,
    loaded_tarPlugin = 1,

    loaded_getscript = 1,
    loaded_getscriptPlugin = 1,
    loaded_vimball = 1,
    loaded_vimballPlugin = 1,
    loaded_2html_plugin = 1,

    loaded_matchit = 1,
    loaded_matchparen = 1,
    loaded_logiPat = 1,
    loaded_rrhelper = 1,

    netrw_banner = false,
    netrw_browse_split = 0,
    netrw_winsize = 25,
    netrw_list_hide = "node_modules",
    -- List style
    -- -> 0 = thin listing (default)
    -- -> 1 = long listing
    -- -> 3 = tree listing
    netrw_liststyle = vim.g.aome_netrw_list,

    mapleader = " ",
    maplocalleader = ",",
  },
}

local set_options = function(options_table)
  for scope, opts in pairs(options_table) do
    for opt, value in pairs(opts) do
      vim[scope][opt] = value
    end
  end
end

set_options(options)

vim.opt.isfname:append "@-@"

-- Remove the 'o' option from formatoptions for all buffers
vim.api.nvim_create_autocmd({ "BufEnter", "VimEnter" }, {
  group = vim.api.nvim_create_augroup("aome-open-file", {}),
  pattern = "*",
  callback = function()
    vim.opt.formatoptions:remove "o"
    vim.opt_local.formatoptions:remove "o"
    vim.opt_global.formatoptions:remove "o"
  end,
})

-- add binaries installed by mason.nvim to path
local is_windows = vim.loop.os_uname().version:match "Windows"
local sep = is_windows and "\\" or "/"
vim.env.PATH = vim.env.PATH
  .. (is_windows and ";" or ":")
  .. vim.fn.stdpath "data"
  .. table.concat({ "mason", "bin" }, sep)
