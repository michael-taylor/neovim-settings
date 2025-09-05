vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
  "https://github.com/nvim-treesitter/nvim-treesitter-context",
})

local augroup = vim.api.nvim_create_augroup("michaeltaylor.cfg", { clear = false })
local autocmd = vim.api.nvim_create_autocmd
local ts_ensure_installed = {
  "bash",
  "c",
  "c_sharp",
  "cmake",
  "cpp",
  "diff",
  "editorconfig",
  "html",
  "javascript",
  "jsdoc",
  "json",
  "jsonc",
--  "kotlin",
  "lua",
  "luap",
  "markdown",
  "markdown_inline",
  "printf",
  "python",
  "query",
  "regex",
  "toml",
  "tsx",
  "typescript",
  "vim",
  "vimdoc",
  "xml",
  "yaml",
}
require("nvim-treesitter").setup({
  ensure_installed = ts_ensure_installed,
})
autocmd("PackChanged", { -- update treesitter parsers/queries with plugin updates
  group = augroup,
  callback = function(ev)
    local spec = ev.data.spec
    if spec and spec.name == "nvim-treesitter" and ev.data.kind == "update" then
      vim.schedule(function()
        nts.update()
      end)
    end
  end,
})

autocmd("FileType", { -- enable treesitter highlighting and indents
  group = augroup,
  callback = function(ev)
    local filetype = ev.match
    local lang = vim.treesitter.language.get_lang(filetype)
    if vim.treesitter.language.add(lang) then
      if vim.treesitter.query.get(filetype, "indents") then
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end
      if vim.treesitter.query.get(filetype, "folds") then
        vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      end
      vim.treesitter.start()
    end
  end,
})
