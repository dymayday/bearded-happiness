-- set colorscheme to nightfly with protected call
-- in case it isn't installed

-- -- gruvbox
-- local status, theme = pcall(vim.cmd, "colorscheme gruvbox")
-- if not status then
--   print("Colorscheme not found!") -- print error if colorscheme not installed
--   return
-- end

-- ondark
local status2, ondark = pcall(vim.cmd, "colorscheme onedark")
if not status2 then
  print("Colorscheme not found!") -- print error if colorscheme not installed
  return
end

-- vim.cmd("colorscheme onedark")
