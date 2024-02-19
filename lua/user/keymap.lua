vim.keymap.set("n", "H", function()
	local current_column = vim.fn.col(".")
	if current_column == 1 then
		vim.cmd.normal("_")
	else
		vim.fn.cursor(".", 1)
	end
end, { silent = true })
vim.keymap.set("n", "L", function()
	local current_column = vim.fn.col(".")
	local end_column = vim.fn.col("$") - 1
	if current_column == end_column then
		vim.cmd.normal("g_")
	else
		vim.fn.cursor(".", end_column)
	end
end, { silent = true })

--Navigation
vim.keymap.set("i", "<C-l>", "<Right>", { silent = true })
-- Spell checking
vim.keymap.set("n", "<Leader>sc", ":set spell!<CR>", { silent = true })

-- NeoTree
vim.keymap.set("n", "<Leader>f", ":Neotree toggle<CR>", { silent = true })
--NavBuddy
vim.keymap.set("n", "<Leader>nb", ":Navbuddy<CR>", { silent = true })

--Write
vim.keymap.set({ "n" }, "<C-s>", ":w<CR>", { silent = true })

--CodeRunner
vim.keymap.set("n", "<Leader>rr", ":RunCode<CR>", { silent = true })
vim.keymap.set("n", "<Leader>rp", ":RunProject<CR>", { silent = true })

--dap

-- System clipboard
vim.keymap.set({ "n", "v" }, "<Leader>y", [["+y]], { silent = true })
vim.keymap.set({ "n", "v" }, "<Leader>p", [["+p]], { silent = true })

--Barbar
vim.keymap.set('n', '<C-p>', '<Cmd>BufferPick<CR>', { silent = true })
vim.keymap.set('n', '<C-c>', '<Cmd>BufferClose<CR>', { silent = true })

-- Leap
-- vim.keymap.del({ 'x', 'o' }, 'x')
-- vim.keymap.del({ 'x', 'o' }, 'X')
