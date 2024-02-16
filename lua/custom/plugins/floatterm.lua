return {
	'voldikss/vim-floaterm',
	vim.keymap.set("n", "<leader>tt", "<cmd>FloatermNew<CR>", { noremap = true, silent = true }),
	vim.api.nvim_set_keymap('t', '<Leader><ESC>', '<C-\\><C-n>', { noremap = true })

}
