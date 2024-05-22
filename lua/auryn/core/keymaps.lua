vim.keymap.set("n", "x", '"_x')

-- Add keymappings for split views
vim.keymap.set("n", "<leader>sv", "<C-w>v")
vim.keymap.set("n", "<leader>sh", "<C-w>s")
vim.keymap.set("n", "<leader>se", "<C-w>=")
vim.keymap.set("n", "<leader>sx", ":close<CR>")

-- Dismiss Noice Message
vim.keymap.set("n", "<leader>nd", "<cmd>NoiceDismiss<CR>", { desc = "Dismiss Noice Message" })
