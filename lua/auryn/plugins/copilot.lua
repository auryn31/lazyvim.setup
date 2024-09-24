return {
	"zbirenbaum/copilot.lua",
	enabled = false,
	cmd = "Copilot",
	event = "InsertEnter",
	build = ":Copilot auth",
	opts = {
		suggestion = { enabled = false },
		panel = { enabled = false },
	},
}
