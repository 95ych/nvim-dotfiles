return {
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
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			-- dap.listeners.before.event_terminated["dapui_config"] = function()
			-- 	dapui.close()
			-- end
			-- dap.listeners.before.event_exited["dapui_config"] = function()
			-- 	dapui.close()
			-- end
			dap.adapters.executable = {
				type = 'executable',
				command = vim.fn.stdpath("data") .. '/mason/bin/codelldb',
				name = 'lldb1',
				host = '127.0.0.1',
				port = 13000
			}
			dap.configurations.cpp = {
				-- 	{
				-- 	name = "lldb",
				-- 	type = "executable",
				-- 	request = "launch"
				-- }
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
	{
		"mfussenegger/nvim-dap",
	},
}
