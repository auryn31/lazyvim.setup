return {
	-- null-ls alternative since null-ls is deprecated
	"nvimdev/guard.nvim",
	-- lazy load by ft
	ft = { "lua", "c", "markdown", "python", "typescript", "javascript" },
	-- Builtin configuration, optional
	dependencies = {
		"nvimdev/guard-collection",
	},
}
