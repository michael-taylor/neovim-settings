vim.pack.add({
  "https://github.com/folke/tokyonight.nvim",
})

require("tokyonight").setup({
  opts = { style = "night" },
})
vim.cmd([[colorscheme tokyonight-night]])
