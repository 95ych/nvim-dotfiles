return {
	'vimwiki/vimwiki',
	config = function()
		vim.g.vimwiki_global_ext = 0
		vim.g.vimwiki_list = {
			{
				auto_export = 1,
				syntax = 'markdown',
				ext = '.md',
			}
		}
	end
}
