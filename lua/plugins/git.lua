vim.pack.add({
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/kdheepak/lazygit.nvim",
})

require("gitsigns").setup()
require("lazygit")
