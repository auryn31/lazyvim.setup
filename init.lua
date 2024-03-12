vim.g.mapleader = " "

require("auryn.core")
require("auryn.lazy")

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- rename under curser
vim.keymap.set("n", "<leader>rn", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- trouble keybindings
vim.keymap.set("n", "<leader>tt", function()
	require("trouble").toggle()
end)
