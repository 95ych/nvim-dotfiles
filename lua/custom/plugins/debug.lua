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
			wk.add
			{
				{ "<leader>dB",  "<cmd>lua require'dap'.step_back()<cr>",              desc = "Step Back" },
				{ "<leader>dC",  "<cmd>lua require'dap'.run_to_cursor()<cr>",          desc = "Run To Cursor" },
				{ "<leader>dN",  "<cmd>lua require'dap'.step_over()<cr>",              desc = "Step Over" },
				{ "<leader>db",  "<cmd>lua require'dap'.toggle_breakpoint()<cr>",      desc = "Toggle Breakpoint" },
				{ "<leader>dd",  "<cmd>lua require'dap'.disconnect()<cr>",             desc = "Disconnect" },
				{ "<leader>dgs", "<cmd>lua require'dap'.session()<cr>",                desc = "Get Session" },
				{ "<leader>dn",  "<cmd>lua require'dap'.step_into()<cr>",              desc = "Step Into" },
				{ "<leader>do",  "<cmd>lua require'dap'.step_out()<cr>",               desc = "Step up" },
				{ "<leader>dp",  "<cmd>lua require'dap'.pause()<cr>",                  desc = "Pause" },
				{ "<leader>dq",  "<cmd>lua require'dap'.close()<cr>",                  desc = "Quit" },
				{ "<leader>dr",  "<cmd>lua require'dap'.continue()<cr>",               desc = "Run" },
				{ "<leader>dtr", "<cmd>lua require'dap'.repl.toggle()<cr>",            desc = "Toggle Repl" },
				{ "<leader>dtu", "<cmd>lua require'dapui'.toggle({reset = true})<cr>", desc = "Toggle UI" },
			}
			vim.keymap.set('n', '<leader>dB', function()
				dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
			end, { desc = 'Debug: Set Breakpoint' })
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
