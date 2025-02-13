return {
	"nvim-tree/nvim-tree.lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		-- set termguicolors to enable highlight groups
		vim.opt.termguicolors = true

		vim.g.loaded = 1
		vim.g.loaded_netrwPlugin = 1

		vim.cmd([[ highlight NvimTreeIndentMarker guifg=#3FC5FF ]])
		-- disable netrw at the very start of your init.lua (strongly advised)
		require("nvim-tree").setup({
			renderer = {
				icons = {
					glyphs = {
						folder = {
							arrow_closed = "", -- arrow when folder is closed
							arrow_open = "", -- arrow when folder is open
						},
					},
				},
				group_empty = true,
			},
			update_focused_file = {
				enable = true,
			},
			filters = {
				git_ignored = false,
			},
			git = {
				enable = true,
				timeout = 400,
			},
			view = {
				side = "left",
				width = 50,
			},
		})

		-- local nvim_tree_events = require("nvim-tree.events")
		-- -- local bufferline_api = require("bufferline.api")
		--
		-- local function get_tree_size()
		-- 	return require("nvim-tree.view").View.width
		-- end
		--
		-- nvim_tree_events.subscribe("TreeOpen", function()
		-- 	bufferline_api.set_offset(get_tree_size())
		-- end)
		--
		-- nvim_tree_events.subscribe("Resize", function()
		-- 	-- bufferline_api.set_offset(get_tree_size())
		-- end)
		--
		-- nvim_tree_events.subscribe("TreeClose", function()
		-- 	-- bufferline_api.set_offset(0)
		-- end)

		-- vim.keymap.set("n", "<leader>pv", vim.cmd.NvimTreeOpen)
		vim.keymap.set("n", "<leader>e", vim.cmd.NvimTreeToggle)
	end,
}
