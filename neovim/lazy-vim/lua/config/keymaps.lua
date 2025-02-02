-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- delete single character without copying into register
map("n", "x", '"_x')

-- greatest remap ever
map("x", "<leader>p", '"_dP')

map("n", "<leader>gtl", "<cmd>Gitsigns toggle_current_line_blame<cr>") -- toggle current line blame
map("n", "<leader>gth", "<cmd>Gitsigns toggle_linehl<cr>") -- toggle line highlight
map("n", "<leader>gtn", "<cmd>Gitsigns toggle_numhl<cr>") -- toggle number highlight
map("n", "<leader>gtw", "<cmd>Gitsigns toggle_word_diff<cr>") -- toggle word diff
map("n", "<leader>gtd", "<cmd>Gitsigns toggle_deleted<cr>") -- toggle current line blame

-- next greatest remap ever :
-- keymap.set("n", "<leader>y", '"+y')
-- keymap.set("v", "<leader>y", '"+y')
-- -- keymap.set("n", "<leader>Y", '"+Y')
--
-- keymap.set("n", "<leader>d", '"_d')
map("v", "<leader>d", '"_d')

-- Leap.nvim config.
-- map("n", "<leader>l", "<cmd>lua require('telescope').extensions.leap.leap()<CR>")
-- map("n", "<leader>s", "<cmd>lua require('telescope').extensions.leap.leap()<CR>")
-- map("n", "<leader><leader>s", "<Plug>(leap-forward)")
