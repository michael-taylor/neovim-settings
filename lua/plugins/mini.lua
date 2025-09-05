vim.pack.add({
  "https://github.com/nvim-mini/mini.icons",
  "https://github.com/nvim-mini/mini.pairs",
  "https://github.com/nvim-mini/mini.surround",
})

-- mini.surround will give us the following keymaps by default:
--    sa: Add surrounding
--    sd: Delete surrounding
--    sf: Find surrounding
--    sF: Find surrounding to the left
--    sh: Highlight surrounding
--    sr: Replace surrounding
require("mini.icons").setup()
require("mini.pairs").setup()
require("mini.surround").setup()

