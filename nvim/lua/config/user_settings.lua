-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
-- vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
-- vim.keymap.set("n", "<Esc>", "<cmd>Noice dismiss<CR>")
vim.keymap.set("n", "<Esc>", function()
	vim.cmd("nohlsearch")
	vim.cmd("Noice dismiss")
end)

-- Diagnostic keymaps
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set("n", "<leader>q", function()
	vim.diagnostic.open_float()
end, { desc = "Open Diagnostics in Float" })
vim.keymap.set("n", "<leader>wd", function()
	require("fzf-lua").diagnostics_workspace()
end, { desc = "Open workspace diagnostic [Q]uickfix list" })
vim.keymap.set("n", "<leader>dd", function()
	require("fzf-lua").diagnostics_document()
end, { desc = "Open document diagnostic [Q]uickfix list" })

-- toggle transparent
vim.keymap.set("n", "<leader>tt", function()
	vim.cmd("TransparentToggle")
end, { desc = "[T]oggle [T]ransparent" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.keymap.set("n", "<leader>cf", function()
	require("conform").format({
		lsp_format = "fallback",
	})
end, { desc = "format" })

-- [[ Themes ]]
vim.o.background = "dark"
-- require("kanagawa")
-- vim.cmd("colorscheme kanagawa")
vim.cmd("colorscheme lushwal")
-- vim.g.everforest_background = "hard"

-- setting lsp for slang shaders
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = "*.slang",
	command = "set filetype=slang",
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "slang" }, -- Replace 'your_language' with the actual filetype
	callback = function()
		vim.lsp.start({
			name = "slangd",
			cmd = { "slangd" }, -- Ensure 'slangd' is in your PATH, or provide the full path
			-- root_dir = vim.fs.dirname(vim.api.nvim_buf_get_name(0)), -- Optional: Define the project root
			capabilities = require("blink-cmp").get_lsp_capabilities(), -- If using nvim-cmp
			-- settings = { ... } -- Optional: Language server specific settings
		})
	end,
})
