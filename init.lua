--[[
  A configuration for Neovim that uses Neovim's native plugin management (v0.12+). Only plugins 
  that offer a lot of convience with little overhead will be included.

  Required system utilities:

  * bat
  * curl
  * fd
  * fzf
  * git
  * rg
  * tar
  * unzip
--]]

--[[ Standard Vim options ]]
local o = vim.opt
o.tabstop = 4                      -- Tab sizing and don't replace TABs with spaces
o.shiftwidth = 4
o.softtabstop = 4
o.expandtab = false
o.autoindent = true                -- Keep current indent
o.smartindent = true               -- Indent based on syntax
o.wrap = false                     -- Don't wrap lines normally, override per-file-type below
o.colorcolumn = "100"              -- Set a margin at 100 characters
o.ignorecase = true                -- Ignore case when searching
o.smartcase = true                 -- Don't ignore case if capitals are used
o.number = true                    -- Show line numbers and number relatively
o.relativenumber = true
o.cursorline = true                -- Highlight the current line
o.wildmode = "longest,list,full"   -- Tab completion for commands
o.wildmenu = true
o.backspace = "indent,eol,start"   -- Allow backspacing through indents and EOLs
o.incsearch = true                 -- Highlight results as searching
o.scrolloff = 8                    -- Always have at least 8 characters above/below cursor
o.signcolumn = "yes"               -- Always show signcolumn
o.list = true                      -- Show whitespace
o.winborder = "rounded"            -- Show rounded borders on popup windows
vim.g.editorconfig = true          -- Support Editorconfig

-- Use Powershell instead of CMD on windows
if vim.fn.has('win32') then
  o.shell = "powershell.exe -NoLogo"
  o.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command "
  o.shellquote = ""
  o.shellpipe = "| Out-File -Encoding UTF8 %s"
  o.shellredir = "| Out-File -Encoding UTF8 %s"
end

--[[ GUI ]]
o.termguicolors = true
o.guifont = "JetBrainsMonoNL Nerd Font Mono:h12"

--[[ Keymaps ]]
local opts = { silent = true }
local map = vim.keymap.set
vim.g.mapleader = " "                                          -- set SPACE to be leader
map("i", "jj", "<Esc>", opts)                                  -- 'jj' to exit insert mode

-- Motions
map("v", "J", ":m '>+1<CR>gv=gv", opts)                        -- move highlighted lines down
map("v", "K", ":m '<-2<CR>gv=gv", opts)                        -- move highlighted lines up
map("n", "J", "mzJ`z", opts)                                   -- stay in place when combining lines
map("v", "<", "<gv", opts)                                     -- no need to reselect when indenting
map("v", ">", ">gv", opts)                                     -- no need to reselect when unindenting
map("n", "<C-d>", "<C-d>zz", opts)                             -- leave scrolloff area when half-page jumping
map("n", "<C-u>", "<C-u>zz", opts)                             -- "
map("n", "n", "nzzzv", opts)                                   -- leave scrolloff area when searching
map("n", "N", "Nzzzv", opts)                                   -- "
map("n", "Q", "<nop>", opts)                                   -- effectivly disable Ex mode
map("i", "<C-c>", "<Esc>", opts)                               -- easier escaping
map("n", "<C-c>", ":nohl<CR>", opts)                           -- Ctrl-c to remove highlighting

-- Conviences (uses leader)
map("n", "<leader>x", vim.cmd.Ex, opts)                        -- eXplorer, show file explorer
map("x", "<leader>p", "\"_dP", opts)                           -- Paste, replace highlight while preserving current yanked text
map("n", "<leader>y", "\"+y", opts)                            -- Yank, into the system clipboard
                                                               -- Sed, replace current word
map("n", "<leader>S", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], opts)
map("n", "<leader>X", "<cmd>!chmod +x %<CR>", opts)            -- eXecutable, make the current file executable
map("n", "<leader>F", vim.lsp.buf.format, opts)                -- Format, format buffer
map("n", "<leader>lg", "<cmd>LazyGit<CR>", opts)               -- LazyGit, open LazyGit

--[[ File-type specific options ]]
local augroup = vim.api.nvim_create_augroup("mtaylor.cfg", { clear = true })
local autocmd = vim.api.nvim_create_autocmd

--[[ Plugins ]]
vim.pack.add({
  "https://github.com/folke/tokyonight.nvim",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/mason-org/mason-lspconfig.nvim",
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
  "https://github.com/nvim-treesitter/nvim-treesitter-context",
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-mini/mini.icons",
  "https://github.com/nvim-mini/mini.pairs",
  "https://github.com/nvim-mini/mini.surround",
  "https://github.com/nvim-lualine/lualine.nvim",
  "https://github.com/folke/flash.nvim",
  "https://github.com/hrsh7th/nvim-cmp",
  "https://github.com/hrsh7th/cmp-nvim-lsp",
  "https://github.com/ibhagwan/fzf-lua",
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/kdheepak/lazygit.nvim",
})

-- Tokyonight setup
require("tokyonight").setup({
  opts = { style = "night" },
})
vim.cmd([[colorscheme tokyonight-night]])

-- LSP setup
-- Add the same capabilities to ALL server configurations.
-- Refer to :h vim.lsp.config() for more information.
vim.lsp.config("*", {
  capabilities = vim.lsp.protocol.make_client_capabilities()
})

-- Mason setup
require("mason").setup()
require("mason-lspconfig").setup {
  ensure_installed = { 
    "astro",
    "clangd",
    "cmake",
    "csharp_ls",
    "lua_ls",
    "omnisharp",
    "pyright",
    "ruff",
  }
}

-- Treesitter setup
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

-- Mini setup
require("mini.icons").setup()
require("mini.pairs").setup()

-- mini.surround will give us the following keymaps by default:
--    sa: Add surrounding
--    sd: Delete surrounding
--    sf: Find surrounding
--    sF: Find surrounding to the left
--    sh: Highlight surrounding
--    sr: Replace surrounding
require("mini.surround").setup()

-- Lualine setup
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

-- flash.nvim setup
require("flash").setup()
map("n", "s", function() require("flash").jump() end, { desc = "Flash", noremap = true, silent = true})

-- nvim-cmp setup
local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args)
      -- luasnip.lsp_expand(args.body)
      vim.snippet.expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({ select = true })
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    -- { name = "luasnip" },
  }, {
    { name = "buffer" },
  })
})
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- fzf setup
local fzf = require("fzf-lua")
map("n", "<leader>ff", fzf.files, { desc = "fzf files", noremap = true, silent = true })
map("n", "<leader>fs", fzf.lsp_document_symbols, { desc = "fzf symbols", noremap = true, silent = true })
map("n", "<leader>fb", fzf.buffers, { desc = "fzf buffers", noremap = true, silent = true })
map("n", "<leader>fg", fzf.live_grep, { desc = "fzf grep", noremap = true, silent = true })
map("n", "<leader>fj", fzf.jumps, { desc = "fzf jumplist", noremap = true, silent = true })
map("n", "<leader>fm", fzf.marks, { desc = "fzf marks", noremap = true, silent = true })
fzf.setup({ "max-perf" })

-- Git signs
require("gitsigns").setup()

-- Lazygit
-- lazygit.nvim will give us the following keymaps by default:
--    <leader>lg: Open lazygit
require("lazygit")
