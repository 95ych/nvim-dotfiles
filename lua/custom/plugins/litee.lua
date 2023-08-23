return {
	'ldelossa/litee.nvim',
	'ldelossa/litee-calltree.nvim',
	config = function()
		-- configure the litee.nvim library
		require('litee.lib').setup({})
		-- configure litee-calltree.nvim
		require('litee.calltree').setup({})
	end
}
