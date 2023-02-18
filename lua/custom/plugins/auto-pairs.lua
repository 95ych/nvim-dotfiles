return {
	"windwp/nvim-autopairs",
	config = function()
		require("nvim-autopairs").setup({
			map_c_h = true,
			enable_check_bracket_line = false,
			enable_moveright = false,
			fast_wrap = {
				map = '<C-i>',
				chars = { '{', '[', '(', '"', "'" },
				pattern = [=[[%'%"%>%]%)%}%,]]=],
				end_key = 'l',
				keys = 'qwertyuiopzxcvbnmasdfghjk',
				check_comma = true,
				highlight = 'Search',
				highlight_grey = 'Comment'
			},
		})
	end
}
