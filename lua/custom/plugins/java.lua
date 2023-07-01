return {

	'williamboman/nvim-lsp-installer',
	'mfussenegger/nvim-jdtls',
	'artur-shaik/jc.nvim',
	config = function()
		require('jc').setup {}
	end
}
