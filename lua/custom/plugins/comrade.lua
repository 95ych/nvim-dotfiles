return {
	'Shougo/deoplete.nvim',
	run = ':UpdateRemotePlugins',
	requires = {
		'roxma/nvim-yarp',
		'roxma/vim-hug-neovim-rpc',
		run = 'pip install -r requirements.txt'
	},
	config = function()
		require('user.plugin_options.deoplete')
	end,
	'beeender/Comrade'
}
