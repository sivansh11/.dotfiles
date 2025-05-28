-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<F5>", function()
  require("dap").continue()
end, { desc = "continue or launch" })
vim.keymap.set("n", "<F10>", function()
  require("dap").step_over()
end, { desc = "step_over" })
vim.keymap.set("n", "<F11>", function()
  require("dap").step_into()
end, { desc = "step_into" })
vim.keymap.set("n", "<F23>", function()
  require("dap").step_out()
end, { desc = "step_out" })
vim.keymap.set("n", "<F9>", function()
  require("dap").toggle_breakpoint()
end, { desc = "toggle_breakpoint" })

vim.keymap.set({ "n", "t" }, "<C-[><C-[>", Snacks.terminal.toggle, { desc = "toggle terminal" })

-- vim.keymap.set("n", "<leader>t", Snacks.terminal.toggle, { desc = "toggle terminal" })
