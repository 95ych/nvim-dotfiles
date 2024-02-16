return {
	"nvim-neotest/neotest",
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-java")({
					dap = { justMyCode = false },
				}),
				require("neotest-plenary"),
				require("neotest-vim-test")({ ignore_filetypes = { "python", "lua" } }),
			},
		})
	end,
	dependencies = {
		"nvim-neotest/neotest-vim-test",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"nvim-neotest/neotest-plenary",
	}
}
