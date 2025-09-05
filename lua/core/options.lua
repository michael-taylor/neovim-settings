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
o.showmode = false                 -- Hide the mode line
vim.g.editorconfig = true          -- Support Editorconfig
vim.g.netrw_keepdir = true         -- Keep netrw dir synced with current dir
vim.g.netrw_banner = false         -- Hide netrw banner
                                   -- Hide hidden files by default in netrw
vim.g.netrw_list_hide = [[\(^\|\s\s\)\zs\.\S\+]]

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

vim.diagnostic.config({
  float = { border = "rounded" },
})
