return {
	'glepnir/dbsession.nvim',
	cmd = { 'SessionSave', 'SessionDelete', 'SessionLoad' },
	opts = {
		auto_save_on_exit = true
	},
	vim.keymap.set("n", "<leader>sl", "<cmd>SessionLoad<CR>", { noremap = true, silent = true }),
}
