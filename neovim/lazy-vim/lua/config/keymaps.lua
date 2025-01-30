-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- delete single character without copying into register
map("n", "x", '"_x')
-- keymap.set("n", "x", '"_x')
--
-- greatest remap ever
map("x", "<leader>p", '"_dP')

-- next greatest remap ever :
-- keymap.set("n", "<leader>y", '"+y')
-- keymap.set("v", "<leader>y", '"+y')
-- -- keymap.set("n", "<leader>Y", '"+Y')
--
-- keymap.set("n", "<leader>d", '"_d')
-- keymap.set("v", "<leader>d", '"_d')

-- Leap.nvim config.
-- map("n", "<leader>l", "<cmd>lua require('telescope').extensions.leap.leap()<CR>")
-- map("n", "<leader>s", "<cmd>lua require('telescope').extensions.leap.leap()<CR>")
-- map("n", "<leader><leader>s", "<Plug>(leap-forward)")
