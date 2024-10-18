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
			{ "<A-.>", "<Cmd>BufferNext<CR>", desc = "buffer next" },
			{ "<A-,>", "<Cmd>BufferPrevious<CR>", desc = "buffer previous" },
			{ "<A-c>", "<Cmd>BufferClose<CR>", desc = "close buffer" },
			{ "<A-p>", "<Cmd>BufferPin<CR>", desc = "pin buffer" },
		},
		opts = {
			-- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
			-- animation = true,
			insert_at_start = true,
			animated = false,
			auto_hide = false,
		},
		version = "^1.9.0", -- optional: only update when a new 1.x version is released
	},
}
