vim.pack.add({
  "https://github.com/folke/flash.nvim",
})

require("flash").setup()
vim.keymap.set("n", "s", function() require("flash").jump() end, { desc = "Flash", noremap = true, silent = true})
