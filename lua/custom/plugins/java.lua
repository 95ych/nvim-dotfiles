return {
	'nvim-java/nvim-java',
	dependencies = {
		'nvim-java/lua-async-await',
		'nvim-java/nvim-java-core',
		'nvim-java/nvim-java-test',
		'nvim-java/nvim-java-dap',
		'MunifTanjim/nui.nvim',
		'neovim/nvim-lspconfig',
		'mfussenegger/nvim-dap',
	},
	config = function()
		require('java').setup(
			{
				jdk = {
					auto_install = false,
				}
			}
		)
		local opts = {
			mode = "n", -- NORMAL mode
			prefix = "<leader>",
			buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
			silent = true, -- use `silent` when creating keymaps
			noremap = true, -- use `noremap` when creating keymaps
			nowait = true, -- use `nowait` when creating keymaps
		}
		local wk = require("which-key")
		-- local mappings = {
		-- 	"j" = {}
		-- }
	end,
}
