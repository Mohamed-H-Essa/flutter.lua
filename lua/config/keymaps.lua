-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- Remove LazyVim's default leader+e mapping

vim.keymap.del("n", "<leader>e")
-- vim.keymap.set("n", "<leader>e", "<cmd>call VSCodeNotify('revealInExplorer')<cr>", { desc = "Reveal in File Explorer" })
