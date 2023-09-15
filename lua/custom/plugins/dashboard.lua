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
				},

				project = {
					enable = false,
					limit = 8,
					icon = 'your icon',
					label = '',
					action = 'Telescope find_files cwd=',
				},
			},

		}
	end,
	dependencies = { { 'nvim-tree/nvim-web-devicons' } }
}
