return {
	{
		"romgrk/barbar.nvim",
		dependencies = {
			"lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
			"nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
		},
		init = function()
			vim.g.barbar_auto_setup = false
		end,
		keys = {
			{ "<C-.>", "<Cmd>BufferNext<CR>", desc = "Toggle pin" },
			{ "<C-,>", "<Cmd>BufferPrevious<CR>", desc = "Toggle pin" },
			{ "<C-/>", "<Cmd>BufferClose<CR>", desc = "Toggle pin" },
		},
		opts = {
			-- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
			-- animation = true,
			insert_at_start = true,
			animated = false,
			auto_hide = false,
			-- …etc.
		},
		version = "^1.0.0", -- optional: only update when a new 1.x version is released
	},
}
