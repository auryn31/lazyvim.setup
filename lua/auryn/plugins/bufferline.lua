return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	init = function()
		local bufferline = require("bufferline")
		local config = {
			options = {
				offsets = {
					{
						filetype = "NvimTree",
						text = "File Explorer",
						highlight = "Directory",
						separator = true, -- use a "true" to enable the default, or set your own character
					},
				},
			},
		}
		vim.keymap.set("n", "<leader>.", "<Cmd>BufferLineCycleNext<CR>")
		vim.keymap.set("n", "<leader>,", "<Cmd>BufferLineCyclePrev<CR>")
		vim.keymap.set("n", "<leader>q", "<Cmd>BufferLineCloseOthers<CR>")

		bufferline.setup(config)
	end,
}
