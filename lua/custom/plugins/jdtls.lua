return {
	{
		"neovim/nvim-lspconfig",
		dependencies = { "mfussenegger/nvim-jdtls" },
		opts = {
			setup = {
				jdtls = function(_, opts)
					vim.api.nvim_create_autocmd("FileType", {
						pattern = "java",
						callback = function()
							require("lazyvim.util").on_attach(function(_, buffer)
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

							local config = {
								-- The command that starts the language server
								-- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
								cmd = {

									"java", -- or '/path/to/java17_or_newer/bin/java'
									-- depends on if `java` is in your $PATH env variable and if it points to the right version.

									"-javaagent:/home/jake/.local/share/java/lombok.jar",
									-- '-Xbootclasspath/a:/home/jake/.local/share/java/lombok.jar',
									"-Declipse.application=org.eclipse.jdt.ls.core.id1",
									"-Dosgi.bundles.defaultStartLevel=4",
									"-Declipse.product=org.eclipse.jdt.ls.core.product",
									-- '-noverify',
									"-Xms1g",
									"--add-modules=ALL-SYSTEM",
									"--add-opens",
									"java.base/java.util=ALL-UNNAMED",
									"--add-opens",
									"java.base/java.lang=ALL-UNNAMED",
									"-jar",
									vim.fn.glob(
										"/Users/sagar/.local/share/nvim/lsp_servers/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
									-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
									-- Must point to the                                                     Change this to
									-- eclipse.jdt.ls installation                                           the actual version

									"-configuration",
									"/Users/sagar/.local/share/nvim/lsp_servers/jdtls/config_mac",
									-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
									-- Must point to the                      Change to one of `linux`, `win` or `mac`
									-- eclipse.jdt.ls installation            Depending on your system.

									-- See `data directory configuration` section in the README
								},

								-- This is the default if not provided, you can remove it. Or adjust as needed.
								-- One dedicated LSP server & client will be started per unique root_dir
								root_dir = require("jdtls.setup").find_root({ ".git",
									"mvnw", "gradlew" }),

								-- Here you can configure eclipse.jdt.ls specific settings
								-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
								-- for a list of options
								settings = {
									java = {
										signatureHelp = { enabled = true }
									},
								},
								handlers = {
									["language/status"] = function(_, result)
										-- print(result)
									end,
									["$/progress"] = function(_, result, ctx)
										-- disable progress updates.
									end,
								},
							}
							require("jdtls").start_or_attach(config)
						end,
					})
					return true
				end,
			},
		},
	},
}
