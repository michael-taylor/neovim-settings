vim.pack.add({
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/kdheepak/lazygit.nvim",
})

require("gitsigns").setup()

-- lazygit.nvim will give us the following keymaps by default:
--    <leader>lg: Open lazygit
require("lazygit")
