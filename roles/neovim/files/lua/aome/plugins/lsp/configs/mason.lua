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
  ensure_installed = {
    "clangd",
    "clang-format",
    "typescript-language-server",
    "lua-language-server",
    "html-lsp",
    "css-lsp",
    "tailwindcss-language-server",
    "svelte-language-server",
    "graphql-language-service-cli",
    "emmet-ls",
    "prisma-language-server",
    "pyright",
    "gopls",
    "rust-analyzer",
    "astro-language-server",
    "json-lsp",
    "eslint-lsp",
    "marksman",
    "prettier", -- ts/js formatter
    "stylua", -- lua formatter
  },
  automatic_installation = true,
  max_concurrent_installers = 10,
}
