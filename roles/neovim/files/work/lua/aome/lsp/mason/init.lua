return {
  ui = {
    icons = {
      package_pending = "P",
      package_installed = "I",
      package_uninstalled = "U",
    },
  },
  keymaps = {
    toggle_server_expand = "<CR>",
    install_server = "i",
    update_server = "u",
    check_server_version = "c",
    update_all_servers = "U",
    check_outdated_servers = "C",
    uninstall_server = "X",
    cancel_installation = "<C-c>",
  },
  ensure_installed = require "aome.lsp.mason.servers",
  automatic_installation = true,
  max_concurrent_installers = 10,
}
