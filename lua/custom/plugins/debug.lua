return {
	"mfussenegger/nvim-dap",
	'rcarriga/cmp-dap',
	'theHamsta/nvim-dap-virtual-text',
	'nvim-telescope/telescope-dap.nvim',
	{
		"rcarriga/nvim-dap-ui",
		dependencies = "mfussenegger/nvim-dap",
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			dapui.setup()
			require("nvim-dap-virtual-text").setup({
				all_references = true,
				display_callback = function(variable, buf, stackframe, node, options)
					return ' = ' .. variable.value
				end,
			})
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
			dap.configurations.cpp = {
				-- 	{
				-- 	name = "lldb",
				-- 	type = "executable",
				-- 	request = "launch"
				-- }
			}
			dap.configurations.java = {
				{
					type = "java",
					request = "launch",
					name = "Debug (Launch) - Current File",
					-- cwd = "${workspaceFolder}",
					-- console = "internalConsole",
					mainClass = "${fileBasenameNoExtension}",
					projectName = "${workspaceFolderBasename}",
					args = ""
				}
			}
			local wk = require "which-key"
			wk.register {
				["<leader>db"] = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
				["<leader>dc"] = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
				["<leader>dC"] = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run To Cursor" },
				["<leader>dd"] = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
				["<leader>dgs"] = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
				["<leader>dB"] = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
				["<leader>di"] = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
				["<leader>do"] = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
				["<leader>du"] = { "<cmd>lua require'dap'.step_out()<cr>", "Step up" },
				["<leader>dp"] = { "<cmd>lua require'dap'.pause()<cr>", "Pause" },
				["<leader>dq"] = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
				["<leader>dtr"] = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
				["<leader>dtu"] = { "<cmd>lua require'dapui'.toggle({reset = true})<cr>", "Toggle UI" },
			}
		end
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		event = "VeryLazy",
		dependencies = {
			"williamboman/mason.nvim",
			"mfussenegger/nvim-dap",
		},
		opts = {
			handlers = {}
		},
	},
}
