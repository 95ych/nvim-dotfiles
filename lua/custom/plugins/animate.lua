return {
	'echasnovski/mini.animate',
	version = '*',
	config = function()
		require('mini.animate').setup({
			cursor = {
				timing = function(_, n) return 1 end,
			},
			scroll = {
				timing = function(_, n) return 1 end,
			}
		})
	end
}
