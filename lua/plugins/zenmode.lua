vim.pack.add({
  "https://github.com/folke/twilight.nvim",
  "https://github.com/folke/zen-mode.nvim",
})

-- Twilight
require("twilight").setup()
vim.keymap.set("n", "<leader>q", "<cmd>Twilight<CR>", { desc = "Twilight mode", noremap = true, silent = true })

-- ZenMode setup
require("zen-mode").setup({
  plugins = {
    neovide = {
      enabled = true,
    }
  }
})
vim.keymap.set("n", "<leader>z", function() require("zen-mode").toggle() end, { desc = "Zen mode", noremap = true, silent = true })
