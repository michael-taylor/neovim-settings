-- Plugins: nvim-cmp, LuaSnip, and helpers
vim.pack.add({
  "https://github.com/hrsh7th/nvim-cmp",
  "https://github.com/L3MON4D3/LuaSnip",
  "https://github.com/saadparwaiz1/cmp_luasnip",
  "https://github.com/hrsh7th/cmp-nvim-lsp",
})

local cmp = require("cmp")
local types = require("cmp.types")
local luasnip = require("luasnip")

cmp.setup({
  performance = {
    debounce = 0,
    throttle = 0,
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-space>"] = function()
      if cmp.visible() then
        cmp.abort()
      else
        cmp.complete()
      end
    end,
    ["<CR>"] = cmp.mapping.confirm({ select = true })
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
  }, {
    { name = "buffer" },
  })
})
local capabilities = require('cmp_nvim_lsp').default_capabilities()

luasnip.config.setup({ history = true })
