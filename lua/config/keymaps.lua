-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- vim.keymap.set("n", "F", "<Nop>")
-- Window resizing with Meta/Option + hjkl (5 units at a time)
vim.keymap.set("n", "<M-h>", ":vertical resize -5<CR>", { desc = "Decrease window width", silent = true })
vim.keymap.set("n", "<M-l>", ":vertical resize +5<CR>", { desc = "Increase window width", silent = true })
vim.keymap.set("n", "<M-j>", ":resize -5<CR>", { desc = "Decrease window height", silent = true })
vim.keymap.set("n", "<M-k>", ":resize +5<CR>", { desc = "Increase window height", silent = true })
-- finer increments
vim.keymap.set("n", "<M-H>", ":vertical resize -1<CR>", { desc = "Decrease window width", silent = true })
vim.keymap.set("n", "<M-L>", ":vertical resize +1<CR>", { desc = "Increase window width", silent = true })
vim.keymap.set("n", "<M-J>", ":resize -1<CR>", { desc = "Decrease window height", silent = true })
vim.keymap.set("n", "<M-K>", ":resize +1<CR>", { desc = "Increase window height", silent = true })
