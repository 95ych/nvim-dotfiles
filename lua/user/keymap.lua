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
vim.keymap.set("n", "<Leader>o", ":Navbuddy<CR>", { silent = true }) --Outline symbols

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
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Move to previous/next
map('n', '[b', '<Cmd>BufferPrevious<CR>', opts)
map('n', ']b', '<Cmd>BufferNext<CR>', opts)
-- Goto buffer in position...
map('n', '<Leader>bf', '<Cmd>BufferGoto 1<CR>', opts)
map('n', '<Leader>bl', '<Cmd>BufferLast<CR>', opts)
-- Pin/unpin buffer
map('n', '<Leader>bp', '<Cmd>BufferPin<CR>', opts)
-- Sort automatically by...
-- Leap
-- vim.keymap.del({ 'x', 'o' }, 'x')
-- vim.keymap.del({ 'x', 'o' }, 'X')
