function nnoremap(rhs, lhs, bufopts, desc)
	bufopts.desc = desc
	vim.keymap.set("n", rhs, lhs, bufopts)
end
-- The on_attach function is used to set key maps after the language server
-- attaches to the current buffer
local on_attach = function(client, bufnr)
	-- Regular Neovim LSP client keymappings
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	nnoremap("gD", vim.lsp.buf.declaration, bufopts, "Go to declaration")
	nnoremap("gd", vim.lsp.buf.definition, bufopts, "Go to definition")
	nnoremap("gi", vim.lsp.buf.implementation, bufopts, "Go to implementation")
	nnoremap("K", vim.lsp.buf.hover, bufopts, "Hover text")
	nnoremap("<C-k>", vim.lsp.buf.signature_help, bufopts, "Show signature")
	nnoremap("<space>wa", vim.lsp.buf.add_workspace_folder, bufopts, "Add workspace folder")
	nnoremap("<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts, "Remove workspace folder")
	nnoremap("<space>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts, "List workspace folders")
	nnoremap("<space>D", vim.lsp.buf.type_definition, bufopts, "Go to type definition")
	nnoremap("<space>rn", vim.lsp.buf.rename, bufopts, "Rename")
	nnoremap("<space>ca", vim.lsp.buf.code_action, bufopts, "Code actions")
	vim.keymap.set(
		"v",
		"<space>ca",
		"<ESC><CMD>lua vim.lsp.buf.range_code_action()<CR>",
		{ noremap = true, silent = true, buffer = bufnr, desc = "Code actions" }
	)
	nnoremap("<space>f", function()
		vim.lsp.buf.format({ async = true })
	end, bufopts, "Format file")

	-- Java extensions provided by jdtls
	nnoremap("<C-o>", jdtls.organize_imports, bufopts, "Organize imports")
	nnoremap("<space>ev", jdtls.extract_variable, bufopts, "Extract variable")
	nnoremap("<space>ec", jdtls.extract_constant, bufopts, "Extract constant")
	vim.keymap.set(
		"v",
		"<space>em",
		[[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]],
		{ noremap = true, silent = true, buffer = bufnr, desc = "Extract method" }
	)
end

return {
	{
		"mfussenegger/nvim-jdtls",
		config = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "java",
				callback = function()
					require("lazyvim.util").lsp.on_attach(function(_, buffer)
						vim.keymap.set(
							"n",
							"<leader>di",
							"<Cmd>lua require'jdtls'.organize_imports()<CR>",
							{ buffer = buffer, desc = "Organize Imports" }
						)
						vim.keymap.set(
							"n",
							"<leader>dt",
							"<Cmd>lua require'jdtls'.test_class()<CR>",
							{ buffer = buffer, desc = "Test Class" }
						)
						vim.keymap.set(
							"n",
							"<leader>dn",
							"<Cmd>lua require'jdtls'.test_nearest_method()<CR>",
							{ buffer = buffer, desc = "Test Nearest Method" }
						)
						vim.keymap.set(
							"v",
							"<leader>de",
							"<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>",
							{ buffer = buffer, desc = "Extract Variable" }
						)
						vim.keymap.set(
							"n",
							"<leader>de",
							"<Cmd>lua require('jdtls').extract_variable()<CR>",
							{ buffer = buffer, desc = "Extract Variable" }
						)
						vim.keymap.set(
							"v",
							"<leader>dm",
							"<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>",
							{ buffer = buffer, desc = "Extract Method" }
						)
						vim.keymap.set(
							"n",
							"<leader>cf",
							"<cmd>lua vim.lsp.buf.formatting()<CR>",
							{ buffer = buffer, desc = "Format" }
						)
					end)

					local capabilities = vim.lsp.protocol.make_client_capabilities()
					capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

					local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
					-- vim.lsp.set_log_level('DEBUG')
					local workspace_dir = "/Users/auryn_engel/.workspace/" .. project_name -- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
					local config = {
						-- The command that starts the language server
						-- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
						cmd = {

							"java", -- or '/path/to/java17_or_newer/bin/java'
							-- depends on if `java` is in your $PATH env variable and if it points to the right version.

							"-javaagent:/Users/auryn_engel/.local/share/java/lombok.jar",
							"-Xbootclasspath/a:/Users/auryn_engel/.local/share/java/lombok.jar",
							"-Declipse.application=org.eclipse.jdt.ls.core.id1",
							"-Dosgi.bundles.defaultStartLevel=4",
							"-Declipse.product=org.eclipse.jdt.ls.core.product",
							"-Dlog.protocol=true",
							"-Dlog.level=ALL",
							-- '-noverify',
							"-Xms1g",
							"--add-modules=ALL-SYSTEM",
							"--add-opens",
							"java.base/java.util=ALL-UNNAMED",
							"--add-opens",
							"java.base/java.lang=ALL-UNNAMED",
							"-jar",
							vim.fn.glob(
								"/Users/auryn_engel/.local/share/java/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar"
							),
							--- https://download.eclipse.org/jdtls/milestones/1.9.0/
							-- Must point to the
							-- eclipse.jdt.ls installation

							"-configuration",
							"/Users/auryn_engel/.local/share/java/jdtls/config_mac",
							-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
							-- Must point to the                      Change to one of `linux`, `win` or `mac`
							-- eclipse.jdt.ls installation            Depending on your system.

							-- See `data directory configuration` section in the README
							"-data",
							workspace_dir,
						},

						-- This is the default if not provided, you can remove it. Or adjust as needed.
						-- One dedicated LSP server & client will be started per unique root_dir
						root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" }),
						on_attach = on_attach,
						capabilities = capabilities,

						-- Here you can configure eclipse.jdt.ls specific settings
						-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
						-- for a list of options
						settings = {
							java = {
								maven = {
									downloadSources = true,
									downloadJavadocs = true,
								},
								implemetnationsCodeLens = {
									enabled = true,
								},
								referencesCodeLens = {
									enabled = true,
								},
								format = {
									settings = {
										url = "/Users/auryn_engel/.local/share/java/eclipse-java-google-style.xml",
										profile = "GoogleStyle",
									},
								},
							},
						},
					}
					require("jdtls").start_or_attach(config)
				end,
			})
		end,
	},
}
