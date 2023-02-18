-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
	{ "nvim-neo-tree/neo-tree.nvim",
		version = "*",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		config = function()
			-- Unless you are still migrating, remove the deprecated commands from v1.x
			vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
			require('neo-tree').setup {}
		end,
	},
	{ "CRAG666/code_runner.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require('code_runner').setup({
				-- put here the commands by filetype
				mode = "float",
				focus = "true",
				startinsert = true,
				float = {
					close_key = '<ESC>',
					blend = 0,
					border = "double"
				},
				filetype = {
					java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
					python = "python3 -u",
					typescript = "deno run",
					rust = "cd $dir && rustc $fileName && $dir/$fileNameWithoutExt",
					cpp = "cd $dir && g++ -std=c++17 $fileName && $dir/$fileNameWithoutExt"
				},
			})
		end
	}
}
