vim.pack.add({
  "https://github.com/ibhagwan/fzf-lua",
})

local fzf = require("fzf-lua")
fzf.setup()
fzf.register_ui_select()

vim.keymap.set("n", "<leader>ff", fzf.files, { desc = "fzf files", noremap = true, silent = true })
vim.keymap.set("n", "<leader>fs", fzf.lsp_document_symbols, { desc = "fzf symbols", noremap = true, silent = true })
vim.keymap.set("n", "<leader>fb", fzf.buffers, { desc = "fzf buffers", noremap = true, silent = true })
vim.keymap.set("n", "<leader>fg", fzf.live_grep, { desc = "fzf grep", noremap = true, silent = true })
vim.keymap.set("n", "<leader>fj", fzf.jumps, { desc = "fzf jumplist", noremap = true, silent = true })
vim.keymap.set("n", "<leader>fm", fzf.marks, { desc = "fzf marks", noremap = true, silent = true })
