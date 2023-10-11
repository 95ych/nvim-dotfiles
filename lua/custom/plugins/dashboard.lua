return {
	'glepnir/dashboard-nvim',
	event = 'VimEnter',
	config = function()
		require('dashboard').setup {
			theme = 'hyper',
			config = {
				week_header = {
					enable = true,
				},
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
			},

		}
	end,
	dependencies = { { 'nvim-tree/nvim-web-devicons' } }
}
