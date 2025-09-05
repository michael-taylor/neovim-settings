--[[ Keymaps ]]
local opts = { silent = true }
local map = vim.keymap.set
vim.g.mapleader = " "                                          -- set SPACE to be leader
map("i", "jj", "<Esc>", opts)                                  -- 'jj' to exit insert mode

-- Motion improvements
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
