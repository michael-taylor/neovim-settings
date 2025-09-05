vim.pack.add({
  "https://github.com/folke/twilight.nvim",
  "https://github.com/folke/zen-mode.nvim",
})

-- Twilight
require("twilight").setup()

-- ZenMode setup
require("zen-mode").setup({
  plugins = {
    neovide = {
      enabled = true,
      scale = 1.1,
    }
  }
})
