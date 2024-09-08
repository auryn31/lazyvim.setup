return {
	-- YOU ALMOST CERTAINLY WANT A MORE ROBUST nvim-treesitter SETUP
	-- see https://github.com/nvim-treesitter/nvim-treesitter
	"nvim-treesitter/nvim-treesitter",
	opts = {
		auto_install = true,
		indent = {
			enable = true,
		},
		autopairs = {
			enable = true,
		},
		autotag = {
			enable = false,
		},
		endwise = {
			enable = true,
		},
		ensure_installed = {
			"c",
			"lua",
			"vim",
			"vimdoc",
			"query",
			"typescript",
			"elm",
			"javascript",
			"java",
			"json",
			"latex",
			"python",
			"go",
			"eex",
			"elixir",
			"erlang",
			"heex",
		},
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		},
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end,
}
