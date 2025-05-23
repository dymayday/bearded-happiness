-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Neovim options

if vim.g.neovide then
  -- Put anything you want to happen only in Neovide here
  vim.g.neovide_cursor_vfx_mode = "railgun"
  -- vim.g.neovide_cursor_vfx_mode = "torpedo"
  -- vim.g.neovide_cursor_vfx_mode = "pixiedust"
  vim.o.guifont = "FiraCode Nerd Font" -- text below applies for VimScript
  -- vim.o.guifont = "Source Code Pro:h14" -- text below applies for VimScript
end

-- -- Set color scheme to tokyonight-storm for Markdown files
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "markdown",
--   callback = function()
--     vim.cmd("colorscheme tokyonight-storm")
--   end,
-- })
