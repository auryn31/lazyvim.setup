-- Video with some details:
-- https://www.youtube.com/watch?v=C7juSZsM2Fg&list=WL&index=5&t=1s&ab_channel=AndrewCourter
--
-- In case of error
-- error code 13 failed to start
-- try to delete ~/.cache/jdtls
local home = os.getenv("HOME")
local workspace_path = home .. "/.local/share/nvim/jdtls-workspace/"
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = workspace_path .. project_name

local status, jdtls = pcall(require, "jdtls")
if not status then
	return
end
local extendedClientCapabilities = jdtls.extendedClientCapabilities

local config = {
	cmd = {
		"java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xmx1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
		"-javaagent:" .. home .. "/.local/share/nvim/mason/packages/jdtls/lombok.jar",
		"-jar",
		vim.fn.glob(home .. "/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
		"-configuration",
		home .. "/.local/share/nvim/mason/packages/jdtls/config_mac_arm",
		"-data",
		workspace_dir,
	},
	root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),

	settings = {
		java = {
			signatureHelp = { enabled = true },
			extendedClientCapabilities = extendedClientCapabilities,
			maven = {
				downloadSources = true,
			},
			referencesCodeLens = {
				enabled = true,
			},
			references = {
				includeDecompiledSources = true,
			},
			inlayHints = {
				parameterNames = {
					enabled = "all", -- literals, all, none
				},
			},
			-- format = {
			-- 	enabled = false,
			-- },

			format = {
				settings = {
					url = "/Users/auryn/.local/share/java/intellij-java-google-style.xml",
					profile = "GoogleStyle",
				},
			},
		},
	},

	init_options = {
		bundles = {
			"/Users/auryn/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-0.53.0.jar",
		},
	},
}

config["on_attach"] = function(_, _)
	require("jdtls").setup_dap({ hotcodereplace = "auto" })
end

require("jdtls").start_or_attach(config)

vim.keymap.set("n", "<leader>co", "<Cmd>lua require'jdtls'.organize_imports()<CR>", { desc = "Organize Imports" })
-- vim.keymap.set("n", "<leader>crv", "<Cmd>lua require('jdtls').extract_variable()<CR>", { desc = "Extract Variable" })
vim.keymap.set(
	"v",
	"<leader>crv",
	"<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>",
	{ desc = "Extract Variable" }
)
vim.keymap.set("n", "<leader>crc", "<Cmd>lua require('jdtls').extract_constant()<CR>", { desc = "Extract Constant" })
vim.keymap.set(
	"v",
	"<leader>crc",
	"<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>",
	{ desc = "Extract Constant" }
)
vim.keymap.set(
	"v",
	"<leader>crm",
	"<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>",
	{ desc = "Extract Method" }
)

local function attach_to_debug()
	local dap = require("dap")
	dap.configurations.java = {
		{
			type = "java",
			request = "attach",
			name = "Attach to Remote JVM",
			hostName = "localhost",
			port = "5005",
		},
	}
	dap.continue()
end

vim.keymap.set("n", "<leader>da", "<Cmd>lua attach_to_debug()<CR>", { desc = "Attach to Debug" })
vim.keymap.set("n", "<leader>dc", '<Cmd>lua require"dap".continue()<CR>', { desc = "Debugger Continue" })
vim.keymap.set("n", "<leader>ds", '<Cmd>lua require"dap".step_over()<CR>', { desc = "Debugger Step Over" })
vim.keymap.set("n", "<leader>di", '<Cmd>lua require"dap".step_into()<CR>', { desc = "Debugger Step Into" })
vim.keymap.set("n", "<leader>do", '<Cmd>lua require"dap".step_out()<CR>', { desc = "Debugger Step Out" })
vim.keymap.set(
	"n",
	"<leader>db",
	'<Cmd>lua require"dap".toggle_breakpoint()<CR>',
	{ desc = "Debugger Toggle Breakpoint" }
)

-- TODO: cofigure -> https://github.com/Nawy/nvim-config-examples/blob/main/dap-java/init.lua
--
local function get_test_runner(test_name, debug)
	if debug then
		return "mvn test -Dmaven.surefire.debug -Dtest=" .. test_name
	else
		return "mvn test -Dtest=" .. test_name
	end
end

local function run_java_test_method(debug)
	local utils = require("auryn.plugins.dap-java.utils")
	local method_name = utils.get_current_full_method_name("\\#")
	vim.cmd("term " .. get_test_runner(method_name, debug))
end

local function run_java_test_class(debug)
	-- require local folder dap-java and then the utils file
	local utils = require("auryn.plugins.dap-java.utils")
	local class_name = utils.get_current_full_class_name()
	vim.cmd("term " .. get_test_runner(class_name, debug))
end

vim.keymap.set("n", "<leader>tm", function()
	run_java_test_method()
end)
vim.keymap.set("n", "<leader>TM", function()
	run_java_test_method(true)
end)
vim.keymap.set("n", "<leader>tc", function()
	run_java_test_class()
end)
vim.keymap.set("n", "<leader>TC", function()
	run_java_test_class(true)
end)
