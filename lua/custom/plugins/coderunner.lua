return {
	"CRAG666/code_runner.nvim",
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
