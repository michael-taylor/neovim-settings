--[[ Keymaps ]]

--[[ Mode changes ]]
mapi("jj", "<Esc>")
mapi("<C-c>", "<Esc>")

--[[ QoL improvements ]]
mapn("Q", "<nop>")                                      -- effectivly disable Ex mode
mapn("<C-c>", ":nohl<CR>")                              -- Ctrl-c to remove highlighting
mapn("<leader>w", function() vim.cmd("silent! w") end)  -- save file
mapn("<leader>q", function() vim.cmd("silent! q!") end) -- quit all (exit if not unsaved files)
mapn("<leader>y", "\"+y")                               -- yank into the system clipboard
mapx("<leader>p", "\"_dP")                              -- paste preserving current yanked text

--[[ Motions ]]
mapn("<C-d>", "<C-d>zz")                                -- leave scrolloff area when half-page jumping
mapn("<C-u>", "<C-u>zz")                                --                   "
mapn("n", "nzzzv")                                      -- leave scrolloff area when searching
mapn("N", "Nzzzv")                                      --                   "
mapn("s", function() require("flash").jump() end)       -- start searching with Flash

--[[ Editing ]]
mapn("J", "mzJ`z")                                      -- stay in place when combining lines
mapn("<leader>S",                                       -- quick replace of all occurences of current word
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- VISUAL mode motions
mapv("J", ":m '>+1<CR>gv=gv")                           -- move highlighted lines down
mapv("K", ":m '<-2<CR>gv=gv")                           -- move highlighted lines up
mapv("<", "<gv")                                        -- no need to reselect when indenting
mapv(">", ">gv")                                        -- no need to reselect when unindenting

--[[ UI navigation ]]
mapn("<C-h>", "<C-w>h")                                 -- go to left window
mapn("<C-l>", "<C-w>l")                                 -- go to right window
mapn("<C-k>", "<C-w>k")                                 -- go to upper window
mapn("<C-j>", "<C-w>j")                                 -- go to lower window
mapn("[t", "<cmd>tabp<cr>")                             -- go to next tab
mapn("]t", "<cmd>tabp<cr>")                             -- go to previous tab

-- Fix for netrw stealing <C-l>
vim.api.nvim_create_autocmd("FileType", {
  pattern = "netrw",
  callback = function()
    vim.api.nvim_buf_set_keymap(0, "n", "<C-l>", "<C-w>l", { silent = true })
  end,
})

--[[ Fuzzy finding <leader>f ]]
local fzf = require("fzf-lua")
mapn("<leader>ff", fzf.files, { desc = "find Files", noremap = true, silent = true })
mapn("<leader>fs", fzf.lsp_document_symbols, 
  { desc = "find Symbols", noremap = true, silent = true })
mapn("<leader>fb", fzf.buffers, { desc = "find Buffers", noremap = true, silent = true })
mapn("<leader>fg", fzf.live_grep, { desc = "live Grep", noremap = true, silent = true })
mapn("<leader>fj", fzf.jumps, { desc = "find Jumps", noremap = true, silent = true })
mapn("<leader>fm", fzf.marks, { desc = "find Marks", noremap = true, silent = true })

--[[ Disk/file operations <leader>d ]]
mapn("<leader>df", "<cmd>Lexplore %:p:h<cr>", 
  { desc = "toggle File explorer", noremap = true, silent = true })
mapn("<leader>dx", "<cmd>!chmod +x %<cr>", 
  { desc = "make current file eXecutable", noremap = true, silent = true })
mapn("<leader>dg", "<cmd>LazyGit<cr>", 
  { desc = "open Git tool", noremap = true, silent = true })

--[[ Coding/LSP operations <leader>c ]]
mapn("<leader>cd", function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, {desc = "toggle Diagnostics", noremap = true, silent = true })
mapn("<leader>ch", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "toggle inlay Hints", noremap = true, silent = true })
mapn("<leader>cf", vim.lsp.buf.format, { desc = "reFormat buffer", noremap = true, silent = true })
mapn("M", vim.diagnostic.open_float, { desc = "open diagnostic overlay", noremap = true, silent = true })
mapn("K", function() vim.lsp.buf.hover({ border = "rounded" }) end, 
  { desc = "show type info", noremap = true, silent = true })

--[[ Extra stuff <leader>x ]]
mapn("<leader>xt", "<cmd>Twilight<CR>", { desc = "Twilight mode", noremap = true, silent = true })
mapn("<leader>xz", function() require("zen-mode").toggle() end, 
  { desc = "Zen mode", noremap = true, silent = true })
