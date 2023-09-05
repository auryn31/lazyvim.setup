return {
	"f-person/git-blame.nvim",
	config = function()
		vim.g.gitblame_date_format = "%d.%m.%y %H:%M"
		require("gitblame").setup({
			enabled = true,
		})
	end,
}
