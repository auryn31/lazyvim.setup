-- find more plugins https://github.com/folke/snacks.nvim/tree/main?tab=readme-ov-file
local M = {
	dimEnabled = false,
}
return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		dim = { enabled = true },
		indent = {
			enabled = true,
			scope = {
				animate = {
					duration = {
						step = 10,
						total = 200, -- maximum duration
					},
				},
			},
		},
		toggle = {
			enabled = true,
		},
	},
	keys = {
		{
			"<leader>zm",
			function()
				if M.dimEnabled then
					Snacks.dim.disable()
					M.dimEnabled = false
				else
					Snacks.dim({ enabled = true })
					M.dimEnabled = true
				end
			end,
			desc = "Toggle dim mode",
		},
	},
}
