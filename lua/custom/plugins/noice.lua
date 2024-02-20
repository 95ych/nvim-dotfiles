return
{
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {
		-- add any options here
		messages = {
			-- NOTE: If you enable messages, then the cmdline is enabled automatically.
			-- This is a current Neovim limitation.
			enabled = true, -- enables the Noice messages UI
			view = "virtualtext", -- default view for messages
			view_error = "notify", -- view for errors
			view_warn = "notify", -- view for warnings
			view_history = "messages", -- view for :messages
			view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
		},
	},
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	}
}
