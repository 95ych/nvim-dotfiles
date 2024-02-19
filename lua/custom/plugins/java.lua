return {
	'nvim-java/nvim-java',
	dependencies = {
		'nvim-java/lua-async-await',
		'nvim-java/nvim-java-core',
		'nvim-java/nvim-java-test',
		'nvim-java/nvim-java-dap',
		'MunifTanjim/nui.nvim',
		'neovim/nvim-lspconfig',
		'mfussenegger/nvim-dap',
		{
			'williamboman/mason.nvim',
			opts = {
				registries = {
					'github:nvim-java/mason-registry',
					'github:mason-org/mason-registry',
				},
			},
		}
	},
	config = function()
		local on_attach = function(client, bufnr)
			local augroup_id = vim.api.nvim_create_augroup(
				"FormatModificationsDocumentFormattingGroup",
				{ clear = false }
			)
			vim.api.nvim_clear_autocmds({ group = augroup_id, buffer = bufnr })
			vim.api.nvim_create_autocmd(
				{ "BufWritePre" },
				{
					group = augroup_id,
					buffer = bufnr,
					callback = function()
						local lsp_format_modifications = require "lsp-format-modifications"
						lsp_format_modifications.format_modifications(client, bufnr)
					end,
				}
			)
		end
		require('java').setup()
		require('lspconfig').jdtls.setup({
			on_attach = on_attach,
		})
	end
}
