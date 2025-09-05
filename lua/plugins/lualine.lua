vim.pack.add({
  "https://github.com/nvim-lualine/lualine.nvim",
})

require("lualine").setup({
  init = function()
    vim.g.lualine_laststatus = vim.o.laststatus
    if vim.fn.argc(-1) > 0 then
      -- Set an empty statusline til lualine loads
      vim.o.statusline = " "
    else
      -- Hide the statusline on the starter page
      vim.o.laststatus = 0
    end
  end,
})
