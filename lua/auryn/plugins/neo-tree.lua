return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("neo-tree").setup({
			default_cmponent_configs = {

				buffers = {
					follow_current_file = {
						enable = true,
					},
				},
			},
		})
		vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<CR>")
	end,
}
