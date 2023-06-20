-- set colorscheme to nightfly with protected call
-- in case it isn't installed

-- -- gruvbox
-- local status, theme = pcall(vim.cmd, "colorscheme gruvbox")
-- if not status then
--   print("Colorscheme not found!") -- print error if colorscheme not installed
--   return
-- end

-- gruvbox-material
local status, theme = pcall(vim.cmd, "colorscheme gruvbox-material")
if not status then
  print("Colorscheme not found!") -- print error if colorscheme not installed
  return
end

-- ondark
local status2, ondark = pcall(vim.cmd, "colorscheme onedark")
if not status2 then
  print("Colorscheme not found!") -- print error if colorscheme not installed
  return
end

-- everforest
local status, theme = pcall(vim.cmd, "colorscheme everforest")
if not status then
  print("Colorscheme not found!") -- print error if colorscheme not installed
  return
end

-- edge
local status, theme = pcall(vim.cmd, "colorscheme edge")
if not status then
  print("Colorscheme not found!") -- print error if colorscheme not installed
  return
end

-- sonokai
local status, theme = pcall(vim.cmd, "colorscheme sonokai")
if not status then
  print("Colorscheme not found!") -- print error if colorscheme not installed
  return
end

-- base16
local status, theme = pcall(vim.cmd, "colorscheme base16-gruvbox-dark-hard")
if not status then
  print("Colorscheme not found!") -- print error if colorscheme not installed
  return
end

vim.cmd("colorscheme gruvbox-material")
-- vim.cmd("let base16colorspace=256")
-- vim.cmd("colorscheme base16-gruvbox-dark-hard")
-- vim.cmd("colorscheme onedark")
-- vim.cmd("colorscheme everforest")
-- vim.cmd("colorscheme edge")
-- vim.cmd("colorscheme sonokai")
