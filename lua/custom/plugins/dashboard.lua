return {
	'glepnir/dashboard-nvim',
	event = 'VimEnter',

	config = function()
		local oogway = require("oogway")
		local cow = require("alpha-cowsays-nvim")
		require('dashboard').setup {
			theme = 'hyper',
			config = {
				week_header = {
					enable = false,
				},
				-- header = vim.fn.split(oogway.inspire_me(), "\n"),
				header = cow.cowsays(),
				-- footer = { oogway.what_is_your_wisdom() },
				shortcut = {
					{ desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
					{
						icon = ' ',
						icon_hl = '@variable',
						desc = 'Files',
						group = 'Label',
						action = 'Telescope find_files',
						key = 'f',
					},
					{
						icon = ' ',
						icon_hl = '@variable',
						desc = 'Projects',
						group = 'Number',
						action = 'Telescope projects',
						key = 'p',
					},
					{
						icon = ' ',
						icon_hl = '@variable',
						desc = 'Latest session',
						group = 'Label',
						action = 'SessionLoad',
						key = 'ls',
					},
				},

				project = {
					enable = false,
					limit = 4,
					icon = ' ',
					label = 'Projects',
					action = 'Telescope projects ',
				},
				mru = { limit = 3, cwd_only = false },
			},

		}
	end,
	dependencies = { { 'nvim-tree/nvim-web-devicons' }, "0x5a4/oogway.nvim", "ozthemagician/alpha-cowsays-nvim" }
}
