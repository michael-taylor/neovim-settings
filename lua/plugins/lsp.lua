-- Plugins: nvim-lspconfig and mason
vim.pack.add({
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/mason-org/mason-lspconfig.nvim",
})

-- Add the same capabilities to ALL server configurations.
-- Refer to :h vim.lsp.config() for more information.
vim.lsp.config("*", {
  capabilities = vim.lsp.protocol.make_client_capabilities()
})

require("mason").setup()
require("mason-lspconfig").setup {
  ensure_installed = { 
    "astro",
    "clangd",
    "cmake",
    "csharp_ls",
    "lua_ls",
    "omnisharp",
    "pyright",
    "ruff",
  }
}
