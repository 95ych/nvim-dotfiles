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
				java =
				"java $fileName;or set B (basename $dir) and cd $dir and javac  -d . *.java and java $B/$fileNameWithoutExt;",
				-- java = "set B (basename $dir); echo $B",
				python = "python3 -u",
				typescript = "deno run",
				rust = "cd $dir && rustc $fileName && $dir/$fileNameWithoutExt",
				cpp =
				"cd $dir && clang++ --debug $fileName -o $fileNameWithoutExt && $dir/$fileNameWithoutExt"
			},
		})
	end
}
