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
local auto_select = true

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
  preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None,
  mapping = cmp.mapping.preset.insert({
    ["<C-space>"] = cmp.mapping.complete(),
    ["<tab>"] = cmp.mapping.confirm({ select = true }),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-c>"] = cmp.mapping.scroll_docs(4),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
  }, {
    { name = "buffer" },
  })
})
local capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

luasnip.config.setup({ history = true })
