-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps
---------------------

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>")

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- delete single character without copying into register
keymap.set("n", "x", '"_x')

-- greatest remap ever
keymap.set("x", "<leader>p", '"_dP')

-- next greatest remap ever : asbjornHaland
keymap.set("n", "<leader>y", '"+y')
keymap.set("v", "<leader>y", '"+y')
-- keymap.set("n", "<leader>Y", '"+Y')

keymap.set("n", "<leader>d", '"_d')
keymap.set("v", "<leader>d", '"_d')

-- Set line wrap
keymap.set("n", "<leader>lw", ":set wrap!<CR>")

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>") -- increment
keymap.set("n", "<leader>-", "<C-x>") -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
keymap.set("n", "<leader>ss", "<C-w>s") -- split window horizontally
keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width & height
keymap.set("n", "<leader>sx", ":close<CR>") -- close current split window

-- tab management
keymap.set("n", "<leader>to", ":tabnew<CR>") -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
keymap.set("n", "<leader>tn", ":tabn<CR>") --  go to next tab
keymap.set("n", "<leader>tp", ":tabp<CR>") --  go to previous tab

-- Insert a semicolon at the end of the line.
keymap.set("i", "<M-;>", "<C-c>A;")
keymap.set("n", "<M-;>", "<C-c>A;<C-c>")

-- Search & jump motion
keymap.set("n", "<C-u>", "<C-u>zz") -- Half page up & center
keymap.set("n", "<C-d>", "<C-d>zz") -- Half page down & center
keymap.set("n", "<C-b>", "<C-b>zz") -- Page up & center
keymap.set("n", "<C-f>", "<C-f>zz") -- Page down & center
keymap.set("n", "n", "nzz") -- Search & center
keymap.set("n", "N", "Nzz") -- Reverse seach & center

----------------------
-- Plugin Keybinds
----------------------

-- vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>") -- toggle split window maximization
keymap.set("n", "<leader>z", ":MaximizerToggle<CR>") -- toggle split window maximization

-- move a line around
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>") -- toggle file explorer
-- keymap.set("n", "<C-s>", ":nvim-tree-api.node.open.horizontal()<CR>") -- toggle file explorer

-- Undo tree
keymap.set("n", "<leader>u", ":UndotreeToggle<CR>")

-- telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
-- keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
keymap.set("n", "<leader>bfs", "<cmd>Telescope current_buffer_fuzzy_find<cr>") -- find string in current buffer
keymap.set("n", "<leader>fc", "<cmd>Telescope current_buffer_fuzzy_find<cr>") -- find string in current buffer
-- keymap.set("n", "<leader>ft", "<cmd>Telescope current_buffer_tags<cr>") -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags
keymap.set("n", "<leader>fo", "<cmd>Telescope lsp_document_symbols<cr>") -- list available symbols in the current file
keymap.set("n", "<leader>fwo", "<cmd>Telescope lsp_workspace_symbols<cr>") -- list available symbols in the worskpace file
keymap.set("n", "<leader>fr", "<cmd>Telescope lsp_references<cr>") -- list available references in the worskpace.
keymap.set("n", "<leader>fi", "<cmd>Telescope lsp_implementations<cr>") -- list available implementations in the worskpace.
keymap.set("n", "<leader>fe", "<cmd>Telescope lsp_definitions<cr>") -- go to definition.
keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>") -- list available diagnostics in the worskpace.
-- telescope git commands (not on youtube nvim video)
keymap.set("n", "<leader>gf", "<cmd>Telescope git_files<cr>") -- List files tracked by git.
keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>") -- list all git commits (use <cr> to checkout) ["gc" for git commits]
keymap.set("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>") -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>") -- list git branches (use <cr> to checkout) ["gb" for git branch]
keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>") -- list current changes per file with diff preview ["gs" for git status]
keymap.set("n", "<leader>km", "<cmd>Telescope keymaps<cr>") -- list current changes per file with diff preview ["gs" for git status]

-- Gitsigns
keymap.set("n", "<leader>gtb", "<cmd>Gitsigns toggle_current_line_blame<cr>") -- toggle current line blame
keymap.set("n", "<leader>gtn", "<cmd>Gitsigns toggle_numhl<cr>") -- toggle number highlight
keymap.set("n", "<leader>gtl", "<cmd>Gitsigns toggle_linehl<cr>") -- toggle line highlight
keymap.set("n", "<leader>gtw", "<cmd>Gitsigns toggle_word_diff<cr>") -- toggle word diff
keymap.set("n", "<leader>gtd", "<cmd>Gitsigns toggle_deleted<cr>") -- toggle current line blame

keymap.set("n", "<leader>tr", "<cmd>Lspsaga term_toggle<cr>") -- list current changes per file with diff preview ["gs" for git status]

-- restart lsp server (not on youtube nvim video)
keymap.set("n", "<leader>rs", ":LspRestart<CR>") -- mapping to restart lsp if necessary

-- buffer
keymap.set("n", "<leader>bd", "<cmd>bd<cr>") -- delete the current buffer

-- lsp-signature
keymap.set({ "n" }, "<C-k>", function()
  require("lsp_signature").toggle_float_win()
end, { silent = true, noremap = true, desc = "toggle signature" })

keymap.set({ "n" }, "<Leader>k", function()
  vim.lsp.buf.signature_help()
end, { silent = true, noremap = true, desc = "toggle signature" })

-- -- diagnostic
-- keymap.set("n", "[d", function()
--   vim.diagnostic.goto_next()
-- end)
-- keymap.set("n", "]d", function()
--   vim.diagnostic.goto_prev()
-- end)

-- get the help of a function signature
keymap.set("i", "<C-h>", function()
  vim.lsp.buf.signature_help()
end)

-- keymap.set("n", "<leader>vws", function()
--   vim.lsp.buf.workspace_symbol()
-- end)

-- harpoon Keymaps
local silent = { silent = false }
-- Add mark to the current file, at the current position.
keymap.set("n", "<leader>a", function()
  require("harpoon.mark").add_file()
end, silent)
-- Open the Harpoon UI.
keymap.set("n", "<leader>w", function()
  require("harpoon.ui").toggle_quick_menu()
end, silent)
-- -- Jump to the next harpoon.
-- keymap.set("n", "<leader>wx", function()
--   require("harpoon.ui").nav_next()
-- end, silent)
-- -- Jump to the rpvious harpoon.
-- keymap.set("n", "<leader>ws", function()
--   require("harpoon.ui").nav_prev()
-- end, silent)

-- -- Leap mapping.
-- keymap.set("n", "<leader><leader>f", "<Plug>(leap-forward-to)")
-- keymap.set("n", "<leader><leader>F", "<Plug>(leap-backward-to)")
-- keymap.set("n", "<leader><leader>t", "<Plug>(leap-forward-till)")
-- keymap.set("n", "<leader><leader>T", "<Plug>(leap-backward-till)")
