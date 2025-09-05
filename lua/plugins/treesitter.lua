-- Plugins: nvim-treesitter and helpers
vim.pack.add({
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/nvim-treesitter/nvim-treesitter-context",
  "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
})

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
local augroup = vim.api.nvim_create_augroup("michaeltaylor.cfg", { clear = false })
local autocmd = vim.api.nvim_create_autocmd

require("nvim-treesitter.configs").setup({
  auto_install = true,
  ensure_installed = ts_ensure_installed,
  highlight = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = { -- in VISUAL mode
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
        ["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
      },
      include_surrounding_whitespace = true,
    },
    move = { -- in NORMAL mode
      enable = true,
      goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
      goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
      goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
      goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
    },
  },
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
