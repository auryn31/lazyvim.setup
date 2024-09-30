return {
	"windwp/nvim-ts-autotag",
	config = function()
		local opts = {
			enable_close = true, -- Auto close tags
			enable_rename = true, -- Auto rename pairs of tags
			enable_close_on_slash = false, -- Auto close on trailing </
		}
		require("nvim-ts-autotag").setup({
			opts = opts,
		})
	end,
}
